# API Mapping

This binding exposes OpenGL through the BEAM-facing `gl` module. The API stays
close to OpenGL command identity while using Erlang and Elixir friendly runtime
values.

The generated API reference is the exact function and type inventory for this
target.

## Names

OpenGL command names become snake_case functions on `gl`.

Examples:

- `glCullFace` becomes `gl:cull_face/1`
- `glCreateShader` becomes `gl:create_shader/1`
- `glGetProgramInfoLog` becomes `gl:get_program_info_log/2`

## Enums, Bitfields, And Types

OpenGL enum constants are exposed as atoms:

- `GL_FRONT_AND_BACK` becomes `front_and_back`
- `GL_VERTEX_SHADER` becomes `vertex_shader`
- `GL_TEXTURE_2D` becomes `texture_2d`

OpenGL bitfields are lists of atoms:

```erlang
ok = gl:clear([color_buffer_bit, depth_buffer_bit]).
```

OpenGL scalar families keep named `gl:*()` types in specs, such as
`gl:int()`, `gl:uint()`, `gl:sizei()`, `gl:float()`, and `gl:double()`.
Object names use family-specific public types such as `gl:buffer()`,
`gl:texture()`, `gl:shader()`, and `gl:program()`.

The generated module also exposes enum helper functions:

- `gl:enum_groups_/0`
- `gl:enums_/1`
- `gl:enum_value_/1`
- `gl:value_enums_/1`
- `gl:value_enum_/2`

## Aggregates And Binary Data

Fixed-size numeric values use tuples. Vectors map by arity, and matrices use
tuples of column vectors.

```erlang
ok = gl:program_uniform(ui, Program, Location, {1, 0, 0, 1}).
```

Byte-oriented input data uses `iodata()`. Output buffers are returned as BEAM
values instead of exposing writable host memory. When OpenGL cannot report a
portable output size up front, wrappers use explicit public capacities or
element counts.

## Return Values

Commands with no result return `ok` or `{error, Reason}`. Commands with
outputs return `{ok, Value}` or `{ok, Value1, Value2, ...}`.

The `gl` module assumes a valid OpenGL or OpenGL ES context is already current
through the EGL binding.
