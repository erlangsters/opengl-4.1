-module(gl_vertex_array_test).
-include_lib("eunit/include/eunit.hrl").

vertex_array_test() ->
    gl_test_context:setup_context(),
    {ok, [VertexArray]} = gl:gen_vertex_arrays(1),
    ok = gl:bind_vertex_array(VertexArray),
    {ok, true} = gl:is_vertex_array(VertexArray),
    ok = gl:enable_vertex_attrib_array(0),
    ok = gl:disable_vertex_attrib_array(0),
    ok = gl:bind_vertex_array(none),
    ok = gl:delete_vertex_arrays([VertexArray]),
    {ok, false} = gl:is_vertex_array(VertexArray),
    {ok, no_error} = gl:get_error().
