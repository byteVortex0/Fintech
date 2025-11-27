# standard Workflow
1. First think through the problem, read the codebase for relevant files, and write a plan to tasks/todo.md.
2. The plan should have a list of todo items that you can check off as you complete them
3. Before you begin working, check in with me and I will verify the plan.
4. Then, begin working on the todo items, marking them as complete as you go.
5. Please every step of the way just give me a high level explanation of what changes you made
6. Make every task and code change you do as simple as possible. We want to avoid making any massive or complex changes. Every change should impact as little code as possible. Everything is about simplicity.
7. If i give you a screen to make UI make it as simple as possible and based on your deep understand this design in screenshot i need you to design  it in flutter 100% like the screenshot  and follow clean arch and clean code and solid and oop if needed and split the code into widgets and each file max 100 line of code
8. Always create a PROJECT SUMMARY.md file to keep track of your progress 
9. Finally, add a review section to the [todo.md](http://todo.md/) file with a summary of the changes you made and any other relevant information.
10. Each widget should be in a separate file to maintain clean architecture
11. Explicitly handle error handling and edge cases for every feature
12. Add a Code Review step: after implementation, ask Claude to review for redundancy, 
    performance issues, and simplification opportunities
13. Feature Development Workflow (screens → documentation):
    - Create a new branch for each feature (feature/{feature-name})
    - I will send you screens one at a time
    - After finishing each screen, I will ask for the next screen
    - When you say "last screen", I will automatically:
      - Update PROJECT_SUMMARY.md
      - Update PROJECT_REQUIREMENTS.md
      - Update README.md
      - Update tasks/todo.md
      - Create tasks/{FEATURE}_IMPLEMENTATION.md
    - Then commit and push all files together
    - You don't need to mention this - it's automatic

14. Code Documentation & Comments:
    - Add strategic documentation comments ONLY to critical sections
    - Focus on: navigation flows, state management, complex business logic, shared infrastructure
    - Explain PURPOSE and ARCHITECTURE, not implementation details
    - Use class-level docstrings for shared widgets and services explaining their role in the system
    - Comments should help team members understand WHY code exists, not just WHAT it does
    - Avoid redundant comments on obvious code (e.g., "// Set name to value")
    - Goal: Make code readable and maintainable for team collaboration

15. **DOCUMENTATION UPDATE RULE** (CRITICAL - After Every Feature):
    - After EVERY feature completion, you MUST update ALL documentation files:
      - `README.md` - Update features list, tech stack, architecture, project status, and last updated date
      - `PROJECT_SUMMARY.md` - Add comprehensive phase details and current architecture
      - `PROJECT_REQUIREMENTS.md` - Update feature status and requirements
      - `tasks/todo.md` - Add complete phase section with all tasks
      - `tasks/{FEATURE}_IMPLEMENTATION.md` - Create detailed implementation documentation
    - This is NOT optional - documentation must be updated before committing feature to git
    - Documentation should be as detailed as code implementation itself
    - Goal: Keep all docs in sync with codebase at all times

16. **CRITICAL ARCHITECTURAL RULES** (from PR review):
    - ALL navigation in the entire app MUST go through NavigationService
    - NEVER use Navigator.of(context) directly
    - NEVER use hardcoded route strings - always use AppRoutes constants
    - Verify every PR to ensure navigation compliance

17. After each completed task:
    - I will provide you with the changes made and updated files
    - You are responsible for reviewing and pushing to git
    - You will create commits with messages following this format:
      feat: brief description
      - Change 1
      - Change 2
      Prompt used: [security/learning/planning]

18. I will NOT execute git commands (push/commit/pull).
    You have full control over the git workflow and when to commit/push.
    I will only provide you with:
    - Updated code files
    - High-level summary of changes
    - Ready-to-use code that you can review before committing
