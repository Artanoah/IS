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
% elternteil(herbert, mona).
% elternteil(marge, jacqueline).
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

mann(bob).

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
elternteil(williamWales, charlesWales).
elternteil(henryWales, charlesWales).
elternteil(beatriceYork, andrewDuke).
elternteil(eugineYork, andrewDuke).
elternteil(charlesWales, phillipDuke).
elternteil(anneRoyal, phillipDuke).
elternteil(andrewDuke, phillipDuke).
elternteil(edwardWessex, phillipDuke).
elternteil(davidLinley, antonyArmstrongJones).
elternteil(sarah, antonyArmstrongJones).
elternteil(elizabethII, georgeWindsowVI).
elternteil(margaretRose, georgeWindsowVI).

elternteil(williamWales, dianaSpencer).
elternteil(henryWales, dianaSpencer).
elternteil(beatriceYork, sarahFergurson).
elternteil(eugineYork, sarahFergurson).
elternteil(charlesWales, elizabethII).
elternteil(anneRoyal, elizabethII).
elternteil(andrewDuke, elizabethII).
elternteil(edwardWessex, elizabethII).
elternteil(davidLinley, margaretRose).
elternteil(sarah, margaretRose).
elternteil(elizabethII, elizabethBowsLyon).
elternteil(margaretRose, elizabethBowsLyon).



% Heiratsbeziehungen
vh(georgeWindsowVI, elizabethBowsLyon).
vh(phillipDuke, elizabethII).
vh(margaretRose, antonyArmstrongJones).
vh(charlesWales, dianaSpencer).
vh(andrewDuke, sarahFergurson).

verheiratet(P1, P2) :- vh(P1, P2), !.
verheiratet(P1, P2) :- vh(P2, P1).

person(Person) :- mann(Person).
person(Person) :- frau(Person).

vater(Kind, Eltern) :- elternteil(Kind, Eltern), mann(Eltern).
mutter(Kind, Eltern) :- elternteil(Kind, Eltern), frau(Eltern).

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

schwager(Person, Schwager) :- person(Person), mann(Schwager), person(Geschwisterchen),
							  geschwister(Person, Geschwisterchen), verheiratet(Geschwisterchen, Schwager).
schwager(Person, Schwager) :- person(Person), mann(Schwager), person(Geschwisterchen),
							  verheiratet(Person, Geschwisterchen), geschwister(Geschwisterchen, Schwager).
							  
schwaegerin(Person, Schwaegerin) :- person(Person), frau(Schwaegerin), person(Geschwisterchen),
							  geschwister(Person, Geschwisterchen), verheiratet(Geschwisterchen, Schwaegerin).
schwaegerin(Person, Schwaegerin) :- person(Person), frau(Schwaegerin), person(Geschwisterchen),
							  verheiratet(Person, Geschwisterchen), geschwister(Geschwisterchen, Schwaegerin).

schwippschwager(Person, SchwippSchwager) :- person(Person), mann(SchwippSchwager),
											geschwister(Person, Geschwisterchen), verheiratet(Geschwisterchen, Schwager),
											geschwister(Schwager, SchwippSchwager).
schwippschwager(Person, SchwippSchwager) :- person(Person), mann(SchwippSchwager),
											verheiratet(Person, Ehepartner), geschwister(Ehepartner, Schwager),
											verheiratet(Schwager, SchwippSchwager).
											
schwippschwaegerin(Person, SchwippSchwager) :- person(Person), frau(SchwippSchwager),
											geschwister(Person, Geschwisterchen), verheiratet(Geschwisterchen, Schwager),
											geschwister(Schwager, SchwippSchwager).
schwippschwaegerin(Person, SchwippSchwager) :- person(Person), frau(SchwippSchwager),
											verheiratet(Person, Ehepartner), geschwister(Ehepartner, Schwager),
											verheiratet(Schwager, SchwippSchwager).

% Testfaelle
:- begin_tests(stammbaum).
%Positive Tests

