#!/bin/bash

# Script to update package version, changelog, and publish to pub.dev
# Usage: ./update_version.sh [major|minor|patch] [changelog message]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get current version from pubspec.yaml
CURRENT_VERSION=$(grep '^version:' pubspec.yaml | sed 's/version: //' | sed 's/+.*//')
echo -e "${GREEN}Current version: ${CURRENT_VERSION}${NC}"

# Parse version
IFS='.' read -ra VERSION_PARTS <<< "$CURRENT_VERSION"
MAJOR=${VERSION_PARTS[0]}
MINOR=${VERSION_PARTS[1]}
PATCH=${VERSION_PARTS[2]}

# Determine version bump type
BUMP_TYPE=${1:-patch}
CHANGELOG_MSG=${2:-""}

case $BUMP_TYPE in
  major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    ;;
  minor)
    MINOR=$((MINOR + 1))
    PATCH=0
    ;;
  patch)
    PATCH=$((PATCH + 1))
    ;;
  *)
    echo -e "${RED}Error: Invalid bump type. Use: major, minor, or patch${NC}"
    exit 1
    ;;
esac

NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"
echo -e "${GREEN}New version: ${NEW_VERSION}${NC}"

# Update pubspec.yaml
echo -e "${YELLOW}Updating pubspec.yaml...${NC}"
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  sed -i '' "s/^version: .*/version: ${NEW_VERSION}/" pubspec.yaml
else
  # Linux
  sed -i "s/^version: .*/version: ${NEW_VERSION}/" pubspec.yaml
fi

# Update CHANGELOG.md
echo -e "${YELLOW}Updating CHANGELOG.md...${NC}"
TODAY=$(date +%Y-%m-%d)

if [ -z "$CHANGELOG_MSG" ]; then
  CHANGELOG_MSG="Update to version ${NEW_VERSION}"
fi

# Create changelog entry
CHANGELOG_ENTRY="## [${NEW_VERSION}] - ${TODAY}

### Changed
- ${CHANGELOG_MSG}
"

# Insert after the Changelog header
# Create temporary file with new changelog entry
TEMP_CHANGELOG=$(mktemp)
{
  head -n 1 CHANGELOG.md
  echo ""
  echo "$CHANGELOG_ENTRY"
  tail -n +2 CHANGELOG.md
} > "$TEMP_CHANGELOG"
mv "$TEMP_CHANGELOG" CHANGELOG.md

# Commit changes
echo -e "${YELLOW}Committing changes...${NC}"
git add pubspec.yaml CHANGELOG.md
git commit -m "Bump version to ${NEW_VERSION}" || echo "No changes to commit or already committed"

# Push to GitHub
echo -e "${YELLOW}Pushing to GitHub...${NC}"
git push origin main || echo "Push failed or already up to date"

# Dry run first
echo -e "${YELLOW}Running dry-run...${NC}"
flutter pub publish --dry-run

# Ask for confirmation
echo -e "${YELLOW}Do you want to publish version ${NEW_VERSION} to pub.dev? (y/n)${NC}"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  echo -e "${GREEN}Publishing to pub.dev...${NC}"
  flutter pub publish
  echo -e "${GREEN}✅ Successfully published version ${NEW_VERSION} to pub.dev!${NC}"
else
  echo -e "${YELLOW}Publishing cancelled. Changes are committed locally.${NC}"
fi

