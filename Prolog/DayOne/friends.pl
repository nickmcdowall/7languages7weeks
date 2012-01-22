likes(wallace, cheese).
likes(grommit, cheese).
likes(wendolene, sheep).

% moved the \+(X=Y) to the end so that I can call something like friend(Who, grommit)
% which doesn't work when not the last subgoal..
friend(X,Y) :- likes(X,Z), likes(Y,Z), \+(X=Y).

