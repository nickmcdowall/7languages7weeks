sudoku(Solution) :-

	Solution = [ S11, S12, S13,  S14, S15, S16,  S17, S18, S19,
		     S21, S22, S23,  S24, S25, S26,  S27, S28, S29,
		     S31, S32, S33,  S34, S35, S36,  S37, S38, S39,
		     
		     S41, S42, S43,  S44, S45, S46,  S47, S48, S49,
		     S51, S52, S53,  S54, S55, S56,  S57, S58, S59,
		     S61, S62, S63,  S64, S65, S66,  S67, S68, S69,
		     
		     S71, S72, S73,  S74, S75, S76,  S77, S78, S79,
		     S81, S82, S83,  S84, S85, S86,  S87, S88, S89,
		     S91, S92, S93,  S94, S95, S96,  S97, S98, S99],
		     
	AllowedValues = [1,2,3,4,5,6,7,8,9],

	Row1 = [S11, S12, S13, S14, S15, S16, S17, S18, S19], 
	Row2 = [S21, S22, S23, S24, S25, S26, S27, S28, S29], 
	Row3 = [S31, S32, S33, S34, S35, S36, S37, S38, S39], 
	Row4 = [S41, S42, S43, S44, S45, S46, S47, S48, S49], 
	Row5 = [S51, S52, S53, S54, S55, S56, S57, S58, S59], 
	Row6 = [S61, S62, S63, S64, S65, S66, S67, S68, S69], 
	Row7 = [S71, S72, S73, S74, S75, S76, S77, S78, S79], 
	Row8 = [S81, S82, S83, S84, S85, S86, S87, S88, S89], 
	Row9 = [S91, S92, S93, S94, S95, S96, S97, S98, S99], 

	Col1 = [S11, S21, S31, S41, S51, S61, S71, S81, S91], 
	Col2 = [S12, S22, S32, S42, S52, S62, S72, S82, S92], 
	Col3 = [S13, S23, S33, S43, S53, S63, S73, S83, S93], 
	Col4 = [S14, S24, S34, S44, S54, S64, S74, S84, S94], 
	Col5 = [S15, S25, S35, S45, S55, S65, S75, S85, S95], 
	Col6 = [S16, S26, S36, S46, S56, S66, S76, S86, S96], 
	Col7 = [S17, S27, S37, S47, S57, S67, S77, S87, S97], 
	Col8 = [S18, S28, S38, S48, S58, S68, S78, S88, S98], 
	Col9 = [S19, S29, S39, S49, S59, S69, S79, S89, S99], 

	Box1 = [S11, S12, S13, S21, S22, S23, S31, S32, S33], 
	Box2 = [S14, S15, S16, S24, S25, S26, S34, S35, S36], 
	Box3 = [S17, S18, S19, S27, S28, S29, S37, S38, S39], 
	Box4 = [S41, S42, S43, S51, S52, S53, S61, S62, S63], 
        Box5 = [S44, S45, S46, S54, S55, S56, S64, S65, S66], 
	Box6 = [S47, S48, S49, S57, S58, S59, S67, S68, S69], 
	Box7 = [S71, S72, S73, S81, S82, S83, S91, S92, S93], 
	Box8 = [S74, S75, S76, S84, S85, S86, S94, S95, S96], 
	Box9 = [S77, S78, S79, S87, S88, S89, S97, S98, S99], 
	
	
	permutation(AllowedValues, Row1), write('row1 '), write(Row1), nl,
	permutation(AllowedValues, Row2), write('row2 '), write(Row2), nl,
	is_set(Box1), write('box1 '),  
	is_set(Box2), write('box2 '),
	is_set(Box3), write('box3 '),
	permutation(AllowedValues, Row3), write('row3 '), write(Row3), nl,
	is_set(Box1), write('box1 '), write(Box1), nl,  
	is_set(Box2), write('box2 '), write(Box2), nl,
	is_set(Box3), write('box3 '), write(Box3), nl,

	permutation(AllowedValues, Row4), write('row4 '), write(Row4), nl,
	permutation(AllowedValues, Row5), write('row5 '), write(Row5), nl,
	is_set(Box4), write('box4 '),
        is_set(Box5), write('box5 '),
	is_set(Box6), write('box6 '),
	permutation(AllowedValues, Row6), write('row6 '), write(Row6), nl,
	is_set(Box4), write('box4 '),
        is_set(Box5), write('box5 '),
	is_set(Box6), write('box6 '),

	permutation(AllowedValues, Row7), write('row7 '), write(Row7), nl,
	permutation(AllowedValues, Row8), write('row8 '), write(Row8), nl,
	is_set(Box7), write('box7 '),
	is_set(Box8), write('box8 '),
	is_set(Box9), write('box9 '),
	permutation(AllowedValues, Row9), write('row9 '), write(Row9), nl,
	is_set(Box7), write('box7 '),
	is_set(Box8), write('box8 '),
	is_set(Box9), write('box9 '),

	is_set(Col1), write('col1 '),
	is_set(Col2), write('col2 '),
	is_set(Col3), write('col3 '),
	is_set(Col4), write('col4 '),
	is_set(Col5), write('col5 '),
	is_set(Col6), write('col6 '),
	is_set(Col7), write('col7 '),
	is_set(Col8), write('col8 '),
	is_set(Col9), write('col9 '),

	printRows([Row1, Row2, Row3, Row4, Row5, Row6, Row7, Row8, Row9]).

printRows([]).
printRows([Head|Tail]):-
	write(Head), nl,
	printRows(Tail).
	