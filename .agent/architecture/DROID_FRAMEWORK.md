# Droid Framework Architecture

Architecture ID: `DRD`

## Ownership

This document owns Droid framework behavior outside raw Android wrapper mapping: application configuration/entry, lifecycle, manifest and Gradle DSLs, declarative view/state composition, and SwifDroid-owned framework abstractions.

## Source Authority

Droid source is the source of truth. Generated Android projects consume it. Do not modify generated output to compensate for missing/incorrect framework source behavior.

## State and Lifecycle

- UI-facing state/listener behavior preserves established actor/lifecycle ownership, including `@MainActor` where required by current design.
- Derived/rendered state must not silently become a second authoritative model when an established owner already exists.
- Listener/callback retention must survive for exactly the required Android object lifecycle and avoid accidental cycles/leaks.

## Deferrable Configuration

- Properties/layout parameters that can be configured before a native instance exists follow the established apply-or-append/deferred application model.
- Actions that semantically require a live native instance call that instance directly rather than pretending to be deferred configuration.
- Do not flatten these categories merely to make fluent APIs uniform.

## Manifest and Gradle Metadata

Components that require manifest/Gradle/dependency metadata must keep that metadata synchronized with the Swift abstraction that introduces the requirement.

## API Shape

Prefer idiomatic, discoverable Swift APIs while preserving exact Android behavior. Avoid speculative universal abstraction when a narrow proven framework behavior is sufficient.
