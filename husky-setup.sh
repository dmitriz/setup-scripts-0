#!/bin/bash

set -e

echo "🔧 Setting up Husky pre-commit protection..."

# Save the current branch
current_branch_before_test=$(git symbolic-ref --short HEAD 2>/dev/null || echo "")

trap cleanup EXIT

cleanup() {
  echo "🔧 Cleaning up temporary test files and branches..."
  rm -f husky_temp_test_file.txt 2>/dev/null || true
  git reset --hard HEAD 2>/dev/null || true
  if [ -n "$current_branch_before_test" ]; then
    git checkout "$current_branch_before_test" 2>/dev/null || true
  else
    echo "⚠️ Warning: Could not detect original branch. Staying detached."
  fi
  git branch -D husky-test-temp 2>/dev/null || true
}

# Initialize Git if not already initialized
if [ ! -d ".git" ]; then
  echo "🔧 No Git repo found. Initializing Git..."
  git init
fi

# Create .husky directory manually if missing
mkdir -p .husky

# Set Git to use .husky as hooks directory
git config core.hooksPath .husky

# Create pre-commit hook
cat > .husky/pre-commit <<'EOF'
#!/bin/sh

# Run tests only if 'test' script exists
if npm run | grep -q "test"; then
  npm run test || exit 1
fi

# Block commits directly to main branch
current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)
if [ "$current_branch" = "main" ]; then
  echo "⛔ Direct commits to 'main' are not allowed. Please create a feature branch."
  exit 1
fi

# Block commits when HEAD is detached
if [ -z "$current_branch" ]; then
  echo "⛔ Cannot commit in detached HEAD state. Please checkout a branch."
  exit 1
fi
EOF

# Make pre-commit hook executable
chmod +x .husky/pre-commit

echo "✅ Husky pre-commit hook created successfully."

# Test the protection immediately
echo "🔍 Verifying pre-commit protection..."

# Delete old temp branch if it exists
if git rev-parse --verify husky-test-temp >/dev/null 2>&1; then
  echo "⚠️ Previous husky-test-temp branch found. Deleting..."
  git branch -D husky-test-temp
fi

# Create fresh temp branch
git checkout -b husky-test-temp

# Try to commit a dummy bad commit
echo "Temporary test" > husky_temp_test_file.txt
git add husky_temp_test_file.txt

if git commit -m "bad commit for test" > /dev/null 2>&1; then
  echo "❌ Pre-commit hook failed to block bad commit."
  exit 1
else
  echo "✅ Pre-commit hook correctly blocked bad commit."
fi

echo "✅ Local Git repo is fully protected by Husky!"
