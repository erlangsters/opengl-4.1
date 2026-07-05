-module(gl_program_test).
-include_lib("eunit/include/eunit.hrl").

program_test() ->
    gl_test_context:setup_context(),
    {Program, VertexShader, FragmentShader} = create_program(),
    {ok, true} = gl:is_program(Program),
    {ok, AttachedShaders} = gl:get_attached_shaders(Program, 2),
    ?assertEqual(lists:sort([VertexShader, FragmentShader]), lists:sort(AttachedShaders)),
    {ok, 0} = gl:get_attrib_location(Program, ["pos", <<"ition">>]),
    {ok, ColorLocation} = gl:get_uniform_location(Program, ["u_", <<"color">>]),
    ok = gl_test_support:assert_non_negative_integer(ColorLocation),
    {ok, -1} = gl:get_uniform_location(Program, ["u_", <<"missing">>]),
    {ok, true} = gl:get_program_link_status(Program),
    ok = gl:validate_program(Program),
    {ok, true} = gl:get_program_validation_status(Program),
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
    {ok, false} = gl:is_shader(FragmentShader),
    {ok, false} = gl:is_shader(VertexShader),
    ok = gl:delete_program(Program),
    {ok, false} = gl:is_program(Program),
    ok.
