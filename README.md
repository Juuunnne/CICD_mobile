# CI/CD Pipeline Project

This project demonstrates a full CI/CD pipeline, including automated testing, versioning, and changelog generation. It now includes a mobile to-do list application built with Expo.

## Getting Started

### Prerequisites

- Node.js
- npm

### Installation

1.  Clone the repository
2.  Install the dependencies:
    ```bash
    npm install
    ```
    This will also install the dependencies for the mobile app.

## Available Scripts

### Root Project

-   `npm start`: Starts the server.
-   `npm run dev`: Starts the server in development mode with nodemon.
-   `npm test`: Runs tests with Jest.
-   `npm run lint`: Lints the code with ESLint.
-   `npm run release`: Creates a new release (increments version, creates tag, updates changelog).

### Mobile App

You can run the mobile app from the root directory using the following commands:

-   `npm run mobile:start`: Starts the Expo development server.
-   `npm run mobile:android`: Starts the app on a connected Android device or emulator.
-   `npm run mobile:ios`: Starts the app on the iOS simulator (macOS only).
-   `npm run mobile:web`: Starts the app in a web browser.
-   `npm run mobile:lint`: Lints the mobile app's code.

## To-Do List App

The included application is a simple to-do list that runs on iOS, Android, and the web. You can add, complete, and delete tasks.

## Automated Release Tag Builds

This project includes automated release tag creation and builds through two workflows:

### 1. CI/CD Pipeline Workflow

The main CI/CD workflow (`ci-cd.yml`) runs when changes are pushed to the master branch:

1. Tests the code
2. Builds the project
3. Automatically creates a new version using standard-version
4. Updates CHANGELOG.md based on conventional commits
5. Creates a new git tag
6. Pushes the tag to GitHub
7. Creates a GitHub Release with the built artifacts

### 2. Release Tag Build Workflow

The Release Tag Build workflow (`release-tag.yml`) runs when a tag is pushed:

1. Builds the project specifically for the release
2. Creates a GitHub Release with the artifacts

### Manual Version Release

You can also manually trigger a version release:

```bash
# Release a patch version (1.0.0 -> 1.0.1)
npm run release:patch

# Release a minor version (1.0.0 -> 1.1.0)
npm run release:minor

# Release a major version (1.0.0 -> 2.0.0)
npm run release:major

# Standard release (automatic version bump based on commits)
npm run release
```

After running any of these commands locally, push the changes and tags with:

```bash
git push --follow-tags origin master
```

This will trigger the Release Tag Build workflow.

## Rollback a Release

If a release introduces a critical bug, you can roll it back using the provided scripts. This will delete the Git tag from the remote repository, which will remove the associated GitHub Release, and revert the release commit on the `main` branch.

**Usage:**

```bash
# For Linux/macOS
./rollback.sh v1.2.3

# For Windows
.\rollback.bat v1.2.3
```

Replace `v1.2.3` with the version you want to roll back. The script will ask for confirmation before proceeding.

**Important:** This only reverts the Git history. If the broken version was deployed, you might need to manually redeploy a previous stable version.
