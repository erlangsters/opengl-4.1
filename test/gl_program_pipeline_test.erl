-module(gl_program_pipeline_test).
-include_lib("eunit/include/eunit.hrl").

program_pipeline_test() ->
    gl_test_context:setup_context(),
    {ok, [Pipeline]} = gl:gen_program_pipelines(1),
    ok = gl:bind_program_pipeline(Pipeline),
    {ok, true} = gl:is_program_pipeline(Pipeline),
    ok = gl:delete_program_pipelines([Pipeline]),
    {ok, no_error} = gl:get_error().
