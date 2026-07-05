-module(gl_test_support).
-include_lib("eunit/include/eunit.hrl").

-export([
    assert_binary/1,
    assert_allowed_error/1,
    drain_errors/0,
    assert_non_negative_integer/1,
    assert_nonempty_binary/1
]).

assert_binary(Value) ->
    ?assert(is_binary(Value)),
    ok.

assert_allowed_error(Allowed) ->
    {ok, Error} = gl:get_error(),
    ?assert(lists:member(Error, Allowed)),
    ok.

assert_nonempty_binary(Value) ->
    ?assert(is_binary(Value)),
    ?assert(byte_size(Value) > 0),
    ok.

assert_non_negative_integer(Value) ->
    ?assert(is_integer(Value)),
    ?assert(Value >= 0),
    ok.

drain_errors() ->
    case gl:get_error() of
        {ok, no_error} ->
            ok;
        {ok, _Error} ->
            drain_errors()
    end.