test(person, [nondet]) :- person(williamWales),
				person(sarahFergurson).

test(elternteil, [nondet]) :- elternteil(anneRoyal, phillipDuke),
					elternteil(davidLinley, margaretRose).

test(opa, [nondet]) :- opa(williamWales, phillipDuke),
			 opa(sarah, georgeWindsowVI).

test(oma, [nondet]) :- oma(beatriceYork, elizabethII),
			 oma(andrewDuke, elizabethBowsLyon).

test(vorfahre, [nondet]) :- vorfahre(henryWales, georgeWindsowVI),
				  vorfahre(henryWales, elizabethBowsLyon),
				  vorfahre(henryWales, phillipDuke),
				  vorfahre(henryWales, elizabethII),
				  vorfahre(henryWales, dianaSpencer),
				  vorfahre(henryWales, charlesWales).

test(schwester, [nondet]) :- schwester(eugineYork, beatriceYork),
				   schwester(andrewDuke, anneRoyal).

test(bruder, [nondet]) :- bruder(sarah, davidLinley),
				bruder(charlesWales, andrewDuke).

test(onkel, [nondet]) :- onkel(eugineYork, edwardWessex),
			   onkel(henryWales, andrewDuke).

test(tante, [nondet]) :- tante(andrewDuke, margaretRose),
			   tante(sarah, elizabethII).

test(grosstante, [nondet]) :- grosstante(beatriceYork, margaretRose),
					grosstante(henryWales, margaretRose).

test(schwager, [nondet]) :- schwager(dianaSpencer, andrewDuke),
							schwager(dianaSpencer, edwardWessex),
							schwager(elizabethII, antonyArmstrongJones).

test(schwaegerin, [nondet]) :- schwaegerin(anneRoyal, dianaSpencer),
							   schwaegerin(anneRoyal, sarahFergurson),
							   schwaegerin(antonyArmstrongJones, elizabethII).

test(schwippschwager, [nondet]) :- schwippschwager(phillipDuke, antonyArmstrongJones).

test(schwippschwaegerin, [nondet]) :- schwippschwaegerin(dianaSpencer, sarahFergurson).

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
						
test(schwester,[fail]) :- 	schwester(eugineYork, sarahFergurson).
test(schwester,[fail]) :-	schwester(andrewDuke, sarah).
						
test(bruder,[fail]) :-	bruder(sarah, edwardWessex).
test(bruder,[fail])	:-	bruder(charlesWales, davidLinley).
					
test(onkel,[fail]) :-	onkel(eugineYork, davidLinley).
test(onkel,[fail]) :-	onkel(henryWales, phillipDuke).
						
test(tante,[fail]):-	tante(andrewDuke, elizabethBowsLyon).
test(tante,[fail]):-	tante(sarah, beatriceYork).
						
test(grosstante,[fail]):- 	grosstante(beatriceYork, elizabethII).
test(grosstante,[fail]):- 	grosstante(henryWales, elizabethBowsLyon).
							
test(grossonkel,[fail]):-	grossonkel(williamWales, phillipDuke).
test(grossonkel,[fail]):-	grossonkel(beatriceYork, georgeWindsowVI).

test(schwager, [fail]) :- 	schwager(charlesWales, anneRoyal).
test(schwager, [fail]) :- 	schwager(georgeWindsowVI, elizabethII).

test(schwaegerin, [fail]) :- schwaegerin(sarah, margaretRose).
test(schwaegerin, [fail]) :- schwaegerin(sarahFergurson, dianaSpencer).

test(schwippschwager, [fail]) :- schwippschwager(henryWales, williamWales).
test(schwippschwager, [fail]) :- schwippschwager(dianaSpencer, andrewDuke).

test(schwippschwaegerin, [fail]) :- schwippschwaegerin(eugineYork, beatriceYork).
test(schwippschwaegerin, [fail]) :- schwippschwaegerin(phillipDuke, antonyArmstrongJones).
:- end_tests(stammbaum).