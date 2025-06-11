#!/bin/bash

# Exit on error
set -e

# Check if the working directory is clean
if [ -n "$(git status --porcelain)" ]; then
  echo "Error: Working directory is not clean. Please commit or stash your changes."
  exit 1
fi

# Determine release type from argument (default to patch)
RELEASE_TYPE=${1:-patch}
echo "Preparing $RELEASE_TYPE release..."

# Run tests
echo "Running tests..."
npm test

# Run linting
echo "Running linting..."
npm run lint

# Create new version
echo "Creating new version..."
npm run release:$RELEASE_TYPE

# Get the new version from package.json
VERSION=$(node -p "require('./package.json').version")
echo "Version $VERSION created."

# Push changes and tags
echo "Pushing changes and tags..."
git push --follow-tags origin main

echo "Release $VERSION completed successfully!"
echo "Changelog has been updated."
echo "A new Git tag v$VERSION has been created."
echo "Changes have been pushed to the repository."
