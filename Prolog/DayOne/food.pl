
food(velveeta, cheese).
food(ritz, cracker).
food(spam, meat).
food(sausage, meat).
food(jolt, soda).
food(twinkie, dessert).

flavor(savory, meat).
flavor(savory, cheese).
flavor(sweet, dessert).
flavor(sweet, soda).

food_flavor(X,Y) :- food(X,Z), flavor(Y,Z).