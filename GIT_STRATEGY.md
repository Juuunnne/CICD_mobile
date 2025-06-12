# Git Strategy

This document describes how we manage branches, create features, and write commits in this repository.

---

## 1. Branching Model

We follow a **trunk-based** workflow with two long-lived branches:

| Branch | Purpose |
| ------ | ------- |
| `master` | Production-ready code. Only fast-forward merges from `develop` (via PR) are permitted. Triggers the release pipeline. |
| `develop` | Ongoing development. All feature branches are merged here via Pull Requests (PR). |

```
master ──► (releases)
   ▲
   │  merge PRs
 develop ◄── feature/my-feature
```

### 1.1 Feature Branches

• **Naming:** `feature/<ticket-id>-<slug>` (e.g. `feature/123-login-screen`).  
• **Created from:** the latest `develop`.  
• **Scope:** One logical change (small & focused).  
• **Lifecycle:**
1. `git checkout develop && git pull`
2. `git checkout -b feature/123-login-screen`
3. Commit work (**see commit format below**).
4. Open a PR **into `develop`**.  
5. When approved & CI passes, squash-merge.

> **Tip:** For hot-fixes on production, create `hotfix/<description>` from `master`, merge back to both `master` and `develop`.

---

## 2. Commit Message Format

We use [Conventional Commits](https://www.conventionalcommits.org/) so that tools (lint-staged, changelog, release) can parse history automatically.

```
<type>(optional scope): <short summary>

[optional body]
[optional footer]
```

### 2.1 Types

* **feat** – new feature
* **fix** – bug fix
* **docs** – documentation only changes
* **style** – formatting, missing semi-colons, etc. (no code change)
* **refactor** – code change that neither fixes a bug nor adds a feature
* **test** – adding or fixing tests
* **chore** – tooling, build, CI, dependencies, etc.
* **ci** – CI/CD related changes

### 2.2 Examples

```
feat(auth): add OAuth login flow
fix(todo): prevent crash on empty title
docs: add API usage section to README
```

### 2.3 Rules

1. **Imperative mood**: "add", "fix", not "added", "fixed".  
2. Max 72 chars in the subject.  
3. Reference tickets in footer if needed: `Closes #123`.

---

## 3. Pull Requests

* Open PRs from **feature ➜ develop** or **develop ➜ master**.
* All PRs must:
  * Pass **CI checks** (lint, tests).  
  * Have at least **one approval**.
  * Use **squash merge** to keep a linear history.

---

## 4. Special CI Triggers

On occasion, you may need to manually trigger a specific CI job that doesn't run on every commit. You can do this by including a specific flag in your **commit message**.

| Flag | Workflow Triggered | Job |
|---|---|---|
| `[test-backend]` | `Backend CI` | Runs the full suite of backend linting and tests. |
| `[build-mobile]` | `Mobile App CI` | Runs the Expo SDK prebuild (`mobile-build-sdk`) after the tests pass. |

**Example commit message:**
```
feat(profile): add user avatar upload

[build-mobile]
```

---

## 5. Releases

* Merging `develop` → `master` triggers the release workflow (`release-tag.yml`).
* Versioning handled by **standard-version** based on commit history.

---

Happy coding! :rocket: 