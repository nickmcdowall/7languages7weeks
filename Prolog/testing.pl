:- module(testing, [assertTrue/1, assertFalse/1]).

assertTrue([]).
assertTrue([FirstTest|OtherTests]) :-
	Test =.. FirstTest, print('AssertTrue: '), print(Test), call(Test), print(' - Pass'), nl,
	assertTrue(OtherTests).
	
assertFalse([]).
assertFalse([FirstTest|OtherTests]) :-
	Test =.. FirstTest, print('AssertFalse: '), print(Test), \+call(Test), print(' - Pass'), nl,
	assertFalse(OtherTests).