# iOS Version & Build Number Management

**Last Updated**: December 9, 2025
**Purpose**: Manage app versions and build numbers for iOS releases
**Status**: Reference guide

---

## 📦 Version Numbering System

### Current Version
- **Version**: 1.0.0
- **Build Number**: 1
- **Format in pubspec.yaml**: `version: 1.0.0+1`

### Understanding Version Format

```
version: MAJOR.MINOR.PATCH+BUILD_NUMBER

1.0.0+1
│ │ │ │
│ │ │ └─ Build Number (internal, auto-increment)
│ │ └─── Patch version (bug fixes)
│ └───── Minor version (new features)
└─────── Major version (breaking changes)
```

### Semantic Versioning Rules

| Change | When | Example |
|--------|------|---------|
| **MAJOR** | Breaking changes, new major features | 1.0.0 → 2.0.0 |
| **MINOR** | New features, backward compatible | 1.0.0 → 1.1.0 |
| **PATCH** | Bug fixes, improvements | 1.0.0 → 1.0.1 |
| **BUILD** | Every time you build (increment by 1) | v1.0.0+1 → v1.0.0+2 |

---

## 🔧 Part 1: Update Version for Release

### Before Building IPA

1. **Edit `pubspec.yaml`**:

```yaml
# OLD
version: 1.0.0+1

# NEW (Bug fix release)
version: 1.0.1+2

# OR (New feature release)
version: 1.1.0+2

# OR (Major release)
version: 2.0.0+2
```

2. **Explanation**:
   - First number (1.0.0): Customer-facing version
   - Last number (+2): Internal build number (increment each build)

3. **Commit the change**:

```bash
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech"
git add pubspec.yaml
git commit -m "chore: Bump version to 1.0.1 for bug fix release"
```

---

## 🏗️ Part 2: Build Number Management

### What is Build Number?

- **Increment**: Every time you create a new IPA
- **Format**: Integer starting from 1
- **Purpose**: Apple needs a unique number for each build
- **Not visible to users**

### Examples

```
1.0.0+1  → First build of v1.0.0
1.0.0+2  → Second build of v1.0.0 (fixed a bug)
1.0.1+3  → First build of v1.0.1 (released v1.0.0)
1.1.0+4  → New feature build
```

### When to Increment Build Number

✅ **DO increment when**:
- Building new IPA for testing
- Fixing bugs and rebuilding
- Adding features and rebuilding
- Any time you create a new IPA

❌ **DON'T increment when**:
- Just rebuilding the same version (failed build)
- Changing just documentation

---

## 📊 Release Workflow

### Scenario 1: Bug Fix Release

**Situation**: v1.0.0+1 has a bug, need to release fix

```bash
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech"

# Step 1: Update version
# pubspec.yaml: 1.0.0+1 → 1.0.1+2
vim pubspec.yaml

# Step 2: Commit version bump
git add pubspec.yaml
git commit -m "chore: Bump version to 1.0.1 for bug fix"

# Step 3: Build IPA
flutter clean
flutter pub get
flutter build ios --release

# Step 4: Archive & export (see iOS_IPA_BUILD_GUIDE.md)
cd ios
xcodebuild -workspace Runner.xcworkspace -scheme Runner -configuration Release -archivePath build/Runner.xcarchive archive
xcodebuild -exportArchive -archivePath build/Runner.xcarchive -exportPath build/ipa -exportOptionsPlist ExportOptions.plist

# Step 5: Create release on GitHub
gh release create v1.0.1 ios/build/ipa/Fintech.ipa --title "Fintech v1.0.1 - Bug Fixes"
```

### Scenario 2: New Feature Release

**Situation**: Ready to release new feature

```bash
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech"

# Step 1: Update version
# pubspec.yaml: 1.0.0+1 → 1.1.0+2
vim pubspec.yaml

# Step 2: Update changelog
cat > CHANGELOG_v1.1.0.md << 'EOF'
# v1.1.0 - New Portfolio Features

## New Features
- ✨ Real-time portfolio updates
- ✨ Investment calculator
- ✨ Portfolio comparison charts

## Improvements
- 🚀 Faster market data loading
- 🐛 Fixed biometric auth on some devices
- 📱 Better responsive design on tablets

## Known Issues
- None

## Installation
See iOS_IPA_BUILD_GUIDE.md for detailed instructions.
EOF

# Step 3: Commit changes
git add pubspec.yaml CHANGELOG_v1.1.0.md
git commit -m "chore: Release v1.1.0 with new portfolio features"

# Step 4: Create git tag
git tag -a v1.1.0 -m "Release v1.1.0 - New Portfolio Features"
git push origin v1.1.0

# Step 5: Build IPA (see iOS_IPA_BUILD_GUIDE.md)
# ... build steps ...

# Step 6: Create GitHub release
gh release create v1.1.0 ios/build/ipa/Fintech.ipa -F CHANGELOG_v1.1.0.md
```

### Scenario 3: Multiple Builds of Same Version

**Situation**: Testing multiple builds before release

```bash
# Build 1: Initial test
pubspec.yaml: 1.1.0+1
# ... build IPA ...
# Customer: "Needs more features"

# Build 2: Add features
pubspec.yaml: 1.1.0+2  # Only increment build number
# ... build IPA ...
# Customer: "Found a bug"

# Build 3: Fix bug
pubspec.yaml: 1.1.0+3  # Increment again
# ... build IPA ...
# Customer: "Perfect! Release this"

# Release: After approval
pubspec.yaml: 1.1.0+3  # No change (already has final build number)
git commit -m "chore: Release v1.1.0+3 to production"
```

---

## 📋 Part 3: Version Tracking

