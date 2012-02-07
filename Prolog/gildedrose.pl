
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

minimumQuality(0).
maximumQuality(50).

qualityUpdateIncrement(brie, +1).
qualityUpdateIncrement(concertTickets, +1).
qualityUpdateIncrement(dexterityVest, -1).
qualityUpdateIncrement(elixerOfMongoose, -1).
qualityUpdateIncrement(conjured, -2).

degradingFactor(concertTickets, Sellin, 3):- between(1, 5, Sellin).
degradingFactor(concertTickets, Sellin, 2):- between(6, 10, Sellin).
degradingFactor(concertTickets, Sellin, 1):- between(11, inf, Sellin).
degradingFactor(Item, Sellin, 1):- between(1, inf, Sellin), (Item \= concertTickets).
degradingFactor(Item, Sellin, 2):- \+between(1, inf, Sellin), (Item \= concertTickets).


updateQuality(Item, NextQuality):-
	item(Item),
	startingQuality(Item, StartingQuality),
	startingSellin(Item, StartingSellin),
	updateQuality(Item, NextQuality, StartingSellin, StartingQuality).
updateQuality(sulfuras, 80, 0, 80).
updateQuality(Item, NextQuality, StartingSellin, StartingQuality):-
	item(Item),
	(Item \= sulfuras),
	betweenMinMax(StartingQuality),
	nextQuality(StartingQuality, Item, StartingSellin, NextQuality).


nextQuality(_CurrentQuality, Item, Sellin, 0) :- 
	(Sellin < 1), 
	(Item = concertTickets).
nextQuality(CurrentQuality, Item, Sellin, NextQuality) :-
	betweenMinMax(NextQuality),
	degradingFactor(Item, Sellin, DegradingFactor),
	qualityUpdateIncrement(Item, Increment),
	IncrementFactor is (Increment * DegradingFactor),
	CurrentQuality is (NextQuality - IncrementFactor).
nextQuality(CurrentQuality, Item, Sellin, Min) :-
	betweenMinMax(CurrentQuality),
	degradingFactor(Item, Sellin, DegradingFactor),
	qualityUpdateIncrement(Item, Increment),
	minimumQuality(Min),
	IncrementFactor is (Increment * DegradingFactor),
	Min > (IncrementFactor + CurrentQuality).
nextQuality(CurrentQuality, Item, Sellin, Max) :-
	betweenMinMax(CurrentQuality),
	degradingFactor(Item, Sellin, DegradingFactor),
	qualityUpdateIncrement(Item, Increment),
	IncrementFactor is (Increment * DegradingFactor),
	maximumQuality(Max),
	Max < (IncrementFactor + CurrentQuality).

betweenMinMax(Value):-
	minimumQuality(Min),
	maximumQuality(Max),
	between(Min, Max, Value).

	
%%%%%%%%%%% Tests %%%%%%%%%%%

assertTrue([]).
assertTrue([Head|Tail]) :-
	Test =.. Head, print('AssertTrue: '), print(Test), call(Test), print(' - Pass'), nl,
	assertTrue(Tail).
	
assertFalse([]).
assertFalse([Head|Tail]) :-
	Test =.. Head, print('AssertFalse: '), print(Test), \+call(Test), print(' - Pass'), nl,
	assertFalse(Tail).
	
testAll :-
	
	%				Item,			NextQuality
	%				-----------------	-----------
	assertTrue([ 	[updateQuality, dexterityVest, 		19], 
			[updateQuality, brie, 			 1], 
			[updateQuality, elixerOfMongoose,	 6], 
			[updateQuality, sulfuras, 		80], 
			[updateQuality, conjured, 		 4], 
			[updateQuality, concertTickets, 	21] ]),
	
	%				Item, 			NextQuality, 	Sellin,	StartingQuality
	%				--------------		------------	-------	---------------
	assertTrue([ 	[updateQuality, dexterityVest, 		 4, 		 5,	 5],
			[updateQuality, dexterityVest, 		 4, 		 0,	 6],
			[updateQuality, dexterityVest, 		 9, 		10, 	10],
			[updateQuality, dexterityVest, 		 8, 		-1, 	10],
			[updateQuality, dexterityVest, 		 0, 		10, 	 0],
			[updateQuality, dexterityVest, 		 0, 		-1, 	 1],
			[updateQuality, dexterityVest, 		48, 		 0, 	50],	
			[updateQuality, brie, 			12, 		 0, 	10], 
			[updateQuality, brie, 			11, 		 1, 	10], 	
			[updateQuality, brie, 			50, 		 1, 	50], 	
			[updateQuality, sulfuras, 		80, 		 0, 	80], 	
			[updateQuality, concertTickets, 	 0, 		 0, 	10], 	
			[updateQuality, concertTickets, 	11, 		11, 	10],	
			[updateQuality, concertTickets, 	12, 		 7, 	10],	
			[updateQuality, concertTickets, 	13, 		 5, 	10], 	
			[updateQuality, concertTickets, 	 0, 		 0, 	50], 	
			[updateQuality, concertTickets, 	 0, 		-1, 	50], 	
			[updateQuality, elixerOfMongoose, 	48, 		 0, 	50],
			[updateQuality, conjured, 		 8, 		 5, 	10], 	
			[updateQuality, conjured, 		 6, 		 0, 	10], 	
			[updateQuality, conjured, 		 0, 		10, 	 1], 	
			[updateQuality, conjured, 		46, 		 0, 	50] ]),

	%				Item,			NextQuality
	%				-----------------	-----------
	assertFalse([	[updateQuality, sulfuras, 		81] ]),

	%				Item, 			NextQuality, 	Sellin,	StartingQuality
	%				--------------		------------	-------	---------------
	assertFalse([	[updateQuality, sulfuras, 		80, 		 1, 	80],
			[updateQuality, sulfuras, 		10, 		 0, 	10],
			[updateQuality, elixerOfMongoose,       50, 		 1, 	51],
			[updateQuality, elixerOfMongoose,        0, 		 1, 	-1],
			[updateQuality, concertTickets, 	51, 		 5, 	50] ]).			
	
