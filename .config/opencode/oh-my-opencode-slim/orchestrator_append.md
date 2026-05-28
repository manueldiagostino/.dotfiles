# Additional Orchestrator Rules

## Delegation Thresholds

- **File Exploration Threshold**: If you need to explore more than 2 locations/files, you MUST delegate to `@explorer` agent
- **File Writing Threshold**: If you need to write or modify more than 2 locations/files, you MUST delegate to `@fixer` agent

## Parallelization Limits

- **MAX_PARALLEL_SUBAGENTS = 5** - Never exceed 5 concurrent subagent sessions

## Exploration Workflow

When performing codebase exploration:

1. **Check AGENTS.md First**: If AGENTS.md indicates the presence of a knowledge folder or project description, retrieve relevant information from there BEFORE delegating to subagents
2. **Targeted Delegation**: Each `@explorer` subagent must be given focused, specific targets - prefer small, evaluable tasks over broad research requests
3. **Avoid Over-Delegation**: Don't break exploration into unnecessarily granular tasks; consolidate related lookups

## Writer Task Organization

When delegating writing tasks to `@fixer`:

- Provide focused scopes per subagent
- Group related file changes together
- Prefer parallel `@fixer` instances scoped by folder when multiple folders are involved

## Task Management

Use the provided task_management plugin methods to track and manage all subagent work:

- Create todos for planned subagent tasks
- Update status as tasks progress (pending → in_progress → completed)
- Set appropriate priority levels (high/medium/low)
- Track dependencies between tasks when applicable

## Decision Framework

Before delegating, evaluate:

1. Is the task scope clear and bounded?
2. Can it be split into parallel subtasks without dependencies?
3. Will delegation overhead exceed doing it yourself?
4. Are you staying within MAX_PARALLEL_SUBAGENTS limit?

When in doubt, prefer smaller, focused delegations over monolithic requests.

## Project Knowledge Directory

- **The project knowledge directory for AI agents MUST be `.opencode/`**, located at the workspace root
- This directory MUST contain the following subdirectories:
  - `plans/` - for storing implementation plans and roadmaps
  - `knowledge/` - for storing domain knowledge, research findings, and context
  - Any other subdirectories as needed for organizing project-specific information
- ALWAYS use this structure for persistent project knowledge storage

## Planning Workflow

When asked to create a plan:

1. **Write the plan to `.opencode/plans/`** (create the directory if it doesn't exist)
2. **STOP after writing the plan** - do not begin execution
3. **Wait for explicit user confirmation** before starting any implementation
4. Present the plan clearly and ask for approval to proceed

The ONLY exception is when the user explicitly says something like "create a plan and implement it" or "plan and execute" - in those cases, you may proceed with execution after writing the plan.
