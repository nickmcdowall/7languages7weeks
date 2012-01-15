book_in_stock(goodnessMe, action).
book_in_stock(timeMachine, drama).
book_in_stock(yoyo, romance).

author(nick, goodnessMe).
author(john, timeMachine).
author(steve, spacedOut).
author(bob, yoyo).

author_has_a_book_in_stock(X) :-
	author(X, Z), book_in_stock(Z, _).

author_has_book_in_stock(X, Y) :-
	author(X, Y), book_in_stock(Y, _).
	
author_has_genre_in_stock(X, Y) :-
	author(X, Z), book_in_stock(Z, Y).