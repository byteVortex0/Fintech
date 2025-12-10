# iOS IPA Build - Quick Reference Guide

**Last Updated**: December 9, 2025
**Purpose**: Quick command reference for building and distributing iOS IPA
**Status**: Cheat sheet for experienced developers

---

## ⚡ One-Command Build

```bash
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech" && \
flutter clean && \
flutter pub get && \
flutter build ios --release && \
cd ios && \
xcodebuild -workspace Runner.xcworkspace -scheme Runner -configuration Release -archivePath build/Runner.xcarchive archive && \
mkdir -p build/ipa && \
xcodebuild -exportArchive -archivePath build/Runner.xcarchive -exportPath build/ipa -exportOptionsPlist ExportOptions.plist && \
echo "✅ IPA ready at: ios/build/ipa/Fintech.ipa" && \
ls -lh build/ipa/Fintech.ipa
```

---

## 📋 Step-by-Step Commands

### 1. Pre-Build
```bash
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech"

# Update version
vim pubspec.yaml
# Change: 1.0.0+1 → 1.0.0+2

# Verify code quality
flutter analyze
flutter test

# Clean
flutter clean
flutter pub get
```

### 2. Build iOS Release
```bash
flutter build ios --release
```

### 3. Create Archive
```bash
cd ios
xcodebuild -workspace Runner.xcworkspace \
  -scheme Runner \
  -configuration Release \
  -archivePath build/Runner.xcarchive \
  archive
```

### 4. Export IPA
```bash
mkdir -p build/ipa
xcodebuild -exportArchive \
  -archivePath build/Runner.xcarchive \
  -exportPath build/ipa \
  -exportOptionsPlist ExportOptions.plist
```

### 5. Verify
```bash
ls -lh build/ipa/Fintech.ipa
# Should show: ~50-100 MB file
```

---

## 📦 Distribution Commands

### Email IPA
```bash
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech/ios/build/ipa"
zip -r Fintech-v1.0.0-$(date +%Y%m%d).zip Fintech.ipa
# File ready for email
```

### Create GitHub Release
```bash
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech"

# With release notes
gh release create v1.0.0 \
  "ios/build/ipa/Fintech.ipa" \
  --title "Fintech v1.0.0" \
  --notes "Initial release for customer testing"

# Or from file
gh release create v1.0.0 ios/build/ipa/Fintech.ipa -F RELEASE_NOTES.md
```

---

## 🔧 Troubleshooting Commands

### Check Certificates
```bash
security find-identity -v -p codesigning
# Should show: "Fintech Distribution" certificate
```

### Check Provisioning Profiles
```bash
ls ~/Library/MobileDevice/Provisioning\ Profiles/ | grep Fintech
```

### Check Team ID
```bash
grep "DEVELOPMENT_TEAM" "/Users/abdulrahmanmohammed/Flutter projects/Fintech/ios/Runner.xcodeproj/project.pbxproj" | head -1
# Should show: CX94572PQ2
```

### Check Bundle ID
```bash
grep "PRODUCT_BUNDLE_IDENTIFIER" "/Users/abdulrahmanmohammed/Flutter projects/Fintech/ios/Runner.xcodeproj/project.pbxproj" | head -1
# Should show: com.byteVortex.fintech
```

### Full Flutter Doctor Check
```bash
flutter doctor -v
```

### Clean Everything
```bash
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech"
flutter clean
rm -rf ios/Pods ios/Podfile.lock
flutter pub get
```

---

## 🔐 Setup Commands (First Time Only)

### Install Distribution Certificate
```bash
# After downloading from Apple Developer
open ~/Downloads/ios_distribution.cer
# Double-click to install in Keychain
```

### Install Provisioning Profile
```bash
# After downloading from Apple Developer
open ~/Downloads/Fintech-Ad-Hoc-Profile.mobileprovision
# Or manually:
cp ~/Downloads/Fintech-Ad-Hoc-Profile.mobileprovision \
  ~/Library/MobileDevice/Provisioning\ Profiles/
```

### Create ExportOptions.plist
```bash
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech"
cat > ios/ExportOptions.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>ad-hoc</string>
    <key>teamID</key>
    <string>CX94572PQ2</string>
    <key>signingStyle</key>
    <string>automatic</string>
    <key>stripSwiftSymbols</key>
    <true/>
    <key>thinning</key>
    <string>&lt;none&gt;</string>
    <key>provisioningProfiles</key>
    <dict>
        <key>com.byteVortex.fintech</key>
        <string>Fintech-Ad-Hoc-Profile</string>
    </dict>
</dict>
</plist>
EOF
```

---

## 🎯 Project Info

