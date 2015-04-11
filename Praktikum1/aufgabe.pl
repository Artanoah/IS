% Vorhandene Personen [Simpsons]
% mann(abraham).
% mann(herbert).
% mann(homer).
% mann(bart).
% mann(clancy).
% 
% frau(jacqueline).
% frau(mona).
% frau(marge).
% frau(patty).
% frau(selma).
% frau(lisa).
% frau(maggie).
% frau(ling).
%
% Vater- und Mutterschaften [Simpsons]
% vater(homer, abraham).
% vater(herbert, abraham).
% vater(marge, clancy).
% vater(patty, clancy).
% vater(selma, clancy).
% vater(bart, homer).
% vater(lisa, homer).
% vater(maggie, homer).
% 
% mutter(homer, mona).
% mutter(herbert, mona).
% mutter(marge, jacqueline).
% mutter(patty, jacqueline).
% mutter(selma, jacqueline).
% mutter(bart, marge).
% mutter(lisa, marge).
% mutter(maggie, marge).

% Vorhandene Personen [Royal Family]
mann(georgeWindsowVI).
mann(phillipDuke).
mann(antonyArmstrongJones).
mann(charlesWales).
mann(andrewDuke).
mann(edwardWessex).
mann(davidLinley).
mann(williamWales).
mann(henryWales).

frau(elizabethBowsLyon).
frau(elizabethII).
frau(margaretRose).
frau(dianaSpencer).
frau(anneRoyal).
frau(sarahFergurson).
frau(sarah).
frau(beatriceYork).
frau(eugineYork).

% Vater- und Mutterschaften [Royal Family]
vater(williamWales, charlesWales).
vater(henryWales, charlesWales).
vater(beatriceYork, andrewDuke).
vater(eugineYork, andrewDuke).
vater(charlesWales, phillipDuke).
vater(anneRoyal, phillipDuke).
vater(andrewDuke, phillipDuke).
vater(edwardWessex, phillipDuke).
vater(davidLinley, antonyArmstrongJones).
vater(sarah, antonyArmstrongJones).
vater(elizabethII, georgeWindsowVI).
vater(margaretRose, georgeWindsowVI).

mutter(williamWales, dianaSpencer).
mutter(henryWales, dianaSpencer).
mutter(beatriceYork, sarahFergurson).
mutter(eugineYork, sarahFergurson).
mutter(charlesWales, elizabethII).
mutter(anneRoyal, elizabethII).
mutter(andrewDuke, elizabethII).
mutter(edwardWessex, elizabethII).
mutter(davidLinley, margaretRose).
mutter(sarah, margaretRose).
mutter(elizabethII, elizabethBowsLyon).
mutter(margaretRose, elizabethBowsLyon).

person(Person) :- mann(Person).
person(Person) :- frau(Person).

elternteil(Kind, Eltern) :- vater(Kind, Eltern).
elternteil(Kind, Eltern) :- mutter(Kind, Eltern).

% Grosseltern
opa(Neffe, Opa) :- person(Neffe), mann(Opa), person(Elternteil),
                   elternteil(Neffe, Elternteil), vater(Elternteil, Opa).

oma(Neffe, Oma) :- person(Neffe), frau(Oma), person(Elternteil),
                   elternteil(Neffe, Elternteil), mutter(Elternteil, Oma).

% Vorfahren
vorfahre(Jung, Alt) :- person(Alt), person(Jung),
                       elternteil(Jung, Alt).
vorfahre(Jung, Alt) :- person(Alt), person(Jung), person(Mitte),
                       elternteil(Jung, Mitte), vorfahre(Mitte, Alt).

% Geschwister
geschwister(Kind1, Kind2) :- person(Kind1), person(Kind2), Kind1 \== Kind2,
                             frau(Mutter), mann(Vater),
                             vater(Kind1, Vater), vater(Kind2, Vater),
                             mutter(Kind1, Mutter), mutter(Kind2, Mutter).

bruder(Kind, Bruder) :- person(Kind), mann(Bruder),
                        geschwister(Kind, Bruder).

schwester(Kind, Schwester) :- person(Kind), frau(Schwester),
                              geschwister(Kind, Schwester).

