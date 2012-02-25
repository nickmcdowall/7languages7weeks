:- module(gildedrose, [updateQuality/4]).

item(dexterityVest).
item(brie).
item(elixerOfMongoose).
item(sulfuras).
item(concertTickets).
item(conjured).

minimumQuality(0).
maximumQuality(50).
maximumSellin(50). % To allow other solutions to be explored - rather than go to infinity.

qualityUpdateIncrement(brie, +1).
qualityUpdateIncrement(concertTickets, +1).
qualityUpdateIncrement(dexterityVest, -1).
qualityUpdateIncrement(elixerOfMongoose, -1).
qualityUpdateIncrement(conjured, -2).

degradingFactor(concertTickets, Sellin, 3):- between(1, 5, Sellin).
degradingFactor(concertTickets, Sellin, 2):- between(6, 10, Sellin).
degradingFactor(concertTickets, Sellin, 1):- maximumSellin(MaxSellin), between(11, MaxSellin, Sellin).
degradingFactor(Item, Sellin, 1):- (Item \= concertTickets), maximumSellin(MaxSellin), between(1, MaxSellin, Sellin).
degradingFactor(Item, Sellin, 2):- (Item \= concertTickets), maximumSellin(MaxSellin), \+between(1, MaxSellin, Sellin).

betweenMinMax(Value):-
	minimumQuality(Min),
	maximumQuality(Max),
	between(Min, Max, Value).
	
incrementFactor(Item, Sellin, IncrementFactor):-
	qualityUpdateIncrement(Item, Increment),
	degradingFactor(Item, Sellin, DegradingFactor),
	IncrementFactor is (Increment * DegradingFactor).

updateQuality(sulfuras, 0, 80, 80).
updateQuality(Item, Sellin, Quality, NextQuality):-
	item(Item),
	(Item \= sulfuras),
	betweenMinMax(Quality),
	nextQuality(Item, Sellin, Quality, NextQuality).


nextQuality(concertTickets, Sellin, _Quality, 0) :- (Sellin < 1).
nextQuality(Item, Sellin, Quality, NextQuality) :-
	betweenMinMax(NextQuality),
	incrementFactor(Item, Sellin, IncrementFactor),
	Quality is (NextQuality - IncrementFactor).
nextQuality(Item, Sellin, Quality, MinQuality) :-
	betweenMinMax(Quality),
	incrementFactor(Item, Sellin, IncrementFactor),
	minimumQuality(MinQuality),
	MinQuality > (IncrementFactor + Quality).
nextQuality(Item, Sellin, Quality, MaxQuality) :-
	betweenMinMax(Quality),
	incrementFactor(Item, Sellin, IncrementFactor),
	maximumQuality(MaxQuality),
	MaxQuality < (IncrementFactor + Quality).

