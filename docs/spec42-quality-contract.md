# Spec42 quality-rule contract

**Status:** contracted / **not implemented** in Spec42 yet.

This document defines diagnostics Spec42 should eventually emit for Elan8 Method projects. Until implemented, treat them as review checklists (see [quality-rules.md](quality-rules.md)).

---

## ELAN8-QR-REQ-01 — Approved requirement missing subject

| Field | Value |
| --- | --- |
| Method rule | QR-REQ-01 |
| Proposed diagnostic id | `elan8.req.missing_subject` |
| Severity | error |
| Trigger | A `requirement` usage that is considered approved (e.g. `@StatusInfo { status = done; }` or project-defined approved set) has no `subject` |
| Out of scope | Draft/in-progress requirements; pure stakeholder need docs without approval |

**Bad (illustrative):**

```sysml
requirement stopOnCliff {
    @StatusInfo { status = done; }
    doc /* Shall stop after cliff detection. */
    // no subject
}
```

**Good:**

```sysml
requirement stopOnCliff {
    subject robot : CleaningRobot;
    @StatusInfo { status = done; }
    require constraint { robot.cliffReactionTime <= 100 [ms] }
}
```

---

## ELAN8-QR-REQ-03 — Critical requirement without verification case

| Field | Value |
| --- | --- |
| Method rule | QR-REQ-03 |
| Proposed diagnostic id | `elan8.req.missing_verification` |
| Severity | error |
| Trigger | A requirement tagged critical/safety (e.g. `@RequirementRole { role = safety; }` or project criticality metadata) is not referenced by any verification case `objective { verify … }` |
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

## Implementation notes (for Spec42 later)

- Prefer analyzing the KerML/SysML semantic graph, not regex on source text.
- Respect project tailoring: `small` profile may narrow which requirements are “critical.”
- Do not add non-executable YAML rule catalogs in repos until Spec42 can run them.
