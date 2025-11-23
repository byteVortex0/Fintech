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
13. After each completed task:
    - I will provide you with the changes made and updated files
    - You are responsible for reviewing and pushing to git
    - You will create commits with messages following this format:
      feat: brief description
      - Change 1
      - Change 2
      Prompt used: [security/learning/planning]

14. I will NOT execute git commands (push/commit/pull). 
    You have full control over the git workflow and when to commit/push.
    I will only provide you with:
    - Updated code files
    - High-level summary of changes
    - Ready-to-use code that you can review before committing