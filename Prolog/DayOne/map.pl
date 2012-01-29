different(red, green).
different(red, blue).
different(red, yellow).
different(green, red).
different(green, blue).
different(green, yellow).
different(blue, red).
different(blue, green).
different(blue, yellow).

colouring(Alabama, Mississippi, Georgia, Tennessee, Florida) :-
	different(Mississippi, Tennessee),
	different(Mississippi, Alabama),
	different(Alabama, Tennessee),
	different(Alabama, Mississippi),
	different(Alabama, Georgia),
	different(Alabama, Florida),
	different(Georgia, Florida),
	different(Tennessee, Florida),
	different(Georgia, Tennessee).