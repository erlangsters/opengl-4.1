# OpenGL 4.1 binding for the BEAM

[![Erlangsters Repository](https://img.shields.io/badge/erlangsters-opengl--4.1-%23a90432)](https://github.com/erlangsters/opengl-4.1)
![Supported Erlang/OTP Versions](https://img.shields.io/badge/erlang%2Fotp-28-%23a90432)
![Current Version](https://img.shields.io/badge/version-0.0.1-%23354052)
![License](https://img.shields.io/github/license/erlangsters/opengl-4.1)
[![Build Status](https://img.shields.io/github/actions/workflow/status/erlangsters/opengl-4.1/build.yml)](https://github.com/erlangsters/opengl-4.1/actions/workflows/build.yml)
[![Documentation Link](https://img.shields.io/badge/documentation-available-yellow)](https://erlangsters.github.io/opengl-4.1/)

This repository contains the generated OpenGL 4.1 binding for Erlang and
Elixir. The public API is exposed through the `gl` module and follows the
OpenGL 4.1 core target selected by the Erlangsters OpenGL binding generator.

The binding uses the [EGL binding](https://github.com/erlangsters/egl-1.5) for
context and surface management. The [GLFW binding](https://github.com/erlangsters/glfw)
can be used when an application needs a window.

## Install

With Rebar3:

```erlang
{deps, [
    {egl, {git, "https://github.com/erlangsters/egl-1.5.git", {tag, "master"}}},
    {gl, {git, "https://github.com/erlangsters/opengl-4.1.git", {tag, "master"}}}
]}.
```

Pin a release tag or commit in applications that need reproducible builds.

## Minimal Context

```erlang
Display = egl:get_display(default_display),
{ok, _} = egl:initialize(Display),

{ok, Configs} = egl:choose_config(Display, [
    {surface_type, [pbuffer_bit]},
    {renderable_type, [opengl_bit]}
]),
Config = hd(Configs),

{ok, Surface} =
    egl:create_pbuffer_surface(Display, Config, [{width, 1}, {height, 1}]),

egl:bind_api(opengl_api),
{ok, Context} = egl:create_context(Display, Config, no_context, [
    {context_major_version, 4},
    {context_minor_version, 1}
]),

ok = egl:make_current(Display, Surface, Surface, Context),
ok = gl:glad_load_gl(),

{ok, Version} = gl:get_string(version).
```

From Elixir, the same module is available as `:gl`:

```elixir
{:ok, version} = :gl.get_string(:version)
```

## Documentation

- [API reference](https://erlangsters.github.io/opengl-4.1/)
- [API mapping](docs/api-mapping.md)
- [Context and testing](docs/context-and-testing.md)
- [Limitations](docs/limitations.md)

Examples live in the
[opengl-samples](https://github.com/erlangsters/opengl-samples) repository.

## Regenerating

This repository is generated. To reproduce the generated files, build the
[OpenGL binding generator](https://github.com/erlangsters/opengl-x.y-generator)
and run:

```bash
rebar3 escriptize
./_build/default/bin/opengl_gen gl 4.1
```

Do not hand-edit generated `gl.erl`, `gl.hrl`, or `gl.c` files in this target
repository.
