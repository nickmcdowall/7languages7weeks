
midfielder(nick).
midfielder(budd).
midfielder(paul).
midfielder(sam).
midfielder(olly).
midfielder(andre).

defender(nick).
defender(sam).
defender(budd).
defender(olly).
defender(paul).
defender(andre).
defender(mark).

striker(bigNick).
striker(nick).

goalie(olly).
goalie(sam).
goalie(chucks).

unavailable(sam, injured).
unavailable(andre, injured).
unavailable(paul, suspended).
unavailable(bigNick, holiday).

team(Goalie, Defender, MidfieldA, MidfieldB, Striker) :-
	goalie(Goalie),
	defender(Defender),
	midfielder(MidfieldA),
	midfielder(MidfieldB),
	striker(Striker),
	\+unavailable(Goalie, _),
	\+unavailable(Defender, _),
	\+unavailable(MidfieldA, _),
	\+unavailable(MidfieldB, _),
	\+unavailable(Striker, _),
	\+(Goalie = Defender),
	\+(Goalie = MidfieldA),
	\+(Goalie = MidfieldB),
	\+(Goalie = Striker),
	\+(Defender = MidfieldA),
	\+(Defender = MidfieldB),
	\+(Defender = Striker),
	\+(MidfieldA = MidfieldB),
	\+(MidfieldA = Striker),
	\+(MidfieldB = Striker).
