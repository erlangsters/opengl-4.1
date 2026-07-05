-module(gl_renderbuffer_test).
-include_lib("eunit/include/eunit.hrl").

renderbuffer_test() ->
    gl_test_context:setup_context(),
    {ok, [Renderbuffer]} = gl:gen_renderbuffers(1),
    ok = gl:bind_renderbuffer(renderbuffer, Renderbuffer),
    {ok, true} = gl:is_renderbuffer(Renderbuffer),
    ok = gl:renderbuffer_storage(renderbuffer, rgba4, 1, 1),
    ok = gl:delete_renderbuffers([Renderbuffer]),
    {ok, false} = gl:is_renderbuffer(Renderbuffer),
    {ok, no_error} = gl:get_error().
