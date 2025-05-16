# setup-scripts

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Status: Minimalist](https://img.shields.io/badge/Status-Minimalist-blue.svg)](https://en.wikipedia.org/wiki/Minimalism)
[![Scripts: Setup Ready](https://img.shields.io/badge/Scripts-Setup%20Ready-success)](#usage)

Minimal reusable setup scripts and planning templates for clean, safe project initialization.

---

## Purpose

This repository provides small, focused scripts to help initialize new projects quickly, safely, and cleanly.

It is designed for speed, minimalism, and serious development hygiene.

---

## Included

## Git Hooks Setup

Hooks are automatically installed to prevent direct commits to `main` branch and provide basic checks.

### Bypassing Hooks

If you need to bypass hooks manually (e.g., emergency commits, migrations), you can use:

```bash
git commit --no-verify
git push --no-verify

- **Planning Template**  
  Reusable checklist structure for starting clean project goals (`templates/planning-template.md`).

- **Templates Philosophy**  
  Guidance for using templates responsibly without overengineering (`templates/README.md`).

---

## Usage

To quickly initialize local git safety and planning:

### 1. Install Git Hooks Setup Script (automated)

```bash
npx github:dmitriz/setup-scripts hooks-setup.sh
```

This script will:

- Install native git hooks if missing
- Set up pre-commit enforcement
- Verify the setup automatically by testing a failing commit

✅ No manual setup needed.

---

### 2. Create Project Planning Template

```bash
cp templates/planning-template.md planning.md
```

Edit `planning.md` to match your project's objectives and tasks.

---

## Directory Structure

```plaintext
setup-scripts/
├── LICENSE
├── planning.md
├── templates/
│   ├── planning-template.md
│   └── README.md
├── hooks-setup.sh
├── .gitignore
├── README.md
├── package.json
```

---

## License

This project is licensed under the [MIT License](LICENSE).

---

## Philosophy

- **Minimalism First**: Focus only on necessary structure.
- **Automation Preferred**: Eliminate manual repetitive tasks.
- **Flexibility**: Provide building blocks, not rigid systems.
- **Safety by Default**: Protect projects early from mistakes.

---
