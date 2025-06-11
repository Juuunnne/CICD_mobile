# CI/CD Pipeline

This repository contains a Node.js project with a complete CI/CD pipeline implemented using GitHub Actions.

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
