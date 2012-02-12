:- use_module('../team').
:- use_module('../library/testing').


testAll :-
 %                 Goalie   Defender   Mid1   Mid2   Striker
 %                 ------   --------   ----   ----   -------
    assertTrue([
        [team,     [chucks,  mark,     budd,  olly,  nick]     ],
        [team,     [chucks,  mark,     olly,  budd,  nick]     ]
    ]),

    assertFalse([ 
        [team,     [chucks,  mark,     budd,  budd,  nick   ]  ],
        [team,     [chucks,  mark,     olly,  olly,  nick   ]  ],
        [team,     [chucks,  mark,     olly,  budd,  bigNick]  ],
        [team,     [sam,     mark,     budd,  olly,  nick   ]  ],
        [team,     [chucks,  mark,     paul,  olly,  nick   ]  ]
    ]).