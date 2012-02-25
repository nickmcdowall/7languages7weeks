:- module(team, [team/1]).

/*
  Picks a 5 a side football team based on positions players can fill and player availability.
*/
team(Team) :-
	Team = [Goalie, Defender, MidfieldA, MidfieldB, Striker],
	goalie(Goalie),
	defender(Defender),
	midfielder(MidfieldA),
	midfielder(MidfieldB),
	striker(Striker),
	allAvailable(Team),
	is_set(Team).

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

