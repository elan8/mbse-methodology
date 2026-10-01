# Quality diagnostic contract

**Status:** proposed diagnostic behavior; implementation depends on the chosen modeling environment.

This document defines tool-independent diagnostic expectations for Elan8 Method projects. Until a chosen validator implements them, treat them as review checklists (see [quality-rules.md](quality-rules.md)).

---

## ELAN8-QR-REQ-01 — Approved requirement missing subject

| Field | Value |
| --- | --- |
| Method rule | QR-REQ-01 |
| Proposed diagnostic id | `elan8.req.missing_subject` |
| Severity | error |
| Trigger | A `requirement` usage that is considered approved (e.g. `@StatusInfo { status = StatusKind::done; }` or project-defined approved set) has no `subject` |
| Out of scope | Draft/in-progress requirements; pure stakeholder need docs without approval |

**Bad (illustrative):**

```sysml
requirement removeDriveEnable {
    @StatusInfo { status = StatusKind::done; }
    doc /* Shall remove drive enable on guard opening. */
    // no subject
}
```

**Good:**

```sysml
requirement removeDriveEnable {
    subject controller : Controller;
    @StatusInfo { status = StatusKind::done; }
    require constraint { controller.responseTime <= 0.200 [s] }
}
```

---

## ELAN8-QR-REQ-03 — Critical requirement without verification case

| Field | Value |
| --- | --- |
| Method rule | QR-REQ-03 |
| Proposed diagnostic id | `elan8.req.missing_verification` |
| Severity | error |
| Trigger | A requirement tagged critical/safety (e.g. `@RequirementRole { role = RequirementRoleKind::safety; }` or project criticality metadata) is not referenced by any verification case `objective { verify … }` |
| Out of scope | User needs that are only derived further; deprecated requirements |

**Bad:** safety system requirement with `satisfy` but no `verification` case that `verify`s it.

**Good:** see [examples/se-patterns/minimal-traceability](../examples/se-patterns/minimal-traceability/minimal-traceability.sysml).

**Intentional gap fixture:** [missing-verification](../examples/se-patterns/missing-verification/missing-verification.sysml).

---

## ELAN8-QR-VER-COV — Verification coverage gap report

| Field | Value |
| --- | --- |
| Method rules | QR-VER-03 (and related) |
| Proposed diagnostic id | `elan8.ver.coverage_gap` |
| Severity | warning |
| Trigger | Workspace report of system/safety requirements lacking verification linkage |
| Out of scope | Computing pass/fail from external test labs; storing raw test data in the model |

---

## Implementation guidance

- Prefer analyzing the KerML/SysML semantic graph, not regex on source text.
- Define requirement criticality from the relevant hazards and assurance obligations; omitting a stage does not waive verification of critical requirements.
- Use executable checks where supported; otherwise make the review checklist explicit.
