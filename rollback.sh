#!/bin/bash

# This script rolls back a release by deleting the Git tag and reverting the release commit.

# Exit on error
set -e

# --- Configuration ---
REMOTE_NAME="origin"
MAIN_BRANCH="main"

# --- Functions ---

# Function to print usage
usage() {
  echo "Usage: $0 <version>"
  echo "  <version>: The version to roll back (e.g., v1.2.3)."
  exit 1
}

# --- Script ---

# 1. Check for version argument
VERSION=$1
if [ -z "$VERSION" ]; then
  echo "Error: No version specified."
  usage
fi

# 2. Check for clean working directory
if [ -n "$(git status --porcelain)" ]; then
  echo "Error: Working directory is not clean. Please commit or stash your changes."
  exit 1
fi

echo "Fetching latest data from remote..."
git fetch $REMOTE_NAME

# 3. Verify the tag exists locally and remotely
if ! git tag -l | grep -q "^$VERSION$"; then
  echo "Error: Tag $VERSION does not exist locally."
  exit 1
fi
if ! git ls-remote --tags $REMOTE_NAME | grep -q "refs/tags/$VERSION$"; then
  echo "Error: Tag $VERSION does not exist on remote '$REMOTE_NAME'."
  exit 1
fi

# 4. Find the release commit
# standard-version commits have a predictable message format.
# We will look for "chore(release):" followed by the version number without the "v".
VERSION_NUMBER=${VERSION#v}
COMMIT_HASH=$(git log --grep="chore(release): $VERSION_NUMBER" --pretty=format:"%H" -n 1)

if [ -z "$COMMIT_HASH" ]; then
  echo "Error: Could not find the release commit for version $VERSION."
  echo "Looked for commit with message: 'chore(release): $VERSION_NUMBER'"
  exit 1
fi

echo "Found release commit:"
git show --no-patch --pretty=oneline $COMMIT_HASH

# 5. Ask for confirmation
echo ""
echo "You are about to perform the following actions:"
echo "  1. Delete tag '$VERSION' from remote '$REMOTE_NAME'."
echo "  2. Delete tag '$VERSION' locally."
echo "  3. Revert commit '$COMMIT_HASH' on branch '$MAIN_BRANCH'."
echo "  4. Push the revert to '$REMOTE_NAME/$MAIN_BRANCH'."
echo ""
read -p "Are you sure you want to continue? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Rollback cancelled."
  exit 0
fi

# 6. Delete the remote tag
echo "Deleting remote tag $VERSION..."
git push $REMOTE_NAME --delete $VERSION

# 7. Delete the local tag
echo "Deleting local tag $VERSION..."
git tag -d $VERSION

# 8. Revert the commit
echo "Reverting commit $COMMIT_HASH..."
# --no-edit prevents the editor from opening for the revert commit message
git revert --no-edit $COMMIT_HASH

# 9. Push the revert
echo "Pushing revert to $REMOTE_NAME/$MAIN_BRANCH..."
git push $REMOTE_NAME HEAD:$MAIN_BRANCH

echo ""
echo "Rollback of version $VERSION completed successfully!"
echo "Please ensure any deployments of $VERSION are rolled back manually if they were not automated." 