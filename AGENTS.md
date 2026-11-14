# AGENTS.md

Instructions for AI coding agents (Claude Code, Codex, Copilot and others). Read README.md for what the project is.

## ForgerWise workflow (read before you change anything)

These are the owner's current rules for every AI agent working on this repository.

- Talk to the owner in Traditional Chinese. Code, comments and commit messages are in English.
- Never push to `main`. Work on your own branch and open a pull request into `main`.
- Merge only when every check on the pull request's latest commit has finished and passed. "Queued", "in progress" and "expected" are not passed: wait. Never bypass a ruleset or merge as admin.
- Do not change anything under `.github/` (workflows, actions, scripts). If one must change, open the pull request and leave the merge to the owner.
- FoodList is public, so CI uses GitHub's free hosted runners by default (repository variable `CI_RUNS_ON` can point it at the home PC). Never ask the owner to raise the GitHub Actions budget. The owner's own work goes straight into `main` through pull requests; `develop` has not been used since 2026-09.
- Heavy builds (Android AAB, game builds, site builds that get deployed) run on the home PC. Never switch a build to a cloud runner yourself.
- Store releases are done by the owner. Do not upload to Google Play yourself.
