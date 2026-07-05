-module(gl_shader_test).
-include_lib("eunit/include/eunit.hrl").

shader_test() ->
    gl_test_context:setup_context(),
    {ok, Shader} = gl:create_shader(vertex_shader),
    {ok, true} = gl:is_shader(Shader),
    ok = gl:shader_source(Shader, [[
        "attribute vec4 position; ",
        "uniform vec4 u_color; ",
        "varying vec4 v_color; ",
        "void main() { v_color = u_color; gl_Position = position; }"
    ]]),
    {ok, Source} = gl:get_shader_source(Shader, 4096),
    ok = gl_test_support:assert_nonempty_binary(Source),
    ok = gl:compile_shader(Shader),
    {ok, true} = gl:get_shader_compile_status(Shader),
    {ok, InfoLog} = gl:get_shader_info_log(Shader, 1024),
    ok = gl_test_support:assert_binary(InfoLog),
    ok = gl:delete_shader(Shader),
    {ok, false} = gl:is_shader(Shader),
    {ok, no_error} = gl:get_error().
