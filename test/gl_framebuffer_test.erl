-module(gl_framebuffer_test).
-include_lib("eunit/include/eunit.hrl").

framebuffer_test() ->
    gl_test_context:setup_context(),
    {ok, [Renderbuffer]} = gl:gen_renderbuffers(1),
    ok = gl:bind_renderbuffer(renderbuffer, Renderbuffer),
    ok = gl:renderbuffer_storage(renderbuffer, rgba4, 1, 1),
    {ok, [Framebuffer]} = gl:gen_framebuffers(1),
    ok = gl:bind_framebuffer(framebuffer, Framebuffer),
    {ok, true} = gl:is_framebuffer(Framebuffer),
    ok = gl:framebuffer_renderbuffer(framebuffer, color_attachment0, renderbuffer, Renderbuffer),
    {ok, framebuffer_complete} = gl:check_framebuffer_status(framebuffer),
    ok = gl:delete_framebuffers([Framebuffer]),
    {ok, false} = gl:is_framebuffer(Framebuffer),
    ok = gl:delete_renderbuffers([Renderbuffer]),
    {ok, false} = gl:is_renderbuffer(Renderbuffer),
    {ok, no_error} = gl:get_error().