% Onkel und Tante
onkel(Neffe, Onkel) :- person(Neffe), mann(Onkel), person(Elternteil),
                       elternteil(Neffe, Elternteil), geschwister(Elternteil, Onkel).

tante(Neffe, Tante) :- person(Neffe), frau(Tante), person(Elternteil),
                       elternteil(Neffe, Elternteil), geschwister(Elternteil, Tante).

% Grossonkel und Grosstante
grossonkel(Neffe, Grossonkel) :- person(Neffe), mann(Grossonkel), person(Elternteil),
                                 elternteil(Neffe, Elternteil), onkel(Elternteil, Grossonkel).

grosstante(Neffe, Grosstante) :- person(Neffe), frau(Grosstante), person(Elternteil),
                                 elternteil(Neffe, Elternteil), tante(Elternteil, Grosstante).

:- begin_tests(stammbaum).
%:- consult(aufgabe).
%Positive Tests

test(person) :- person(williamWales),
				person(sarahFergurson).

test(elternteil) :- elternteil(anneRoyal, phillipDuke),
					elternteil(davidLinley, margaretRose).

test(opa) :- opa(williamWales, phillipDuke),
			 opa(sarah, georgeWindsowVI).

test(oma) :- oma(beatriceYork, elizabethII),
			 oma(andrewDuke, elizabethBowsLyon).

test(vorfahre) :- vorfahre(henryWales, georgeWindsowVI),
				  vorfahre(henryWales, elizabethBowsLyon),
				  vorfahre(henryWales, phillipDuke),
				  vorfahre(henryWales, elizabethII),
				  vorfahre(henryWales, dianaSpencer),
				  vorfahre(henryWales, charlesWales).

test(schwester) :- schwester(eugineYork, beatriceYork),
				   schwester(andrewDuke, anneRoyal).

test(bruder) :- bruder(sarah, davidLinley),
				bruder(charlesWales, andrewDuke).

test(onkel) :- onkel(eugineYork, edwardWessex),
			   onkel(henryWales, andrewDuke).

test(tante) :- tante(andrewDuke, margaretRose),
			   tante(sarah, elizabethII).

test(grosstante) :- grosstante(beatriceYork, margaretRose),
					grosstante(henryWales, margaretRose).
					
%Negative Tests					
test(person,[fail]) :- person(peter),person(fritz).

test(elternteil,[fail]):- 	elternteil(anneRoyal, antonyArmstrongJones),
							elternteil(davidLinley, elizabethII).
							
test(opa,[fail]) :- opa(williamWales, charlesWales),
					opa(sarah, antonyArmstrongJones).
					
test(oma,[fail]) :- oma(beatriceYork, sarahFergurson),
					oma(andrewDuke, elizabethII).
					
test(vorfahre,[fail]):- vorfahre(henryWales, williamWales),
						vorfahre(henryWales, beatriceYork),
						vorfahre(henryWales, eugineYork),
						vorfahre(henryWales, anneRoyal),
						vorfahre(henryWales, andrewDuke),
						vorfahre(henryWales, sarahFergurson),
						vorfahre(henryWales, edwardWessex),
						vorfahre(henryWales, davidLinley),
						vorfahre(henryWales, sarah),
						vorfahre(henryWales, margaretRose),
						vorfahre(henryWales, antonyArmstrongJones),
						vorfahre(henryWales, henryWales).
						
test(schwester,[fail]) :- 	schwester(eugineYork, sarahFergurson),
							schwester(andrewDuke, sarah).
						
test(bruder,[fail]) :-	bruder(sarah, edwardWessex),
						bruder(charlesWales, davidLinley).
					
test(onkel,[fail]) :-	onkel(eugineYork, davidLinley),
						onkel(henryWales, phillipDuke).
						
test(tante,[fail]):-	tante(andrewDuke, elizabethBowsLyon),
						tante(sarah, beatriceYork).
						
test(grosstante,[fail]):- 	grosstante(beatriceYork, elizabethII),
							grosstante(henryWales, elizabethBowsLyon).
							
test(grossonkel,[fail]):-	grossonkel(williamWales, phillipDuke),
							grossonkel(beatriceYork, georgeWindsowVI).

:- end_tests(stammbaum).