-module(gl_transform_feedback_test).
-include_lib("eunit/include/eunit.hrl").

transform_feedback_test() ->
    gl_test_context:setup_context(),
    {ok, [TransformFeedback]} = gl:gen_transform_feedbacks(1),
    ok = gl:bind_transform_feedback(transform_feedback, TransformFeedback),
    {ok, true} = gl:is_transform_feedback(TransformFeedback),
    ok = gl:delete_transform_feedbacks([TransformFeedback]),
    {ok, no_error} = gl:get_error().
