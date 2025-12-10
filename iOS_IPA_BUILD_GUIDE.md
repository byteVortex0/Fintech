# iOS IPA Build Guide - Customer Testing Distribution

**Last Updated**: December 9, 2025
**Purpose**: Build and distribute iOS IPA for customer beta testing (Ad Hoc distribution)
**Target Audience**: Development team, customer testers
**Status**: Reference guide for future builds

---

## 📱 Project Configuration

### App Details
- **App Name**: Fintech
- **Bundle ID**: `com.byteVortex.fintech`
- **Team ID**: `CX94572PQ2`
- **Version**: 1.0.0 (Build +1)
- **Minimum iOS**: 13.0+
- **Supported Orientations**: Portrait, Landscape

### Prerequisites
- ✅ Apple Developer Account (active)
- ✅ Mac with Xcode installed
- ✅ Flutter SDK installed
- ✅ Project at: `/Users/abdulrahmanmohammed/Flutter projects/Fintech`

---

## 🔑 Part 1: Apple Developer Portal Setup (First Time Only)

### Step 1.1: Register App ID

1. Go to: https://developer.apple.com/account
2. Login with your Apple account
3. Navigate to **Certificates, Identifiers & Profiles**
4. Click **Identifiers**
5. Click the **+** button (top-right)
6. Select **App IDs**
7. Fill in:
   - **Name**: Fintech
   - **Bundle ID**: `com.byteVortex.fintech`
   - **Capabilities**: Enable:
     - ✅ Face ID
     - ✅ Touch ID
     - ✅ Sign in with Apple (if needed)
8. Click **Register**

### Step 1.2: Create Distribution Certificate

1. Go to **Certificates**
2. Click **+** button
3. Select **iOS Distribution**
4. Follow the prompts to generate Certificate Signing Request (CSR)
5. Upload CSR
6. Download the `.cer` file
7. Double-click to install in Keychain

### Step 1.3: Create Ad Hoc Provisioning Profile

