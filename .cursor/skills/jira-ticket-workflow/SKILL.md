---
name: jira-ticket-workflow
description: End-to-end Jira ticket workflow — read the ticket, plan, wait for a nod, implement on task/<id>, commit, and open a brief GitHub PR. Use when the user invokes this skill with a Jira URL or key (e.g. SCRUM-7, https://*.atlassian.net/browse/...), or asks to work a Jira ticket this way.
disable-model-invocation: true
---

# Jira ticket workflow

User gives a Jira link (or key) and invokes this skill. Follow the gates below. Do not skip the nod.

## Model routing

Use **cheap/free Composer** for ticket-tracker and GitHub/ADO I/O. Use **Grok 4.5** (or the latest Grok 4.x available) only for planning and implementing the actual task.

Launch `Task` subagents with:

| Work | `model` | `subagent_type` |
|---|---|---|
| Read/write Jira, Azure DevOps, GitHub (`gh`, PRs, pushes, comments) | `composer-2.5-fast` | `generalPurpose` |
| Plan the change; implement code/tests/UI | latest Grok 4.x, currently `cursor-grok-4.6-high-fast` | `generalPurpose` (or this parent session if it already is Grok 4.x) |

If this parent session is already Grok 4.x, **plan and implement here**. Still delegate Jira/ADO/GitHub read/write to a Composer `Task`. Do not use Grok for `gh pr`, `git push`, Jira/ADO API, or issue comments.

If this parent is Composer, delegate **plan** and **implement** to a Grok `Task`; keep I/O on Composer (parent or Composer `Task`).

## Hard gates

1. **Read** the ticket (Composer).
2. **Plan** the changes (Grok). Show the plan. **Stop.**
3. Create local branch `task/<TASK-ID>` from `main` (Composer may run git; Grok may if already in-session).
4. Wait until the user **nods** (yes / go / lgtm / proceed / implement). No code edits before that.
5. **Implement** (Grok). Keep behavior unless the ticket asks otherwise. Do not go fancy on abstract UI tickets.
6. **Commit** and **open a PR with a brief summary** (Composer).

```
Progress:
- [ ] Read ticket
- [ ] Plan (stop for nod)
- [ ] Branch task/<TASK-ID> from main
- [ ] Nod received
- [ ] Implement
- [ ] Commit + PR
```

## Step 1 — Read the ticket (Composer)

Parse key from URL (`/browse/SCRUM-7`) or a bare key.

**Jira (Atlassian MCP):** `getAccessibleAtlassianResources` once per session → `getJiraIssue` with `cloudId` + `issueIdOrKey`, `view: "full"`. Fetch comments if the count is > 0 (`listJiraIssueComments` via execute-family). Return: key, summary, type, status, parent, description, acceptance criteria, repo links, comments.

**Azure DevOps:** If the user points at ADO (work item URL or org/project), read/write via `az boards` / ADO REST or an available ADO MCP — still Composer. Same return shape.

If auth fails, say so and stop.

## Step 2 — Plan (Grok)

Inspect the repo enough to name files. Then present:

```markdown
**Ticket:** [KEY](url) — summary
**Branch:** `task/<TASK-ID>` (from `main`)

### Plan
- ...

### Out of scope
- ...

### Verify
- ...
```

Keep plans small when the ticket is abstract. **Stop. Do not implement.**

## Step 3 — Branch

After the plan is shown (before or with the wait for nod):

```bash
git checkout main && git pull --ff-only origin main
git checkout -b task/<TASK-ID>
```

`<TASK-ID>` is the Jira/ADO key, e.g. `task/SCRUM-7`. If the branch exists, reuse it.

## Step 4 — Nod

Treat as a nod: `yes`, `y`, `ok`, `okay`, `go`, `lgtm`, `proceed`, `implement`, `approved`, `do it`.

Treat as a change request: any edit to the plan — revise plan, **stop again**.

If they nod with extras (“go, but skip X”), apply that.

## Step 5 — Implement (Grok)

Stay on `task/<TASK-ID>`. Match existing style. No drive-by refactors. UI work: verify in Cursor’s built-in browser (`cursor-ide-browser`) against localhost if a server is up; Playwright MCP is not required. Run relevant tests.

## Step 6 — Commit and PR (Composer)

Commit only the ticket files. Message: why, 1–2 sentences. Do not amend unless the user asks.

Push and open PR against `main`:

```bash
git push -u origin HEAD
gh pr create --title "<TASK-ID>: <short title>" --body "$(cat <<'EOF'
## Summary
- <1–3 bullets>

## Test plan
- [ ] <checks>

EOF
)"
```

Title may be the ticket summary. Body stays **brief**. Return the PR URL.

If GitHub is unavailable and the remote is Azure DevOps, Composer uses `az repos pr create` (or ADO MCP) with the same brief summary.

Do not merge unless asked.

## Auth notes

- GitHub: `gh`; if missing/unauthenticated, install/login (Composer).
- Jira: Atlassian MCP; `cloudId` every call.
- ADO: `az login` / PAT only if needed; never commit secrets.
