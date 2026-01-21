# JNI Dependency Boundary

Architecture ID: `JDB`

## Ownership

This document owns Droid's boundary with JNIKit. JNIKit itself remains authority for raw JNI semantics.

## Invariants

- Droid may depend on JNIKit and expose higher-level ergonomic APIs.
- Droid must not duplicate a conflicting reference/thread/class-loader/signature ownership model.
- When a verified Android wrapper requires missing JNIKit capability, document the dependency and perform a targeted JNIKit audit rather than introducing unsafe local raw-JNI shortcuts.
- JNIKit inspection is read-only unless the maintainer separately authorizes work in that repository.

## Escalation

Inspect JNIKit when a Droid task materially depends on:

- new JNI descriptor/call support;
- local/global reference escape/retention behavior;
- class-loader/cache behavior;
- thread attachment/environment access;
- array/string/object conversion capability.

Do not load JNIKit for ordinary wrapper additions whose required JNIKit primitives are already established.
