-module(error_message).
-export([input/1]).

input({error, Message}) -> 
	io:format("error: ~p ~n", [Message]);
input(success) -> 
	io:format("success ~n").
