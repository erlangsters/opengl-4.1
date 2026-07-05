-module(gl_draw_test).
-include_lib("eunit/include/eunit.hrl").

draw_test() ->
    gl_test_context:setup_context(),
    ok = gl_test_support:drain_errors(),
    ok = gl:draw_arrays(triangles, 0, 0),
    ok = gl_test_support:assert_allowed_error([no_error, invalid_operation]).
