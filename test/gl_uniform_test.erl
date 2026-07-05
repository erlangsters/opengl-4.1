-module(gl_uniform_test).
-include_lib("eunit/include/eunit.hrl").

uniform_test() ->
    gl_test_context:setup_context(),
    {Program, VertexShader, FragmentShader} = create_program(),
    ok = gl:use_program(Program),
    ok = gl:uniform(f, -1, 1.0),
    ok = gl:uniform(i, -1, 1),
    ok = gl:uniform(f, -1, {1.0, 0.0}),
    ok = gl:uniform(f, -1, {1.0, 0.0, 0.0, 1.0}),
    ok = gl:uniform(i, -1, {1, 0, 0, 1}),
    ok = gl:uniform(f, -1, [1.0]),
    ok = gl:uniform(i, -1, [{1, 0, 0, 1}]),
    ok = gl:uniform_matrix(f, -1, {{1.0, 0.0}, {0.0, 1.0}}),
    ok = gl:uniform_matrix(f, -1, [{{1.0, 0.0}, {0.0, 1.0}}]),
    ok = gl:use_program(none),
    ok = delete_program(Program, VertexShader, FragmentShader),
    {ok, no_error} = gl:get_error().

create_program() ->
    {ok, VertexShader} = gl:create_shader(vertex_shader),
    ok = gl:shader_source(VertexShader, [[
        "attribute vec4 position; ",
        "uniform vec4 u_color; ",
        "varying vec4 v_color; ",
        "void main() { v_color = u_color; gl_Position = position; }"
    ]]),
    ok = gl:compile_shader(VertexShader),
    {ok, true} = gl:get_shader_compile_status(VertexShader),
    {ok, FragmentShader} = gl:create_shader(fragment_shader),
    ok = gl:shader_source(FragmentShader, [[
        "varying vec4 v_color; ",
        "void main() { gl_FragColor = v_color; }"
    ]]),
    ok = gl:compile_shader(FragmentShader),
    {ok, true} = gl:get_shader_compile_status(FragmentShader),
    {ok, Program} = gl:create_program(),
    ok = gl:attach_shader(Program, VertexShader),
    ok = gl:attach_shader(Program, FragmentShader),
    ok = gl:bind_attrib_location(Program, 0, ["pos", <<"ition">>]),
    ok = gl:link_program(Program),
    {Program, VertexShader, FragmentShader}.

delete_program(Program, VertexShader, FragmentShader) ->
    ok = gl:detach_shader(Program, FragmentShader),
    ok = gl:detach_shader(Program, VertexShader),
    ok = gl:delete_shader(FragmentShader),
    ok = gl:delete_shader(VertexShader),
    ok = gl:delete_program(Program),
    ok.
