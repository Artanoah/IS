:- use_module(library(clpfd)).

solve :- time(findall(_,solve_me,_)).

solve_me :-
    T = [Red, Green, Ivory, Blue, Yellow],
	N = [English, Spanish, Ukrainian, Norwegian, Japanese],
	P = [Dog, Snake, Zebra, Fox, Horse],
	D = [Tea, OrangeJuice, Milk, Water, Coffee],
	C = [OldGold, Kools, Chesterfield, LuckyStrike, Parliament],
	
	T ins 1..5,
	N ins 1..5,
	P ins 1..5,
	D ins 1..5,
	C ins 1..5,
	
	Milk = 3,
	Norwegian = 1,
	abs(Norwegian - Blue) #=1,
	Coffee = Green,
	Green #= Ivory + 1,
	Kools = Yellow,
	abs(Kools - Horse) #= 1,
	OldGold = Snake,
	abs(Chesterfield - Fox) #= 1,
	LuckyStrike = OrangeJuice,
	Japanese = Parliament,
	English = Red,
	Spanish = Dog,
	Ukrainian = Tea,
	
	maplist(all_different, [T,N,P,D,C]),
	maplist(label, [T,N,P,D,C]),
	
	sort_elements(T,[red, green, ivory, blue, yellow],Tints),
	sort_elements(N,[english, spanish, ukrainian, norwegian, japanese],Nationalities),
	sort_elements(P,[dog, snake, zebra, fox, horse],Pets),
	sort_elements(D,[tea, orangeJuice, milk, water, coffee], Drinks),
	sort_elements(C,[oldGold, kools, chesterfield, luckyStrinke, parliament],Cigaretts),
	
	transpose([Tints, Nationalities, Pets, Drinks, Cigaretts], Result),
	writeresults(Result).
	
sort_elements(Keys, Values, Result) :-
    pairs_keys_values(Tupel, Keys, Values),
	keysort(Tupel, SortedTupel),
	pairs_keys_values(SortedTupel, _, Result).
	
writeresults([]) :- nl.
writeresults([A|T]):- write('H1: '), write(A),nl, writeresults(T).