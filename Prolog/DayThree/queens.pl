/*
  A board has 8 queens.
  Each queen has a row from 1-8 and a column from 1-8.
  No two queens can share the same row.
  No two queens can share the same column.
  No two queens can share the same diagonal (southwest to northeast).
  No two queens can share the same diagonal (northwest to southeast).
*/
eight_queens(Board) :-
	Board = ([(Q1R,Q1C),(Q2R,Q2C),(Q3R,Q3C),(Q4R,Q4C),(Q5R,Q5C),(Q6R,Q6C),(Q7R,Q7C),(Q8R,Q8C)]),
	Rows = [Q1R,Q2R,Q3R,Q4R,Q5R,Q6R,Q7R,Q8R],
	Cols = [Q1C,Q2C,Q3C,Q4C,Q5C,Q6C,Q7C,Q8C],

	AllowedValues = [1,2,3,4,5,6,7,8],
	permutation(AllowedValues, Rows),
	permutation(AllowedValues, Cols),

	diagonalSouth(Board, DiagonalDown),
	is_set(DiagonalDown),

	diagonalNorth(Board, DiagonalUp),
	is_set(DiagonalUp).

diagonalSouth([], []).
diagonalSouth([(Row, Col)|Tail], [Diagonal|DiagonalsTail]) :-
	Diagonal is Col - Row,
	diagonalSouth(Tail, DiagonalsTail).
	
diagonalNorth([], []).
diagonalNorth([(Row, Col)|Tail], [Diagonal|DiagonalsTail]) :-
	Diagonal is Col + Row,
	diagonalNorth(Tail, DiagonalsTail).
	