```
Project: Fintech
Bundle ID: com.byteVortex.fintech
Team ID: CX94572PQ2
Location: /Users/abdulrahmanmohammed/Flutter projects/Fintech
Current Version: 1.0.0
Current Build: +1
```

---

## 📱 Customer Installation

### Get Customer UDID
```bash
# Connect iPhone to Mac
# Open Xcode
open -a Xcode

# Menu → Window → Devices and Simulators
# Select iPhone and copy UDID
```

### Install IPA on Customer Device
```bash
# Connect iPhone to Mac
# Open Xcode
open -a Xcode

# Menu → Window → Devices and Simulators
# Drag ios/build/ipa/Fintech.ipa to iPhone

# Wait 2-5 minutes for installation
```

---

## 🔄 Version Bump Commands

### Patch Release (bug fix)
```bash
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech"
# pubspec.yaml: 1.0.0+1 → 1.0.1+2
sed -i '' 's/version: 1\.0\.0+1/version: 1.0.1+2/' pubspec.yaml
git add pubspec.yaml
git commit -m "chore: Bump to v1.0.1"
```

### Minor Release (new features)
```bash
# pubspec.yaml: 1.0.0+1 → 1.1.0+2
sed -i '' 's/version: 1\.0\.0+1/version: 1.1.0+2/' pubspec.yaml
git add pubspec.yaml
git commit -m "chore: Bump to v1.1.0"
```

### Major Release (breaking changes)
```bash
# pubspec.yaml: 1.0.0+1 → 2.0.0+2
sed -i '' 's/version: 1\.0\.0+1/version: 2.0.0+2/' pubspec.yaml
git add pubspec.yaml
git commit -m "chore: Bump to v2.0.0"
```

---

## 📊 File Locations

| File | Location |
|------|----------|
| **Project** | `/Users/abdulrahmanmohammed/Flutter projects/Fintech` |
| **IPA File** | `ios/build/ipa/Fintech.ipa` |
| **Archive** | `ios/build/Runner.xcarchive` |
| **ExportOptions** | `ios/ExportOptions.plist` |
| **Certificates** | `~/Library/Keychains/login.keychain-db` |
| **Profiles** | `~/Library/MobileDevice/Provisioning\ Profiles/` |
| **Xcode Project** | `ios/Runner.xcodeproj` |
| **Workspace** | `ios/Runner.xcworkspace` |

---

## ✅ Pre-Build Checklist (Copy-Paste)

```bash
#!/bin/bash
set -e

echo "🔍 Pre-Build Verification"
echo ""

echo "1️⃣  Checking Flutter..."
flutter doctor -v | grep -E "Flutter|Xcode|CocoaPods"

echo ""
echo "2️⃣  Checking Certificates..."
security find-identity -v -p codesigning | grep Fintech || echo "❌ Certificate not found"

echo ""
echo "3️⃣  Checking Provisioning Profiles..."
ls ~/Library/MobileDevice/Provisioning\ Profiles/ | grep Fintech || echo "❌ Profile not found"

echo ""
echo "4️⃣  Checking Version..."
grep "version:" pubspec.yaml

echo ""
echo "5️⃣  Running Flutter Analyze..."
flutter analyze

echo ""
echo "6️⃣  Running Tests..."
flutter test

echo ""
echo "✅ Pre-build checks complete!"
```

---

## 📞 Quick Help

### Can't find provisioning profile?
```bash
ls ~/Library/MobileDevice/Provisioning\ Profiles/
# If empty, download from Apple Developer and double-click
```

### Can't find certificate?
```bash
security find-identity -v -p codesigning
# If not listed, download from Apple Developer and double-click
```

### Need customer UDID?
```bash
# Send customer this:
echo "1. Connect iPhone to Mac"
echo "2. Open Xcode"
echo "3. Menu: Window → Devices and Simulators"
echo "4. Select your iPhone"
echo "5. Copy 'Identifier'"
```

### IPA file too large?
```bash
# Check size
du -h "/Users/abdulrahmanmohammed/Flutter projects/Fintech/ios/build/ipa/Fintech.ipa"
# Normal range: 50-150 MB
```

---

## 🔗 Full Guides

For detailed information, see:
- [iOS_IPA_BUILD_GUIDE.md](iOS_IPA_BUILD_GUIDE.md) - Complete build guide
- [iOS_CERTIFICATES_SETUP.md](iOS_CERTIFICATES_SETUP.md) - Certificate setup
- [iOS_VERSION_BUILD_MANAGEMENT.md](iOS_VERSION_BUILD_MANAGEMENT.md) - Version management

---

**Last Updated**: December 9, 2025
**Document Owner**: Development Team
