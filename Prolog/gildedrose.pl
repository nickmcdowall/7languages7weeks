
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

betweenMinMax(Value):-
	minimumQuality(Min),
	maximumQuality(Max),
	between(Min, Max, Value).
	
incrementFactor(Item, Sellin, IncrementFactor):-
	degradingFactor(Item, Sellin, DegradingFactor),
	qualityUpdateIncrement(Item, Increment),
	IncrementFactor is (Increment * DegradingFactor).

updateQuality(Item, NextQuality):-
	item(Item),
	startingQuality(Item, Quality),
	startingSellin(Item, Sellin),
	updateQuality(Item, Sellin, Quality, NextQuality).
	
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
 
 %                 Item               NextQuality
 %                 -----------------  -----------
 assertTrue([  
   [updateQuality, dexterityVest,     19], 
   [updateQuality, brie,               1], 
   [updateQuality, elixerOfMongoose,   6], 
   [updateQuality, sulfuras,          80], 
   [updateQuality, conjured,           4], 
   [updateQuality, concertTickets,    21] ]),
 
 %                 Item              Sellin  Quality  NextQuality
 %                 ----------------  ------  -------  -----------
 assertTrue([  
   [updateQuality, dexterityVest,     5,      5,       4],
   [updateQuality, dexterityVest,     0,      6,       4],
   [updateQuality, dexterityVest,    10,     10,       9],
   [updateQuality, dexterityVest,    -1,     10,       8],
   [updateQuality, dexterityVest,    10,      0,       0],
   [updateQuality, dexterityVest,    -1,      1,       0],
   [updateQuality, dexterityVest,     0,     50,      48], 
   [updateQuality, brie,              0,     10,      12], 
   [updateQuality, brie,              1,     10,      11],  
   [updateQuality, brie,              1,     50,      50],  
   [updateQuality, sulfuras,          0,     80,      80],  
   [updateQuality, concertTickets,    0,     10,       0],  
   [updateQuality, concertTickets,   11,     10,      11], 
   [updateQuality, concertTickets,    7,     10,      12], 
   [updateQuality, concertTickets,    5,     10,      13],  
   [updateQuality, concertTickets,    0,     50,       0],  
   [updateQuality, concertTickets,   -1,     50,       0],  
   [updateQuality, elixerOfMongoose,  0,     50,      48],
   [updateQuality, conjured,          5,     10,       8],  
   [updateQuality, conjured,          0,     10,       6],  
   [updateQuality, conjured,         10,      1,       0],  
   [updateQuality, conjured,          0,     50,      46] ]),

 %                 Item               NextQuality
 %                 -----------------  -----------
 assertFalse([ 
   [updateQuality, sulfuras,          81],
   [updateQuality, sulfuras,          79] ]),

 %                 Item               Sellin  Quality  NextQuality
 %                 -----------------  ------  -------  -----------
 assertFalse([ 
   [updateQuality, sulfuras,           1,     80,      80],
   [updateQuality, sulfuras,           0,     10,      10],
   [updateQuality, elixerOfMongoose,   1,     51,      50],
   [updateQuality, elixerOfMongoose,   1,     -1,       0],
   [updateQuality, concertTickets,    15,     50,      51] ]).   
 
