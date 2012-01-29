
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

updateToQuality(basicIncrease, +1).
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
	
	
%updateQuality(Item, NewQuality, NewSellin):-
%	item(Item, UpdateType, AgeingType),
%	maximumQuality(UpdateType, Max),
%	minimumQuality(UpdateType, Min),
%	startingQuality(Item, Quality),
%	startingSellin(Item, Sellin),
%	updateToQuality(UpdateType, QUpdate),
%	MinMinusOne is max(-1, Sellin),
%	MaxZero is min(MinMinusOne, 0),
%	degradingFactor(MaxZero, DegradingFactor),
%	IncrementedQuality is Quality + QUpdate * DegradingFactor,
%	QualityNoGreaterThanMax is min(IncrementedQuality, Max),
%	QualityBetweenMaxMin is max(QualityNoGreaterThanMax, Min),
%	NewQuality = QualityBetweenMaxMin,
%	sellinUpdateAmount(AgeingType, AgeUpdate),
%	IncrementedSellin is Sellin + AgeUpdate,
%	NewSellin = IncrementedSellin.

updateQuality(Item, NextQuality, NextSellin):-
	item(Item, UpdateType, AgeingType),
	startingQuality(Item, StartingQuality),
	startingSellin(Item, StartingSellin),
	nextQuality(StartingQuality, UpdateType, StartingSellin, NextQuality),
	nextSellin(StartingSellin, AgeingType, NextSellin).

updateQuality(Item, NextQuality, StartingSellin, StartingQuality):-
	sellin(StartingSellin),
	item(Item, UpdateType, AgeingType),
	nextQuality(StartingQuality, UpdateType, StartingSellin, NextQuality),
	nextSellin(StartingSellin, AgeingType, NextSellin).


degradingFactor(-1, 2).
degradingFactor(0, 1).
degradingFactor(Sellin, DegradingFactor) :-
	MinMinusOne is max(-1, Sellin),
	MaxZero is min(MinMinusOne, 0),
	degradingFactor(MaxZero, DegradingFactor).

nextQuality(Quality, UpdateType, Sellin, NextQuality) :-
	degradingFactor(Sellin, DegradingFactor),
	updateToQuality(UpdateType, Increment),
	maximumQuality(UpdateType, Max),
	minimumQuality(UpdateType, Min),
	IncrementedQuality is Quality + Increment * DegradingFactor,
	QualityNoGreaterThanMax is min(IncrementedQuality, Max),
	QualityBetweenMaxMin is max(QualityNoGreaterThanMax, Min),
	NextQuality = QualityBetweenMaxMin.

nextSellin(CurrentSellin, AgeingType, NewSellin) :-
	sellinUpdateAmount(AgeingType, UpdateAmount),
	IncrementedSellin is CurrentSellin + UpdateAmount,
	NewSellin = IncrementedSellin.
	

testDegradingFactor(X):-
	degradingFactor(basicIncrease, 1, 1),
	degradingFactor(basicIncrease, 0, 1),
	degradingFactor(basicIncrease, -1, 2),
	degradingFactor(basicDecrease, 1, 1),
	degradingFactor(basicDecrease, 0, 1),
	degradingFactor(basicDecrease, -1, 2).
	
testUpdateQuality(X):-
	updateQuality(dexterityVest, 19, 9), 
	updateQuality(brie, 1, 1), 
	updateQuality(elixerOfMongoose, 6, 4), 
	updateQuality(sulfuras, 80, 0), 
	updateQuality(conjured, 4, 5).