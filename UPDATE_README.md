# Version Update Script

This script automates the process of updating the package version, changelog, and publishing to pub.dev.

## Usage

### Basic usage (patch version bump)
```bash
./update_version.sh
```
This will increment the patch version (e.g., 1.0.1 → 1.0.2)

### With version type
```bash
./update_version.sh patch    # 1.0.1 → 1.0.2
./update_version.sh minor    # 1.0.1 → 1.1.0
./update_version.sh major    # 1.0.1 → 2.0.0
```

### With custom changelog message
```bash
./update_version.sh patch "Fixed bug in banner widget"
./update_version.sh minor "Added new customization options"
./update_version.sh major "Breaking changes: removed deprecated API"
```

## What the script does

1. ✅ Reads current version from `pubspec.yaml`
2. ✅ Calculates new version based on bump type
3. ✅ Updates `pubspec.yaml` with new version
4. ✅ Updates `CHANGELOG.md` with new entry
5. ✅ Commits changes to git
6. ✅ Pushes to GitHub
7. ✅ Runs `flutter pub publish --dry-run` to validate
8. ✅ Asks for confirmation before publishing
9. ✅ Publishes to pub.dev (if confirmed)

## Examples

```bash
# Patch update with default message
./update_version.sh patch

# Minor update with custom message
./update_version.sh minor "Added support for custom icons"

# Major update
./update_version.sh major "Breaking changes: API redesign"
```

## Notes

- The script will ask for confirmation before publishing to pub.dev
- All changes are committed and pushed to GitHub automatically
- Make sure you're logged in to pub.dev (`dart pub login`)
- The script uses the current date for the changelog entry

