# OpenAI / AI Google Drive Access and Privacy — Director Create-Only Mandate

**Canonical Director Policy:** OAI-DRIVE-APPEND-ONLY-001 v1.0, 2026-11-18.
**Private source document:** https://docs.google.com/document/d/18nexuzVfOEWwM7vXcPcB1NkjQHsEGKWxZHSqo-qlBRs/edit
**My Drive root:** `0. Open AI - Access & Privacy Rules`.
**Adoption:** draft PR until human-approved merge. Never claim runtime enforcement from this document.

**Non-negotiable default:** AI MAY READ existing authorized Google Drive files; AI MAY CREATE entirely NEW private files/folders with new IDs in specifically authorized destinations and initialize them during the creation transaction. Every file, including a newly created file after its initialization, is READ-ONLY by default for AI. **DENY** change to existing content or metadata, editing, overwriting, renaming, moving, permission/sharing changes, trashing, deleting, purging, deduplicating, sync mirroring/deleting, rollback, cleanup and deletion of temporary artifacts without explicit prior Director consent for exact Drive IDs and exact effects.

Before any such action: identify target IDs/path, preview change and consequences, request and receive exact-scope approval, verify approval immediately before the API call, log the outcome; absent approval/policy/evidence means fail closed. Do not infer authorization from OAuth, repository rights, an automation, a general request or a previous unrelated approval. No private Drive exfiltration into public repos. Consumer services must implement server-side enforcement and negative tests; neither this policy reference nor a PR proves enforcement. Observe all CDX, AMA, FFOS, FFC, Pius and repository governance.
