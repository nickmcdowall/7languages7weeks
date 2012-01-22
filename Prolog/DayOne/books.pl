book_in_stock(goodnessMe, action).
book_in_stock(timeMachine, drama).
book_in_stock(yoyo, romance).

author(nick, goodnessMe).
author(john, timeMachine).
author(steve, spacedOut).
author(bob, yoyo).

author_has_a_book_in_stock(Name) :-
	author(Name, Title), book_in_stock(Title, _).

author_has_book_in_stock(Name, Title) :-
	author(Name, Title), book_in_stock(Title, _).
	
author_has_genre_in_stock(Name, Genre) :-
	author(Name, Title), book_in_stock(Title, Genre).