# Frozen dependency

`elan8-domain-libraries-0.5.0.kpar` is a local release-candidate snapshot containing the independent method roles and four view definitions. It has not been published as a release. Its SHA-256 and production source digest are recorded in `../dependencies.lock.json`; the adjacent LICENSE covers its sources.

Default validation checks the archive checksum, unpacks it with the pinned Spec42 version, and checks cached source contents. It does not depend on the state of a sibling Git checkout. An explicit `-DomainLibraryPath` is available for development and is reported as an override.

Rebuild this artifact from the intended domain-library revision, then deliberately update the lock when changing dependencies. Merely changing the filename/version or editing the extracted cache does not update the baseline. The standard-library source digest uses `scripts/source_digest.ps1`, as does validation.
