:- use_module(testing).

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


%%%%%%%%%%% Tests %%%%%%%%%%%

testAll :-
 
 %                  Item               Sellin   Quality   NextQuality
 %                  ----------------   ------   -------   -----------
 assertTrue([
    [updateQuality, dexterityVest,       5,       5,        4],
    [updateQuality, dexterityVest,       0,       6,        4],
    [updateQuality, dexterityVest,      10,      10,        9],
    [updateQuality, dexterityVest,      -1,      10,        8],
    [updateQuality, dexterityVest,      10,       0,        0],
    [updateQuality, dexterityVest,      -1,       1,        0],
    [updateQuality, dexterityVest,       0,      50,       48], 
    [updateQuality, brie,                0,      10,       12], 
    [updateQuality, brie,                1,      10,       11],  
    [updateQuality, brie,                1,      50,       50],  
    [updateQuality, sulfuras,            0,      80,       80],  
    [updateQuality, concertTickets,      0,      10,        0],  
    [updateQuality, concertTickets,     11,      10,       11], 
    [updateQuality, concertTickets,      7,      10,       12], 
    [updateQuality, concertTickets,      5,      10,       13],  
    [updateQuality, concertTickets,      0,      50,        0],  
    [updateQuality, concertTickets,     -1,      50,        0],  
    [updateQuality, elixerOfMongoose,    0,      50,       48],
    [updateQuality, conjured,            5,      10,        8],  
    [updateQuality, conjured,            0,      10,        6],  
    [updateQuality, conjured,           10,       1,        0],  
    [updateQuality, conjured,            0,      50,       46], 
    [updateQuality, _I1,               _S1,     _Q1,      _N1],
    [updateQuality, _I2,                15,     _Q2,      _N2],
    [updateQuality, _I3,               _S2,      25,      _N3],
    [updateQuality, _I4,               _S3,     _Q3,        7],
    [updateQuality, dexterityVest,     _S4,     _Q4,      _N4]
 ]),


 %                 Item               Sellin  Quality  NextQuality
 %                 -----------------  ------  -------  -----------
 assertFalse([ 
   [updateQuality, sulfuras,           1,     80,      80],
   [updateQuality, sulfuras,           0,     10,      10],
   [updateQuality, elixerOfMongoose,   1,     51,      50],
   [updateQuality, brie,               5,     -1,       0],
   [updateQuality, concertTickets,    15,     50,      51] 
 ]).   
 
