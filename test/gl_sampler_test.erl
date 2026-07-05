-module(gl_sampler_test).
-include_lib("eunit/include/eunit.hrl").

sampler_test() ->
    gl_test_context:setup_context(),
    {ok, [Sampler]} = gl:gen_samplers(1),
    ok = gl:bind_sampler(0, Sampler),
    ok = gl:sampler_parameter(i, Sampler, texture_min_filter, 16#2600),
    ok = gl:sampler_parameter(f, Sampler, texture_max_lod, 1000.0),
    {ok, true} = gl:is_sampler(Sampler),
    ok = gl:bind_sampler(0, none),
    ok = gl:delete_samplers([Sampler]),
    {ok, false} = gl:is_sampler(Sampler),
    {ok, no_error} = gl:get_error().
