# v1.2.0 release preparation

Status: release candidate, not tagged or published. The changelog is intentionally Unreleased.

## Scope

Calibrate from the intended publisher's voice source, preserve claims and asks, and report missing substance without inventing it. Keep existing output headers and the default rewrite/detect behavior. Install the resources referenced by setup.

## Validation

- Repository validator: passed, 261-character description and 305-line body.
- Shell syntax and git whitespace checks: passed.
- Fresh and repeated installation into a temporary target: passed. Reference, example, and documentation contents matched the source; no nested resource directories appeared.
- Local Markdown links: checked for existing targets.
- Independent read-only review: corrected conflicting qualifier, pronoun, setup, and authorship guidance. Existing output headers were confirmed unchanged.
- One forward exercise preserved a date, number, uncertainty, request, technical term, code, and explicit punctuation preferences without editing them.
- Two qualitative baseline/current simulations covered a hollow update and competing brand/personal profiles. Both versions could return safe output; the new version removes contradictory instructions. These are reviewer exercises, not controlled model benchmarks or evidence of a measured quality gain.

## Release steps

1. Review and merge the release pull request after CI passes.
2. Replace Unreleased with the actual release date and remove the README's release-candidate label.
3. Tag the reviewed commit as v1.2.0 and publish release notes based on CHANGELOG.md.

No tag or published release is part of this preparation.
