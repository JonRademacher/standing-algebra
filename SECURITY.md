Supported Versions
Only the latest released version of standing‑algebra is supported with security fixes. Older tags and commits remain available for reference but do not receive patches. This follows GitHub’s guidance to clearly define maintenance boundaries 
tenthirtyam.org
.
Version
Supported
Latest release (main branch)
✅ Supported
Any prior release
❌ Not supported
If you are using an unsupported version and encounter a security issue, please upgrade to the latest release before reporting.
Reporting a Vulnerability
To keep security reports private and avoid accidental public disclosure, do not open public issues, pull requests, or discussions for potential vulnerabilities 
tenthirtyam.org
.
Please use one of the following private reporting paths:
GitHub Private Vulnerability Reporting (preferred, if enabled for the repository) 
1
.
Email: security@jonrademacher.com (role‑based inbox recommended by GitHub’s examples 
2
).


2 Sources
If you report via email, please avoid sending sensitive production data or secrets.
Information to Include in a Report
Providing clear, reproducible details helps maintainers triage efficiently. GitHub’s example policies recommend including the following 
Github
+1
:
Type of issue (e.g., logic flaw, injection, privilege escalation)
Affected version, tag, or commit
Full file paths related to the issue (if applicable) 
1
Steps to reproduce the vulnerability
Proof‑of‑concept or minimal reproduction (if possible) 
1
Expected security impact
Any known mitigations or workarounds

1 Source
Reports missing key details may require follow‑up questions before triage can begin.
What to Expect After Reporting
A realistic response window is important for open‑source projects 
tenthirtyam.org
.
Acknowledgment: within 7 days
Initial triage: within 14 days
Follow‑up questions: via the same channel you used to report
If confirmed: maintainers will prepare a fix and coordinate disclosure timing with the reporter
If the issue only affects unsupported versions, remediation may consist of recommending an upgrade rather than issuing a patch 
tenthirtyam.org
.
Disclosure Process
Once a fix is ready, maintainers will:
Publish a GitHub Security Advisory for confirmed vulnerabilities 
1
.
Coordinate disclosure timing with the reporter when practical.
Patch supported versions; unsupported versions may not receive fixes.
Optionally lock draft advisories during triage to preserve metadata integrity, per GitHub’s advisory‑locking feature 
1
.


2 Sources
Inappropriate Reporting Paths
To protect users and maintainers from accidental public disclosure, do not report vulnerabilities through:
Public GitHub issues
Public pull requests
Public discussions
Social media
Direct messages to maintainers’ personal accounts 
1

1 Source
Scope and Expectations
This repository does not operate a formal bug bounty program (similar to GitHub’s own open‑source policy statement 
Github
). Reports are handled on a best‑effort basis by maintainers.
The policy defines:
Private reporting only
Clear supported‑version boundaries
Credible response windows
Coordinated disclosure when feasible
This keeps the policy operational without implying a corporate security program 
tenthirtyam.org
.
