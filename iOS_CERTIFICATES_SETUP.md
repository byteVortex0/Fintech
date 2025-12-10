# iOS Certificates & Provisioning Setup Guide

**Last Updated**: December 9, 2025
**Purpose**: Detailed steps for creating and managing iOS certificates and provisioning profiles
**Status**: Reference guide

---

## 🔐 Understanding Apple Certificates & Profiles

### What You Need

| Item | Purpose | Lifespan | Count |
|------|---------|----------|-------|
| **Distribution Certificate** | Signs the app for distribution | 3 years | 1 per team |
| **Ad Hoc Provisioning Profile** | Links app to devices for testing | 1 year | Can have multiple |
| **Device UDIDs** | Identifies customer iPhones | Forever | Add as needed |

---

## 📋 Part 1: Get Your Team ID

### Find Your Team ID

1. Go to: https://developer.apple.com/account
2. Click **Membership details**
3. Copy your **Team ID** (format: `CX94572PQ2`)

**Our Team ID**: `CX94572PQ2`

---

## 🎯 Part 2: Create Distribution Certificate

### Step 1: Generate Certificate Signing Request (CSR) on Mac

```bash
# Open Keychain Access
open /Applications/Utilities/Keychain\ Access.app

# Menu → Keychain Access → Certificate Assistant → Request a Certificate from a Certificate Authority

# Fill in:
# Email Address: your-email@example.com
# Common Name: Fintech Distribution
# Request is: Save to disk

# Save as: CertificateSigningRequest.certSigningRequest
```

### Step 2: Upload CSR to Apple Developer

1. Go to: https://developer.apple.com/account/resources/certificates/list
2. Click **+** button
3. Select **iOS Distribution**
4. Upload your `CertificateSigningRequest.certSigningRequest`
5. Click **Continue**
6. Click **Download** to get the `.cer` file

### Step 3: Install Certificate in Keychain

```bash
# Double-click the downloaded certificate
# Or drag to Keychain

# Verify it installed
security find-identity -v -p codesigning

# You should see:
# "Fintech Distribution" listed with your Team ID
```

---

## 📱 Part 3: Get Customer Device UDIDs

### Method 1: Using Xcode (Recommended)

```bash
# Connect iPhone to Mac
# Open Xcode
open -a Xcode

# Menu → Window → Devices and Simulators
# Select your iPhone
# Copy the UDID (under Device Identifier)

# Example UDID: abc123def456...
```

### Method 2: Using iTunes

1. Connect iPhone to Mac
2. Open iTunes
3. Click iPhone icon
4. Click "Serial Number"
5. Copy UDID that appears

### Method 3: Ask Customer

Provide this instruction to customer:

> **How to find your iPhone UDID:**
> 1. Connect iPhone to a Mac
> 2. Open Xcode (Mac App Store or developer.apple.com)
> 3. Menu → Window → Devices and Simulators
> 4. Select your iPhone
> 5. Look for "Identifier" row
> 6. Copy the long alphanumeric code
> 7. Send it to development team via email

---

## 🏷️ Part 4: Register App ID

### Step 1: Register Bundle ID

1. Go to: https://developer.apple.com/account/resources/identifiers/list
2. Click **+** button
3. Select **App IDs**
4. Fill in:
   - **Type**: App
   - **Description**: Fintech
   - **Bundle ID**: `com.byteVortex.fintech`
5. Enable capabilities:
   - ✅ Face ID
   - ✅ Sign in with Apple
   - ✅ Other as needed
6. Click **Register**

### Step 2: Enable Services (if needed)

1. Go to: https://developer.apple.com/account/resources/identifiers/list
2. Find `com.byteVortex.fintech`
3. Click it
4. Check "Capabilities":
   - ✅ Push Notifications (if needed)
   - ✅ In-App Purchase (if needed)
   - ✅ Biometric (Face ID) - REQUIRED for us
5. Click **Save**

---

## 👥 Part 5: Create Ad Hoc Provisioning Profile

### Step 1: Create Profile

1. Go to: https://developer.apple.com/account/resources/profiles/list
2. Click **+** button
3. Select **iOS App Distribution**
4. Select **Ad Hoc** (for testing on customer devices)
5. Click **Continue**

### Step 2: Select App ID

1. Find and select: `com.byteVortex.fintech`
2. Click **Continue**

### Step 3: Select Certificate

1. Select your distribution certificate (Fintech Distribution)
2. Click **Continue**

### Step 4: Add Customer Devices

1. Check all customer UDIDs
   - Add new devices as needed
2. Click **Continue**

### Step 5: Name & Download

1. **Profile Name**: `Fintech-Ad-Hoc-Profile-v1`
   - Include version number for easy management
2. Click **Generate**
3. Download the `.mobileprovision` file

### Step 6: Install Profile

