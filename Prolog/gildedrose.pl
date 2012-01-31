
item(dexterityVest, basicDecrease, canAge).
item(brie, basicIncrease, canAge).
item(elixerOfMongoose, basicDecrease, canAge).
item(sulfuras, static, ageless).
item(conjured, modestDecrease, canAge).

startingSellin(dexterityVest, 10).
startingSellin(brie, 2).
startingSellin(elixerOfMongoose, 5).
startingSellin(sulfuras, 0).
startingSellin(concertPasses, 15).
startingSellin(conjured, 6).

startingQuality(dexterityVest, 20).
startingQuality(brie, 0).
startingQuality(elixerOfMongoose, 7).
startingQuality(sulfuras, 80).
startingQuality(conjured, 6).

updateToQuality(basicIncrease, 1).
updateToQuality(basicDecrease, -1).
updateToQuality(modestDecrease, -2).
updateToQuality(static, 0).

sellinUpdateAmount(canAge, -1).
sellinUpdateAmount(ageless, 0).

minimumQuality(basicIncrease, 0).
minimumQuality(basicDecrease, 0).
minimumQuality(modestDecrease, 0).
minimumQuality(static, 80).

maximumQuality(basicIncrease, 50).
maximumQuality(basicDecrease, 50).
maximumQuality(modestDecrease, 50).
maximumQuality(static, 80).
	
updateQuality(Item, NextQuality, NextSellin):-
	item(Item, UpdateType, AgeingType),
	startingQuality(Item, StartingQuality),
	startingSellin(Item, StartingSellin),
	nextQuality(StartingQuality, UpdateType, StartingSellin, NextQuality),
	nextSellin(StartingSellin, AgeingType, NextSellin).

updateQuality(Item, NextQuality, StartingSellin, StartingQuality):-
	item(Item, UpdateType, AgeingType),
	nextQuality(StartingQuality, UpdateType, StartingSellin, NextQuality),
	nextSellin(StartingSellin, AgeingType, NextSellin).


degradingFactor(X, Y):- between(1, inf, X), Y=1.
degradingFactor(X, 2):- \+between(1, inf, X).

nextQuality(Quality, UpdateType, Sellin, NextQuality) :-
	degradingFactor(Sellin, DegradingFactor),
	updateToQuality(UpdateType, Increment),
	maximumQuality(UpdateType, Max),
	minimumQuality(UpdateType, Min),
	IncrementFactor is (Increment * DegradingFactor),
	IncrementedQuality is Quality + IncrementFactor,
	between(Min, Max, IncrementedQuality),
	NextQuality = IncrementedQuality.

nextSellin(CurrentSellin, AgeingType, NewSellin) :-
	sellinUpdateAmount(AgeingType, UpdateAmount),
	IncrementedSellin is CurrentSellin + UpdateAmount,
	NewSellin = IncrementedSellin.
	

testAll :-
	testNextSellin,
	testDegradingFactor,
	testUpdateQuality.
	
testNextSellin :-
	print('-- nextSellin(CurrentSellin, AgeingType, NewSellin) --'), nl,
	nextSellin(0, canAge, -1), print('ok: '), print(nextSellin(0, canAge, -1)), nl,
	nextSellin(0, ageless, 0), print('ok: '), print(nextSellin(0, ageless, 0)), nl.

testDegradingFactor :-
	print('-- degradingFactor(Sellin, DegradingFactor) --'), nl,
	degradingFactor(1, 1), print('ok: '), print(degradingFactor(1, 1)), nl,
	degradingFactor(0, 2), print('ok: '), print(degradingFactor(0, 2)), nl,
	degradingFactor(-1, 2), print('ok: '), print(degradingFactor(-1, 2)), nl.
	
testUpdateQuality :-
	print('-- updateQuality(Item, NextQuality, StartingSellin, StartingQuality) --'), nl,
	updateQuality(dexterityVest, 4, 5, 5), print('ok: '), print(updateQuality(dexterityVest, 4, 5, 5)), nl,
	updateQuality(dexterityVest, 4, 0, 6), print('ok: '), print(updateQuality(dexterityVest, 4, 0, 6)), nl,
	updateQuality(brie, 12, 0, 10), print('ok: '), print(updateQuality(brie, 12, 0, 10)), nl,
	updateQuality(brie, 11, 1, 10), print('ok: '),  print(updateQuality(brie, 11, 1, 10)), nl,
	updateQuality(sulfuras, 80, 0, 80), print('ok: '), print(updateQuality(sulfuras, 80, 0, 80)), nl,
	updateQuality(sulfuras, 80, 5, 80), print('ok: '), print(updateQuality(sulfuras, 80, 5, 80)), nl,
	updateQuality(conjured, 8, 5, 10), print('ok: '), print(updateQuality(conjured, 8, 5, 10)), nl,
	updateQuality(conjured, 6, 0, 10), print('ok: '), print(updateQuality(conjured, 6, 0, 10)), nl,
	print('-- updateQuality(Item, NextQuality, NextSellin) --'), nl,
	updateQuality(dexterityVest, 19, 9), print('ok: '), print(updateQuality(dexterityVest, 19, 9)), nl,
	updateQuality(brie, 1, 1), print('ok: '), print(updateQuality(brie, 1, 1)), nl,
	updateQuality(elixerOfMongoose, 6, 4), print('ok: '), print(updateQuality(elixerOfMongoose, 6, 4)), nl,
	updateQuality(sulfuras, 80, 0), print('ok: '), print(updateQuality(sulfuras, 80, 0)), nl,
	updateQuality(conjured, 4, 5), print('ok: '), print(updateQuality(conjured, 4, 5)), nl.
