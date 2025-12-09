# CI/CD Setup Guide

This document explains how to set up and use the CI/CD pipelines for the Fintech app.

## Overview

We have two GitHub Actions workflows:

### 1. **PR Checks Workflow** (`pr-checks.yml`)
Runs on every PR and commit to validate code quality:
- ✅ Install Flutter dependencies
- ✅ Dart format check
- ✅ Flutter analyze
- ✅ Build runner (code generation)

**When it runs:** On every commit to any PR targeting `develop` branch

**What happens if it fails:** PR cannot be merged until all checks pass

---

### 2. **Firebase Distribution Workflow** (`firebase-distribution.yml`)
Automatically builds and uploads APK to Firebase when code is merged to develop:
- ✅ Build release APK
- ✅ Upload to Firebase App Distribution
- ✅ Send notification to testers

**When it runs:** After each commit to `develop` branch (after PR merge)

**Who gets notified:** All users in "testers" group on Firebase

---

## Setup Instructions

### Step 1: Get Firebase Service Account Key

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your **Fintech** project
3. Go to **Settings** → **Service Accounts** tab
4. Click **Generate New Private Key**
5. Download the JSON file
6. Keep this file safe (don't commit to Git)

### Step 2: Get Firebase App ID

1. In Firebase Console, go to your project settings
2. Under **Your apps**, find your Android app
3. Copy the **App ID** (looks like `1:123456789:android:abc123...`)

### Step 3: Add GitHub Secrets

1. Go to your GitHub repo: `github.com/byteVortex0/Fintech`
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**

Create these secrets:

| Secret Name | Value |
|---|---|
| `FIREBASE_SERVICE_ACCOUNT_KEY` | Contents of the JSON file from Step 1 |
| `FIREBASE_APP_ID` | The App ID from Step 2 |

**How to add the JSON:**
- Open the downloaded JSON file in a text editor
- Copy all contents
- Paste into the secret value field
- Click **Add secret**

### Step 4: Add Testers to Firebase

1. In Firebase Console, go to **App Distribution**
2. Click **Manage Testers**
3. Add your team members' email addresses
4. They will receive invitations to test the app

---

## Workflow in Action

### Developer Workflow:

```
1. Create feature branch
   git checkout -b feature/my-feature

2. Make changes and commit
   git add .
   git commit -m "feat: add new feature"

3. Push to GitHub
   git push origin feature/my-feature

4. Create PR to develop
   → PR Checks Workflow RUNS
   → flutter analyze ✅
   → dart format ✅
   → build_runner ✅
   → All checks pass ✅

5. Merge PR to develop
   → Firebase Distribution Workflow RUNS
   → flutter build apk ✅
   → Upload to Firebase ✅
   → Testers get notification 📱

6. Testers download APK and test
   → Feedback sent to team
```

---

## Troubleshooting

### PR Checks Failing?

**If `dart format` fails:**
```bash
dart format .
git add .
git commit -m "style: format code"
git push
```

**If `flutter analyze` fails:**
- Fix the reported errors
- Commit and push - workflow will re-run

**If `build_runner` fails:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
git add .
git commit -m "build: regenerate code"
git push
```

### Firebase Upload Failing?

1. Check secrets are added correctly
2. Check Firebase App ID is correct
3. Check testers email addresses are valid
4. Check Android app exists in Firebase console

---

## Testing Locally

Before pushing to GitHub, test locally:

```bash
# Test PR checks
flutter clean
flutter pub get
dart format --set-exit-if-changed .
flutter analyze
flutter pub run build_runner build --delete-conflicting-outputs

# Test APK build
flutter build apk --release --split-per-abi
```

---

## What's Next?

✅ Phase 20: CI/CD Setup - COMPLETE!
- PR Checks workflow active
- Firebase Distribution workflow ready (requires setup)

**Next Phase:** Coin Details Screen (Phase 21)

---

## Questions?

- 📖 Read: [GitHub Actions Docs](https://docs.github.com/en/actions)
- 🔥 Read: [Firebase Distribution Docs](https://firebase.google.com/docs/app-distribution)
