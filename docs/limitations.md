# Limitations

This binding intentionally exposes a safe generated subset of the target
OpenGL surface.

## Out Of Scope

- Compatibility-profile commands are not included in the generated desktop
  targets.
- Extension loading and ad hoc function-pointer lookup are not supported.
- Raw host pointers, mapped-memory lifetimes, callback ownership, `GLsync`,
  pointer labels, and pointer queries are not exposed as ordinary Erlang
  terms.
- Client-side element-index arrays and client-side indirect command payloads
  are not exposed; supported draw wrappers use buffer offsets where OpenGL
  provides that model.
- Automatic allocation helpers are not provided for output families that need
  explicit capacities or counts to stay portable.

## Runtime Caveats

The available function inventory depends on this target's Khronos version and
profile. The generated API reference is authoritative for the target.

Some OpenGL behavior is driver, profile, extension, or surface dependent. The
runtime tests are smoke and proof tests for the binding; they do not guarantee
that every driver supports every feature path your application may choose.
