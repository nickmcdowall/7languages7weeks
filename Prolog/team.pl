:- use_module(testing).
:- use_module(utilities).

goalie(olly).
goalie(sam).
goalie(chucks).

defender(nick).
defender(sam).
defender(budd).
defender(olly).
defender(paul).
defender(andre).
defender(mark).

midfielder(nick).
midfielder(budd).
midfielder(paul).
midfielder(sam).
midfielder(olly).
midfielder(andre).

striker(bigNick).
striker(nick).

unavailable(sam, injured).
unavailable(andre, injured).
unavailable(paul, suspended).
unavailable(bigNick, holiday).

allAvailable([]).
allAvailable([First|Others]) :-
	\+unavailable(First, _),
	allAvailable(Others).

team(Goalie, Defender, MidfieldA, MidfieldB, Striker) :-
	goalie(Goalie),
	defender(Defender),
	midfielder(MidfieldA),
	midfielder(MidfieldB),
	striker(Striker),
	allAvailable([Goalie, Defender, MidfieldA, MidfieldB, Striker]),
	noDuplicates([Goalie, Defender, MidfieldA, MidfieldB, Striker]).
	


testAll :-
 %                 Goalie   Defender   Mid1   Mid2   Striker
 %                 ------   --------   ----   ----   -------
    assertTrue([
        [team,     chucks,  mark,      budd,  olly,  nick   ],
        [team,     chucks,  mark,      olly,  budd,  nick   ]
    ]),

    assertFalse([ 
        [team,     chucks,  mark,      budd,  budd,  nick   ],
        [team,     chucks,  mark,      olly,  olly,  nick   ],
        [team,     chucks,  mark,      olly,  budd,  bigNick],
        [team,     sam,     mark,      budd,  olly,  nick   ],
        [team,     chucks,  mark,      paul,  olly,  nick   ]
    ]).



