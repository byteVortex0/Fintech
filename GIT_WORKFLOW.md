# Git Workflow Guide - Fintech Project

**Important Requirements from Mentor** ✅

---

## Before Starting Any Feature

### 1️⃣ Sync with Remote Develop Branch

```bash
# Make sure you're on develop
git checkout develop

# Pull latest changes from remote
git pull origin develop
```

**Why?** To avoid merge conflicts later

---

## Starting a New Feature

### 2️⃣ Create Feature Branch

```bash
# Create new feature branch FROM develop
git checkout -b feature/feature-name
```

**Branch naming convention**:
- `feature/onboarding`
- `feature/login`
- `feature/home`
- `feature/market`
- etc.

---

## Before Pushing to Remote

### 3️⃣ Run Quality Checks

**MUST do these before pushing:**

```bash
# Check for code errors
flutter analyze

# Format code consistently
dart format .

# Check if format changed anything
git status
```

**What they do**:
- `flutter analyze` - Detects errors, bugs, style issues
- `dart format .` - Makes code look consistent across team

**Both MUST pass before PR!**

---

## Commit Process

### 4️⃣ Commit Changes

```bash
# Stage all changes
git add .

# Commit with message (follow format below)
git commit -m "feat: Implement onboarding feature

- Add smooth_page_indicator package
- Create 4-slide PageView
- Build reusable widgets
- Integrate SharedPreferences

Prompt used: UI implementation"
```

**Commit Message Format**:
```
feat: brief description
- Change 1
- Change 2

fix: bug description
- Fix 1

refactor: description
- Refactor 1

Prompt used: [UI implementation / API integration / etc]
```

---

## Push & Create PR

### 5️⃣ Push to Remote

```bash
# Push feature branch to remote
git push origin feature/onboarding
```

### 6️⃣ Create Pull Request

**On GitHub**:
1. Go to repository
2. You'll see "Compare & pull request" button
3. Set:
   - **Base**: `develop`
   - **Compare**: `feature/onboarding`
4. Add title and description from commit message
5. Create PR

---

## PR Review Process

### 7️⃣ Wait for Review

Team lead will review:
- ✅ Code quality
- ✅ Architecture compliance
- ✅ Test coverage
- ✅ No merge conflicts

### 8️⃣ Address Feedback

If changes requested:
1. Make changes in your local branch
2. `git add .`
3. `git commit -m "refactor: Address PR review feedback"`
4. `git push origin feature/onboarding`
5. PR automatically updates

### 9️⃣ Merge to Develop

Once approved:
1. Click "Merge pull request" on GitHub
2. Delete feature branch (optional)
3. Local cleanup:

```bash
git checkout develop
git pull origin develop
git branch -d feature/onboarding
```

---

## Complete Example Flow

```bash
# Step 1: Sync develop
git checkout develop
git pull origin develop

# Step 2: Create feature branch
git checkout -b feature/onboarding

# Step 3: Work on feature
# [Build UI, add files, etc]

# Step 4: Quality checks
flutter analyze
dart format .

# Step 5: Commit
git add .
git commit -m "feat: Implement onboarding feature..."

# Step 6: Push
git push origin feature/onboarding

# Step 7: Create PR on GitHub
# [Wait for review]

# Step 8: Merge on GitHub
# [Delete branch]

# Step 9: Clean up locally
git checkout develop
git pull origin develop
git branch -d feature/onboarding
```

---

## Important Rules

❌ **DON'T**:
- Push directly to `develop`
- Merge your own PR
- Skip `flutter analyze` check
- Skip `dart format`
- Commit without descriptive message

✅ **DO**:
- Always create feature branch
- Always sync develop first
- Always run analyze + format
- Always write clear commit messages
- Always wait for PR review

---

## Common Issues & Fixes

### Issue: Merge Conflicts

**Prevention**: Always `git pull origin develop` before starting

**If it happens**:
```bash
git pull origin develop
# Fix conflicts in editor
git add .
git commit -m "fix: Resolve merge conflicts"
git push origin feature/onboarding
```

### Issue: Accidentally committed to develop

```bash
# Undo last commit but keep changes
git reset HEAD~1

# Create new branch
git checkout -b feature/new-feature

# Commit changes
git add .
git commit -m "feat: ..."

# Push
git push origin feature/new-feature
```

---

## Team Responsibilities

### Your Responsibilities (Abdulrahman)
✅ Create feature branches
✅ Run analyze + format
✅ Create PRs
✅ Test features
✅ Merge PRs

### Team Members Responsibilities
✅ Add BLoC/logic to UI
✅ Implement repositories
✅ Add API integration
✅ Write tests
✅ Review code

---

## Status Check Commands

```bash
# See current branch
git branch

# See all branches (local + remote)
git branch -a

# See commit history
git log --oneline -10

# See changes
git status

# See what changed in last commit
git show

# See difference between branches
git diff develop..feature/onboarding
```

---

## Remember

Before EVERY push:
1. ✅ `flutter analyze` - NO errors
2. ✅ `dart format .` - Code formatted
3. ✅ `git status` - Review changes
4. ✅ Good commit message
5. ✅ Push & create PR

**This keeps code clean and team organized!** 🚀
