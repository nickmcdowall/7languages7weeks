:- module(utilities, [noDuplicates/1]).

noDuplicates([]).
noDuplicates([_]).
noDuplicates( [FirstItem|[SecondItem|Tail] ]):-
	(FirstItem \= SecondItem),
	append([FirstItem], Tail, Sublist),
	noDuplicates(Sublist),
	append([SecondItem], Tail, Sublist2),
	noDuplicates(Sublist2).