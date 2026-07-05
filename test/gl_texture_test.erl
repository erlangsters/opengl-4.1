-module(gl_texture_test).
-include_lib("eunit/include/eunit.hrl").

texture_test() ->
    gl_test_context:setup_context(),
    ok = gl:active_texture(texture0),
    {ok, [Texture]} = gl:gen_textures(1),
    ok = gl:bind_texture(texture_2d, Texture),
    ok = gl:tex_min_filter(texture_2d, nearest),
    ok = gl:tex_mag_filter(texture_2d, nearest),
    ok = gl:tex_wrap_s(texture_2d, clamp_to_edge),
    ok = gl:tex_wrap_t(texture_2d, clamp_to_edge),
    ok = gl:tex_parameter(f, texture_2d, texture_wrap_s, 33071.0),
    ok = gl:tex_parameter(i, texture_2d, texture_wrap_t, [16#812F]),
    {ok, true} = gl:is_texture(Texture),
    ok = gl:bind_texture(texture_2d, none),
    ok = gl:delete_textures([Texture]),
    {ok, false} = gl:is_texture(Texture),
    {ok, no_error} = gl:get_error().
