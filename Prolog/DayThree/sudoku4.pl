:- use_module(library(lists)).
:- use_module('../library/utilities').

sudoku(Solution) :-

	Solution = [ S11, S12, S13, S14,
		     S21, S22, S23, S24,
		     S31, S32, S33, S34,
		     S41, S42, S43, S44],

	Row1 = [S11,S12,S13,S14], allBetween(Row1, 1, 4), is_set(Row1),
	Row2 = [S21,S22,S23,S24], allBetween(Row2, 1, 4), is_set(Row2),
	Row3 = [S31,S32,S33,S34], allBetween(Row3, 1, 4), is_set(Row3),
	Row4 = [S41,S42,S43,S44], allBetween(Row4, 1, 4), is_set(Row4),

	Col1 = [S11,S21,S31,S41], is_set(Col1),
	Col2 = [S12,S22,S32,S42], is_set(Col2),
	Col3 = [S13,S23,S33,S43], is_set(Col3),
	Col4 = [S14,S24,S34,S44], is_set(Col4),
	
	Box1 = [S11,S12,S21,S22], is_set(Box1),
	Box2 = [S13,S14,S23,S24], is_set(Box2),
	Box3 = [S31,S32,S41,S42], is_set(Box3),
	Box4 = [S33,S34,S43,S44], is_set(Box4).	

