-module(gl_buffer_test).
-include_lib("eunit/include/eunit.hrl").

buffer_test() ->
    gl_test_context:setup_context(),
    {ok, [Buffer]} = gl:gen_buffers(1),
    ok = gl:bind_buffer(array_buffer, Buffer),
    {ok, true} = gl:is_buffer(Buffer),
    ok = gl:buffer_data(array_buffer, <<0, 1, 2, 3>>, static_draw),
    ok = gl:buffer_sub_data(array_buffer, 1, <<9, 8>>),
    ok = gl:bind_buffer(array_buffer, none),
    ok = gl:delete_buffers([Buffer]),
    {ok, false} = gl:is_buffer(Buffer),
    {ok, no_error} = gl:get_error().
