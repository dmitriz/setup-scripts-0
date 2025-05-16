#!/bin/bash

mkdir -p .git/hooks

echo '#!/bin/bash
branch=$(git symbolic-ref --short HEAD)
if [ "$branch" = "main" ]; then
  echo -e "\033[0;35mDirect commits to main are not allowed.\033[0m"
  exit 1
fi' > .git/hooks/pre-commit

chmod +x .git/hooks/pre-commit
