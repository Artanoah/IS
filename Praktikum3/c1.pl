tint(red).
tint(green).
tint(ivory).
tint(blue).
tint(yellow).

nationality(english).
nationality(spanish).
nationality(ukrainian).
nationality(norwegian).
nationality(japanese).

pet(dog).
pet(snake).
pet(zebra).
pet(fox).
pet(horse).

drink(tea).
drink(orangeJuice).
drink(milk).
drink(water).
drink(coffee).

cigarettes(oldGold).
cigarettes(kools).
cigarettes(chesterfield).
cigarettes(luckyStrike).
cigarettes(parliament).

solve :- findall(test(Lists), generate(Lists), Results), writeresults(Results).

generate([[T1,N1,P1,D1,C1],
          [T2,N2,P2,D2,C2],
		  [T3,N3,P3,D3,C3],
		  [T4,N4,P4,D4,C4],
		  [T5,N5,P5,D5,C5]]) :-
		  
    maplist(tint, [T1,T2,T3,T4,T5]),
	maplist(nationality, [N1,N2,N3,N4,N5]),
	maplist(pet, [P1,P2,P3,P4,P5]),
	maplist(drink, [D1,D2,D3,D4,D5]),
	maplist(cigarettes, [C1,C2,C3,C4,C5]),
	
	C1 \= C2, C1 \= C3, C1 \= C4, C1 \= C5,
	C2 \= C3, C2 \= C4, C2 \= C5,
	C3 \= C4, C3 \= C5,
	C4 \= C5,
	
	D1 \= D2, D1 \= D3, D1 \= D4, D1 \= D5,
	D2 \= D3, D2 \= D4, D2 \= D5,
	D3 \= D4, D3 \= D5,
	D4 \= D5,
	
	P1 \= P2, P1 \= P3, P1 \= P4, P1 \= P5,
	P2 \= P3, P2 \= P4, P2 \= P5,
	P3 \= P4, P3 \= P5,
	P4 \= P5,
	
	N1 \= N2, N1 \= N3, N1 \= N4, N1 \= N5,
	N2 \= N3, N2 \= N4, N2 \= N5,
	N3 \= N4, N3 \= N5,
	N4 \= N5,
	
	T1 \= T2, T1 \= T3, T1 \= T4, T1 \= T5,
	T2 \= T3, T2 \= T4, T2 \= T5,
	T3 \= T4, T3 \= T5,
	T4 \= T5.
	
test(Lists) :-
    member([red,english,_,_,_], Lists),
	member([_,spanish,dog,_,_], Lists),
	member([green,_,_,coffee,_], Lists),
	member([_,ukrainian,_,tea,_], Lists),
	left([ivory,_,_,_,_],[green,_,_,_,_], Lists),
	member([_,_,snake,_,oldGold], Lists),
	member([yellow,_,_,_,kools], Lists),
	middle([_,_,_,milk,_], Lists),
	first([_,norwegian,_,_,_], Lists),
	nextTo([_,_,_,_,chesterfield],[_,_,fox,_,_], Lists),
	nextTo([_,_,_,_,kools],[_,_,horse,_,_], Lists),
	member([_,_,_,orangeJuice,luckyStrike], Lists),
	member([_,japanese,_,_,parliament], Lists),
	nextTo([_,norwegian,_,_,_],[blue,_,_,_,_],List).
	
left(L1,L2,[L1,L2|_]).
left(L1,L2,[_|R]) :- left(L1,L2,R).

middle(L,[_,_,L,_,_]).

nextTo(L1,L2,Lists) :- left(L1,L2,Lists), left(L2,L1,Lists).

first(L,[L|_]).
	
writeresults([]).
writeresults([A|T]):- writeBlock(A), writeresults(T).

writeBlock([L1,L2,L3,L4,L5]) :-
    write('H1: '), write(L1), nl,
	write('H2: '), write(L2), nl,
	write('H3: '), write(L3), nl,
	write('H4: '), write(L4), nl,
	write('H5: '), write(L5), nl, nl.