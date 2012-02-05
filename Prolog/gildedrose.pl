
item(dexterityVest).
item(brie).
item(elixerOfMongoose).
item(sulfuras).
item(concertTickets).
item(conjured).

startingSellin(dexterityVest, 10).
startingSellin(brie, 2).
startingSellin(elixerOfMongoose, 5).
startingSellin(sulfuras, 0).
startingSellin(concertTickets, 15).
startingSellin(conjured, 6).

startingQuality(dexterityVest, 20).
startingQuality(brie, 0).
startingQuality(elixerOfMongoose, 7).
startingQuality(sulfuras, 80).
startingQuality(concertTickets, 20).
startingQuality(conjured, 6).

updateIncrementToQuality(brie, +1).
updateIncrementToQuality(concertTickets, +1).
updateIncrementToQuality(dexterityVest, -1).
updateIncrementToQuality(elixerOfMongoose, -1).
updateIncrementToQuality(conjured, -2).

minimumQuality(0).
maximumQuality(50).

worthlessAfterSellby(concertTickets).
	
updateQuality(Item, NextQuality):-
	item(Item),
	startingQuality(Item, StartingQuality),
	startingSellin(Item, StartingSellin),
	updateQuality(Item, NextQuality, StartingSellin, StartingQuality).
updateQuality(sulfuras, 80, 0, 80).
updateQuality(Item, NextQuality, StartingSellin, StartingQuality):-
	item(Item),
	\+(Item = sulfuras),
	maximumQuality(MaxQ),
	between(0, MaxQ, StartingQuality),
	nextQuality(StartingQuality, Item, StartingSellin, NextQuality).


nextQuality(_CurrentQuality, Item, Sellin, NextQuality) :- (Sellin < 1), worthlessAfterSellby(Item), NextQuality is 0.
nextQuality(CurrentQuality, Item, Sellin, NextQuality) :-
	degradingFactor(Item, Sellin, DegradingFactor),
	updateIncrementToQuality(Item, Increment),
	maximumQuality(Max),
	minimumQuality(Min),
	between(Min, Max, IncrementedQuality),
	IncrementFactor is (Increment * DegradingFactor),
	CurrentQuality is IncrementedQuality - IncrementFactor,
	NextQuality = IncrementedQuality.

degradingFactor(concertTickets, Sellin, 3):- between(1, 5, Sellin).
degradingFactor(concertTickets, Sellin, 2):- between(6, 10, Sellin).
degradingFactor(concertTickets, Sellin, 1):- between(11, inf, Sellin).
degradingFactor(Item, Sellin, 1):- between(1, inf, Sellin), \+(Item = concertTickets).
degradingFactor(Item, Sellin, 2):- \+between(1, inf, Sellin), \+(Item = concertTickets).

	
%%%%%%%%%%% Tests %%%%%%%%%%%

testAll :-
	testDegradingFactor,
	testUpdateQuality.
	
testDegradingFactor :-
	print('-- degradingFactor(Item, Sellin, DegradingFactor) --'), nl,
	Test1 =.. [degradingFactor, concertTickets, 1, 3], 		print(Test1), call(Test1), print(' - Pass'), nl,
	Test2 =.. [degradingFactor, concertTickets, 6, 2], 		print(Test2), call(Test2), print(' - Pass'), nl,
	Test3 =.. [degradingFactor, concertTickets, 11, 1], 		print(Test3), call(Test3), print(' - Pass'), nl,
	Test4 =.. [degradingFactor, brie, 0, 2], 		print(Test4), call(Test4), print(' - Pass'), nl,
	Test5 =.. [degradingFactor, conjured, -1, 2], 		print(Test5), call(Test5), print(' - Pass'), nl.
	
testUpdateQuality :-
	print('-- updateQuality(Item, NextQuality, StartingSellin, StartingQuality) --'), nl,
	Test6 =.. [updateQuality, dexterityVest, 4, 5, 5], 	print(Test6), call(Test6), print(' - Pass'), nl,
	Test7 =.. [updateQuality, dexterityVest, 4, 0, 6], 	print(Test7), call(Test7), print(' - Pass'), nl,
	Test8 =.. [updateQuality, brie, 12, 0, 10], 		print(Test8), call(Test8), print(' - Pass'), nl,
	Test9 =.. [updateQuality, brie, 11, 1, 10], 		print(Test9), call(Test9), print(' - Pass'), nl,
	Test10 =.. [updateQuality, sulfuras, 80, 0, 80], 	print(Test10), call(Test10), print(' - Pass'), nl,
	Test12 =.. [updateQuality, conjured, 8, 5, 10], 	print(Test12), call(Test12), print(' - Pass'), nl,
	Test13 =.. [updateQuality, conjured, 6, 0, 10], 	print(Test13), call(Test13), print(' - Pass'), nl,
	Test14 =.. [updateQuality, concertTickets, 0, 0, 10], 	print(Test14), call(Test14), print(' - Pass'), nl,
	Test15 =.. [updateQuality, concertTickets, 11, 11, 10],	print(Test15), call(Test15), print(' - Pass'), nl,
	Test15b =.. [updateQuality, concertTickets, 12, 7, 10],	print(Test15b), call(Test15b), print(' - Pass'), nl,
	Test16 =.. [updateQuality, concertTickets, 13, 5, 10], 	print(Test16), call(Test16), print(' - Pass'), nl,
	Test16a =.. [updateQuality, concertTickets, 0, 0, 50], 	print(Test16a), call(Test16a), print(' - Pass'), nl,
	Test16b =.. [updateQuality, dexterityVest, 48, 0, 50], 	print(Test16b), call(Test16b), print(' - Pass'), nl,
	Test16c =.. [updateQuality, elixerOfMongoose, 48, 0, 50], 	print(Test16c), call(Test16c), print(' - Pass'), nl,
	Test16d =.. [updateQuality, conjured, 46, 0, 50], 	print(Test16d), call(Test16d), print(' - Pass'), nl,
	print('-- updateQuality(Item, NextQuality, NextSellin) --'), nl,
	Test17 =.. [updateQuality, dexterityVest, 19], 	print(Test17), call(Test17), print(' - Pass'), nl,
	Test18 =.. [updateQuality, brie, 1], 		print(Test18), call(Test18), print(' - Pass'), nl,
	Test19 =.. [updateQuality, elixerOfMongoose, 6], 	print(Test19), call(Test19), print(' - Pass'), nl,
	Test20 =.. [updateQuality, sulfuras, 80], 		print(Test20), call(Test20), print(' - Pass'), nl,
	Test21 =.. [updateQuality, conjured, 4], 		print(Test21), call(Test21), print(' - Pass'), nl,
	Test22 =.. [updateQuality, concertTickets, 21], 	print(Test22), call(Test22), print(' - Pass'), nl.

