# Android Wrapper Architecture

Architecture ID: `WRP`

## Ownership

This document owns semantic mapping from Android/AndroidX/Material platform classes into Droid Swift wrappers.

Detailed implementation patterns are owned by `../ANDROID_CLASS_WRAPPERS.md` within these semantic boundaries.

## Identity and Exactness

- A wrapper represents the exact intended Java/Kotlin class identity and inheritance relationship.
- Methods, properties, constructors, nested/listener types, constants, overloads, nullability, availability/API level, and return semantics must match verified upstream contracts.
- Do not infer missing signatures from neighboring wrappers or naming similarity.
- Preserve overloaded APIs only when the Swift surface can distinguish them safely and the JNI signature is verified.

## Properties and Actions

- Use established deferred apply-or-append behavior for values that may be set before native instance creation.
- Use direct live-instance calls for actions that require current Android object state.
- Getter/setter semantics must remain truthful; do not fabricate cached Swift state as a substitute for Android state unless architecture explicitly owns such state.

## Listeners

- Listener bridges must preserve Android callback identity, Swift closure lifetime, actor expectations, and JNI reference ownership.
- Missing listener bridge capability is a blocker/TODO, not permission to guess raw JNI wiring.

## Coverage

`WRAPPED_CLASSES.md` can help navigate known wrappers, but wrapper existence or a tooling report is not proof that the upstream public API surface is semantically complete.

## Evidence

Use current authoritative Android reference/source evidence plus existing local wrapper patterns. MCP tooling can accelerate resolution/audit but cannot replace source-level semantic review.
