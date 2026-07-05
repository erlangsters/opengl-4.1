-module(gl_query_test).
-include_lib("eunit/include/eunit.hrl").

query_test() ->
    gl_test_context:setup_context(),
    ok = gl_test_support:drain_errors(),
    {ok, [Query]} = gl:gen_queries(1),
    ok = gl:begin_query(any_samples_passed, Query),
    ok = gl:draw_arrays(points, 0, 0),
    ok = gl:end_query(any_samples_passed),
    {ok, true} = gl:is_query(Query),
    ok = gl:delete_queries([Query]),
    {ok, false} = gl:is_query(Query),
    ok = gl_test_support:assert_allowed_error([no_error, invalid_operation]).
