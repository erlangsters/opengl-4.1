-module(gl_smoke_test).
-include_lib("eunit/include/eunit.hrl").

smoke_test() ->
    gl_test_context:setup_context(),
    {ok, no_error} = gl:get_error(),
    {ok, Version} = gl:get_string(version),
    ok = gl_test_support:assert_nonempty_binary(Version),
    {ok, no_error} = gl:get_error().
