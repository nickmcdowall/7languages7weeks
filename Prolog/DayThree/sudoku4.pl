sudoku(Solution) :-

	Solution = [ S11, S12,  S13, S14,
		     S21, S22,  S23, S24,
		     
		     S31, S32,  S33, S34,
		     S41, S42,  S43, S44],
		     
	AllowedValues = [1,2,3,4],

	Row1 = [S11,S12,S13,S14], Col1 = [S11,S21,S31,S41], Box1 = [S11,S12,S21,S22], 
	Row2 = [S21,S22,S23,S24], Col2 = [S12,S22,S32,S42], Box2 = [S13,S14,S23,S24], 
	Row3 = [S31,S32,S33,S34], Col3 = [S13,S23,S33,S43], Box3 = [S31,S32,S41,S42], 
	Row4 = [S41,S42,S43,S44], Col4 = [S14,S24,S34,S44], Box4 = [S33,S34,S43,S44], 

	permutation(AllowedValues, Row1), 
	permutation(AllowedValues, Row2),
	is_set(Box1),
	is_set(Box2),

	permutation(AllowedValues, Row3),
	permutation(AllowedValues, Row4),
	is_set(Box3),
	is_set(Box4),
	is_set(Col1),
	is_set(Col2),
	is_set(Col3),
	is_set(Col4),
	
	printRows([Row1,Row2,Row3,Row4]).

printRows([]).
printRows([Head|Tail]):-
	write(Head), nl,
	printRows(Tail).
	