```bash
# Auto-install (recommended)
# Just double-click the file

# Manual install
cp ~/Downloads/Fintech-Ad-Hoc-Profile-v1.mobileprovision \
  ~/Library/MobileDevice/Provisioning\ Profiles/

# Verify installation
ls ~/Library/MobileDevice/Provisioning\ Profiles/ | grep Fintech
```

---

## 📊 Part 6: Managing Multiple Profiles

### File Naming Convention

```
Fintech-Ad-Hoc-Profile-v1.mobileprovision  # v1: Supports devices A, B
Fintech-Ad-Hoc-Profile-v2.mobileprovision  # v2: Added device C
Fintech-Ad-Hoc-Profile-v3.mobileprovision  # v3: Added devices D, E
```

### List All Profiles

```bash
# View all installed profiles
ls -la ~/Library/MobileDevice/Provisioning\ Profiles/ | grep Fintech

# View profile details
security cms -D -i ~/Library/MobileDevice/Provisioning\ Profiles/*.mobileprovision | grep -A 5 "Name"
```

### Update Profile When Adding New Devices

1. Apple Developer → Provisioning Profiles
2. Find `Fintech-Ad-Hoc-Profile-v1`
3. Click **Edit**
4. Add new device UDID
5. Click **Save**
6. Download updated profile
7. Replace old version in Mac

---

## 🔄 Part 7: Certificate & Profile Expiration

### Certificate Expiration (Distribution)

- **Valid for**: 3 years
- **When to renew**: Before it expires
- **How to check**:
  ```bash
  security find-identity -v -p codesigning | grep Fintech
  # Look for expiration date
  ```

### Profile Expiration (Provisioning)

- **Valid for**: 1 year
- **When to renew**: Before it expires
- **How to check**:
  1. Apple Developer → Provisioning Profiles
  2. Look for expiration date
  3. Download fresh profile if expired

### Create Reminders

```bash
# Add calendar reminder (macOS)
# 60 days before expiration

# Or check Apple Developer email notifications
# (Enable in Account Settings)
```

---

## ✅ Part 8: Verification Checklist

### Before Building IPA

- [ ] Distribution certificate installed: `security find-identity -v -p codesigning`
- [ ] Provisioning profile exists: `ls ~/Library/MobileDevice/Provisioning\ Profiles/`
- [ ] Customer UDIDs are in profile
- [ ] Bundle ID matches: `com.byteVortex.fintech`
- [ ] Team ID is correct: `CX94572PQ2`
- [ ] Certificate is not expired
- [ ] Profile is not expired

### Quick Verification Script

```bash
#!/bin/bash

echo "=== iOS Build Verification ==="

# Check certificates
echo "📜 Distribution Certificate:"
security find-identity -v -p codesigning | grep Fintech || echo "❌ NOT FOUND"

# Check provisioning profiles
echo "📱 Provisioning Profiles:"
ls ~/Library/MobileDevice/Provisioning\ Profiles/ | grep Fintech || echo "❌ NOT FOUND"

# Check Bundle ID
echo "🏷️  Bundle ID:"
grep "PRODUCT_BUNDLE_IDENTIFIER" ios/Runner.xcodeproj/project.pbxproj | head -1

# Check Team ID
echo "👥 Team ID:"
grep "DEVELOPMENT_TEAM" ios/Runner.xcodeproj/project.pbxproj | head -1

echo "✅ Verification complete!"
```

---

## 🆘 Part 9: Common Issues & Solutions

### Certificate Not Found

**Error**: `Code Signing Identifier Missing`

**Solution**:
```bash
# Re-download certificate from Apple Developer
# Go to: https://developer.apple.com/account/resources/certificates/list
# Download and install the .cer file
# Double-click to add to Keychain
```

### Profile Doesn't Include Device

**Error**: `The provided provisioning profile ... is not compatible`

**Solution**:
1. Get customer's iPhone UDID
2. Go to Apple Developer → Provisioning Profiles
3. Find your profile
4. Click **Edit**
5. Add device UDID
6. Click **Save**
7. Download and reinstall profile

### Multiple Certificates Installed

**Problem**: Confusion about which to use

**Solution**:
```bash
# List all certificates
security find-identity -v -p codesigning

# Use the one labeled "Fintech Distribution"
# Delete old ones you don't need
```

### Profile Expired

**Error**: `Provisioning profile has expired`

**Solution**:
1. Go to Apple Developer
2. Download new profile
3. Install in: `~/Library/MobileDevice/Provisioning\ Profiles/`
4. Rebuild IPA

---

## 📚 References

- Apple Developer: https://developer.apple.com/account
- iOS Code Signing: https://developer.apple.com/support/code-signing/
- Xcode Signing Guide: https://help.apple.com/xcode/mac/current/#/devdc3d64dca

---

**Last Updated**: December 9, 2025
**Document Owner**: Development Team