1. Go to **Provisioning Profiles**
2. Click **+** button
3. Select **iOS App Distribution** (Ad Hoc)
4. Select App ID: `com.byteVortex.fintech`
5. Select your distribution certificate
6. Select devices (add customer's iPhone UDIDs)
   - **Important**: Get customer's iPhone UDID
     - Connect iPhone to Mac
     - Open Xcode → Window → Devices and Simulators
     - Copy UDID from the device
7. Name: `Fintech-Ad-Hoc-Profile`
8. Download the `.mobileprovision` file

### Step 1.4: Install Provisioning Profile

```bash
# Double-click the file to auto-install, OR

# Manual install
cp ~/Downloads/Fintech-Ad-Hoc-Profile.mobileprovision \
  ~/Library/MobileDevice/Provisioning\ Profiles/
```

---

## 🛠️ Part 2: Pre-Build Preparation

### Step 2.1: Update App Version (if needed)

Edit `pubspec.yaml`:

```yaml
version: 1.0.0+2  # Change +1 to +2 for next build
```

### Step 2.2: Verify Flutter & Dependencies

```bash
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech"

# Check Flutter version
flutter --version

# Clean old builds
flutter clean

# Get dependencies
flutter pub get
```

### Step 2.3: Verify iOS Configuration

```bash
# Check iOS deployment target
cd ios

# Verify Podfile
cat Podfile | grep "platform :ios"

# Verify minimum iOS version is 13.0 or higher
```

### Step 2.4: Verify Code Quality

```bash
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech"

# Run linter
flutter analyze

# Expected: 0 errors (pre-existing warnings are OK)
```

---

## 🏗️ Part 3: Build the IPA

### Step 3.1: Clean and Prepare

```bash
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech"

# Complete clean
flutter clean

# Get dependencies
flutter pub get

# Build Flutter bundle
flutter build ios --release
```

### Step 3.2: Archive in Xcode

```bash
cd ios

# Archive the app
xcodebuild -workspace Runner.xcworkspace \
  -scheme Runner \
  -configuration Release \
  -archivePath build/Runner.xcarchive \
  archive
```

**What this does**:
- Compiles Dart code to native iOS code
- Links all dependencies
- Signs with your certificate
- Creates `.xcarchive` file (temporary archive)

### Step 3.3: Create ExportOptions.plist

Create file: `ios/ExportOptions.plist`

```xml
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
```

### Step 3.4: Export IPA

```bash
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech"

# Create ipa directory
mkdir -p ios/build/ipa

# Export the IPA
xcodebuild -exportArchive \
  -archivePath ios/build/Runner.xcarchive \
  -exportPath ios/build/ipa \
  -exportOptionsPlist ios/ExportOptions.plist
```

**Expected Output**:
```
2025-12-09 10:30:45.123 xcodebuild[12345] DVTAssertions: Warning (t22287661): ...
Exporting...
...
Exported successfully to: /Users/abdulrahmanmohammed/Flutter projects/Fintech/ios/build/ipa
```

### Step 3.5: Verify IPA Was Created

```bash
ls -lh "/Users/abdulrahmanmohammed/Flutter projects/Fintech/ios/build/ipa/"

# You should see:
# fintech.ipa  (50-100 MB typically)
# Fintech.app/
# ...
```

---

## 📦 Part 4: Distribute to Customer

### Option A: Email the IPA

1. Compress the IPA:
```bash
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech/ios/build/ipa"
zip -r Fintech-v1.0.0.ipa.zip Fintech.ipa
```

2. Email to customer with instructions:
```
Subject: Fintech App - Beta Test Build v1.0.0

Hi [Customer Name],

Attached is the Fintech iOS app for testing.

Installation Instructions:
1. Connect your iPhone to a Mac with Xcode
2. Open Xcode → Window → Devices and Simulators
3. Drag the IPA file onto your iPhone in Xcode
4. Wait for installation to complete

Or use Finder:
1. Open Finder
2. Connect iPhone
3. Go to iPhone → Apps
4. Drag the IPA file to the Apps section

Testing Instructions:
- Try login with test credentials
- Test biometric authentication (Face ID/Touch ID)
- Navigate through all screens
- Check portfolio and market data
- Report any bugs or issues

Please let us know if you encounter any problems!

Best regards,
[Your Team]
```

### Option B: Upload to Google Drive

```bash
# Compress the IPA
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech/ios/build/ipa"
zip -r Fintech-v1.0.0-$(date +%Y%m%d).zip Fintech.ipa

# Upload to Google Drive (or use web interface)
```

### Option C: GitHub Releases

```bash
# Create GitHub release with IPA
cd "/Users/abdulrahmanmohammed/Flutter projects/Fintech"

# Create release notes
cat > RELEASE_NOTES_v1.0.0.md << 'EOF'
# Fintech App v1.0.0 - Beta

## Features Tested
- ✅ User authentication (email/password)
- ✅ Biometric login (Face ID/Touch ID)
- ✅ Portfolio management
- ✅ Market data display
- ✅ Settings and profile

## Known Issues
- None (first release)

## Instructions
1. Download Fintech.ipa
2. Connect iPhone to Mac with Xcode
3. Open Devices and Simulators
4. Drag IPA to your iPhone

## Feedback
Please report issues via email or GitHub issues.
EOF

# Use gh CLI to create release
gh release create v1.0.0 \
  "ios/build/ipa/Fintech.ipa" \
  -F RELEASE_NOTES_v1.0.0.md
```

---

## 📝 Part 5: Installation for Customer

### Method 1: Xcode (Recommended for 1-5 testers)

**Steps for Customer**:

1. Get their iPhone UDID:
   - Connect iPhone to Mac
   - Open Xcode → Window → Devices and Simulators
   - Right-click iPhone → Copy UDID
   - Send UDID to development team

2. Once they receive the IPA:
   - Connect iPhone to Mac
   - Open Xcode → Window → Devices and Simulators
   - Drag the .ipa file onto their iPhone
   - Wait for installation (may take 2-5 minutes)
   - App appears on home screen

### Method 2: iPhone Storage (No Mac Needed)

**If customer doesn't have a Mac**:

1. Send them the IPA file via:
   - Google Drive link (download to iPhone)
   - Dropbox link
   - Direct email (if file size allows)

2. On their iPhone:
   - Download the IPA file
   - Open Files app
   - Long-press the IPA file
   - Select "Share" → Email/AirDrop to friend with Mac

3. Friend with Mac installs using Xcode method above

---

## 🔧 Part 6: Troubleshooting

### Error: "Invalid provisioning profile"

**Problem**: Profile doesn't match the build

**Solution**:
```bash
# Clear old profiles
rm -rf ~/Library/MobileDevice/Provisioning\ Profiles/*

# Download fresh profile from Apple Developer
# Double-click to install
# Rebuild IPA
```

### Error: "Code signing identity not found"

**Problem**: Certificate missing

**Solution**:
```bash
# Check installed certificates
security find-identity -v -p codesigning

# If empty, download and install distribution certificate:
# 1. Go to Apple Developer → Certificates
# 2. Download your distribution certificate (.cer)
# 3. Double-click to install in Keychain
```

### Error: "Provisioning profile does not include"

**Problem**: Device UDID not in profile

**Solution**:
1. Get customer's iPhone UDID
2. Go to Apple Developer → Provisioning Profiles → Fintech-Ad-Hoc-Profile
3. Edit → Add devices → Paste UDID
4. Download updated profile
5. Install profile: `double-click` or manual install
6. Rebuild IPA

### Error: "iPhone cannot verify developer"

**Problem**: Happens on customer's iPhone first time

**Solution** (Customer does on their iPhone):
1. Settings → General → VPN & Device Management
2. Find "Apple Development" or your team name
3. Tap "Trust"
4. Confirm

---

## 📊 Part 7: Complete Build Command List

### Quick Build (All Steps Combined)

Create file: `scripts/build_ipa.sh`

```bash
#!/bin/bash
set -e

PROJECT_DIR="/Users/abdulrahmanmohammed/Flutter projects/Fintech"
BUILD_NAME="Fintech-$(date +%Y%m%d)"

echo "🏗️  Starting iOS IPA build..."
cd "$PROJECT_DIR"

echo "🧹 Cleaning..."
flutter clean
flutter pub get

echo "📱 Building iOS release..."
flutter build ios --release

echo "📦 Creating archive..."
cd ios
xcodebuild -workspace Runner.xcworkspace \
  -scheme Runner \
  -configuration Release \
  -archivePath build/Runner.xcarchive \
  archive

echo "🎁 Exporting IPA..."
mkdir -p build/ipa
xcodebuild -exportArchive \
  -archivePath build/Runner.xcarchive \
  -exportPath build/ipa \
  -exportOptionsPlist ExportOptions.plist

echo "✅ Build complete!"
echo "📁 IPA location: $PROJECT_DIR/ios/build/ipa/Fintech.ipa"
echo "📊 Size: $(du -h build/ipa/Fintech.ipa | cut -f1)"
```

**Usage**:
```bash
chmod +x scripts/build_ipa.sh
./scripts/build_ipa.sh
```

---

## 📋 Part 8: Checklist for Each Build

### Pre-Build Checklist
- [ ] Flutter analyze shows 0 errors
- [ ] All tests pass: `flutter test`
- [ ] App tested on simulator: `flutter run`
- [ ] Version updated in pubspec.yaml
- [ ] ExportOptions.plist exists and is correct
- [ ] Provisioning profile is up to date
- [ ] Distribution certificate is valid

### Build Checklist
- [ ] `flutter clean` completed
- [ ] `flutter pub get` completed
- [ ] iOS build successful
- [ ] Archive created without errors
- [ ] IPA exported successfully
- [ ] IPA file size is reasonable (50-150 MB)

### Distribution Checklist
- [ ] IPA tested on real device before sending
- [ ] Customer UDIDs are in provisioning profile
- [ ] Installation instructions provided to customer
- [ ] Feedback mechanism established (email/GitHub)
- [ ] Build documented with version number
- [ ] Build archived for future reference

---

## 🔐 Part 9: Team Guide

### For New Team Members

**To build an IPA for the first time**:

1. Read this entire guide
2. Ensure you have Xcode installed
3. Ask team lead for:
   - Apple Developer account access
   - Distribution certificate
   - Provisioning profile (Fintech-Ad-Hoc-Profile)
4. Install certificate and profile
5. Follow "Part 3: Build the IPA"
6. Test on your own iPhone first

### Common Questions

**Q: Can I build on Windows/Linux?**
A: No, IPA requires macOS. Android APK can be built anywhere.

**Q: How long does a build take?**
A: 15-30 minutes (first time takes longer)

**Q: Can I test the IPA on simulator?**
A: No, IPA is for real devices only. Use `flutter run` for simulator.

**Q: How many times can I reinstall on same iPhone?**
A: Unlimited. Just drag IPA again to Xcode.

**Q: Does customer need Apple Developer account?**
A: No! They just need an iPhone and a Mac to install (or use Xcode).

---

## 📞 Support

### If Build Fails

1. **Check Flutter**:
   ```bash
   flutter doctor -v
   ```

2. **Check Xcode**:
   ```bash
   xcode-select --print-path
   sudo xcode-select --reset
   ```

3. **Check Certificates**:
   ```bash
   security find-identity -v -p codesigning
   ```

4. **Rebuild from scratch**:
   ```bash
   flutter clean
   rm -rf ios/Pods ios/Podfile.lock
   flutter pub get
   flutter build ios --release
   ```

### Getting Help

- iOS Deployment: https://flutter.dev/docs/deployment/ios
- Xcode Build Settings: Open Xcode → Project → Build Settings
- Apple Developer Help: https://developer.apple.com/help

---

## 🎯 Next Steps After First Build

1. **Automate with CI/CD** (GitHub Actions, Codemagic, Fastlane)
2. **Switch to TestFlight** (if more than 5 testers needed)
3. **Set up crash reporting** (Fabric, Firebase Crashlytics)
4. **Monitor beta feedback** (GitHub issues, email support)

---

## 📈 Version History

| Version | Date | Changes | Status |
|---------|------|---------|--------|
| 1.0.0 | Dec 9, 2025 | Initial build guide | ✅ Active |

---

**Last Updated**: December 9, 2025
**Document Owner**: Development Team
**Review Schedule**: Before each major release