### Maintain a Release Log

Create file: `RELEASES.md`

```markdown
# Fintech Release History

## v1.1.0 (Build 3) - December 10, 2025
- Date Released: Dec 10, 2025
- Build Number: 3
- Status: ✅ Customer Testing
- Features:
  - Real-time portfolio updates
  - Investment calculator
- Testers: 5 customers
- Feedback: All positive

## v1.0.1 (Build 2) - December 9, 2025
- Date Released: Dec 9, 2025
- Build Number: 2
- Status: ✅ Released
- Fixes:
  - Face ID authentication issue
  - Portfolio loading crash
- Testers: 3 customers

## v1.0.0 (Build 1) - December 8, 2025
- Date Released: Dec 8, 2025
- Build Number: 1
- Status: ✅ Released
- Initial Release
```

---

## 🔍 Part 4: Verify Version in Build

### Check Version in Xcode

```bash
# View version from pubspec.yaml
grep "version:" pubspec.yaml

# Expected: version: 1.0.0+1
```

### Check Version in Built App

```bash
# After building, check the Info.plist
cd ios

# View version
plutil -p build/ios/archive.xcarchive/Info.plist | grep CFBundleShortVersionString

# View build number
plutil -p build/ios/archive.xcarchive/Info.plist | grep CFBundleVersion
```

---

## 🎯 Part 5: Version Strategy

### For Different Scenarios

#### Development Version
```
1.0.0-dev.1  (Not used in pubspec.yaml for releases)
1.0.0-beta.1
1.0.0-rc.1
```

#### Testing Versions
```
1.0.0+1  ← Build 1
1.0.0+2  ← Build 2 (bug fix during testing)
1.0.0+3  ← Build 3 (final before release)
```

#### Released Versions
```
1.0.0+3    ← Released to customers (v1.0.0)
1.0.1+4    ← Bug fix release
1.1.0+5    ← New features
```

---

## 📊 Part 6: Increment Cheat Sheet

### Quick Reference

```bash
# Check current version
grep "version:" pubspec.yaml

# Increment PATCH (bug fix)
# 1.0.0+1 → 1.0.1+2
sed -i '' 's/version: 1.0.0+1/version: 1.0.1+2/' pubspec.yaml

# Increment MINOR (new feature)
# 1.0.0+1 → 1.1.0+2
sed -i '' 's/version: 1.0.0+1/version: 1.1.0+2/' pubspec.yaml

# Increment MAJOR (breaking change)
# 1.0.0+1 → 2.0.0+2
sed -i '' 's/version: 1.0.0+1/version: 2.0.0+2/' pubspec.yaml

# Just increment build number
# 1.0.0+1 → 1.0.0+2
sed -i '' 's/\+1$/+2/' pubspec.yaml
```

### Automated Version Bump Script

Create file: `scripts/bump_version.sh`

```bash
#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./bump_version.sh [major|minor|patch|build]"
  exit 1
fi

VERSION_FILE="pubspec.yaml"
CURRENT=$(grep "version:" $VERSION_FILE | cut -d' ' -f2)

# Parse current version
MAJOR=$(echo $CURRENT | cut -d. -f1)
MINOR=$(echo $CURRENT | cut -d. -f2)
PATCH=$(echo $CURRENT | cut -d. -f3 | cut -d+ -f1)
BUILD=$(echo $CURRENT | cut -d+ -f2)

# Calculate new version based on argument
case "$1" in
  major)
    NEW_MAJOR=$((MAJOR + 1))
    NEW_VERSION="$NEW_MAJOR.0.0+$((BUILD + 1))"
    ;;
  minor)
    NEW_MINOR=$((MINOR + 1))
    NEW_VERSION="$MAJOR.$NEW_MINOR.0+$((BUILD + 1))"
    ;;
  patch)
    NEW_PATCH=$((PATCH + 1))
    NEW_VERSION="$MAJOR.$MINOR.$NEW_PATCH+$((BUILD + 1))"
    ;;
  build)
    NEW_BUILD=$((BUILD + 1))
    NEW_VERSION="$MAJOR.$MINOR.$PATCH+$NEW_BUILD"
    ;;
  *)
    echo "Unknown argument: $1"
    exit 1
    ;;
esac

# Update pubspec.yaml
sed -i '' "s/version: $CURRENT/version: $NEW_VERSION/" $VERSION_FILE

echo "Version bumped: $CURRENT → $NEW_VERSION"
```

**Usage**:
```bash
chmod +x scripts/bump_version.sh

# Bump patch version (bug fix)
./scripts/bump_version.sh patch

# Bump minor version (new features)
./scripts/bump_version.sh minor

# Bump major version (breaking changes)
./scripts/bump_version.sh major

# Bump build number only
./scripts/bump_version.sh build
```

---

## ✅ Checklist Before Building

- [ ] Version number updated in pubspec.yaml
- [ ] Build number incremented (+1)
- [ ] Version change committed to git
- [ ] Git tag created (for releases): `git tag v1.0.0`
- [ ] Changelog updated with release notes
- [ ] Flutter analyze passes: `flutter analyze`
- [ ] All tests pass: `flutter test`

---

## 🔗 Related Documentation

- [iOS_IPA_BUILD_GUIDE.md](iOS_IPA_BUILD_GUIDE.md) - How to build and distribute IPA
- [iOS_CERTIFICATES_SETUP.md](iOS_CERTIFICATES_SETUP.md) - Certificate and profile setup
- [iOS_IPA_QUICK_REFERENCE.md](iOS_IPA_QUICK_REFERENCE.md) - Quick commands reference

---

**Last Updated**: December 9, 2025
**Document Owner**: Development Team
