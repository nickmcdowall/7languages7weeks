-module(count).
-export([count_to_ten/0]).

count_to_ten() -> count_to_ten(0).

count_to_ten(10) -> 10;
count_to_ten(X) -> 
	io:format("~p ~n", [X]), 
	count_to_ten(X + 1).