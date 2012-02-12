:- module(utilities, [allBetween/3]).

%Equivalent to fd_domain, it runs each element against between/3 predicate.
allBetween([], Lower, Upper).
allBetween([Head|Tail], Lower, Upper) :-
	between(Lower, Upper, Head),
	allBetween(Tail, Lower, Upper).