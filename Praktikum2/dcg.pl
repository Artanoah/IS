% ########## Wissensbasis und Funktionen aus Aufgabe 1 Beginn ##########
:-include(stammbaum).
:-include(lex).

%####stammbaum####
%###lex###

% Grammatik-Regeln
s(s(I, VP, PP))      --> i(I, AGR1), vp(VP, AGR1), pp(PP, AGR2).
s(s(V, E, NP, PP))   --> v(V, AGR1), e(E, AGR1), np(NP, AGR1), pp(PP, AGR2).
vp(vp(V, NP), AGR)   --> v(V, AGR), np(NP, AGR).
np(np(A, N), AGR)    --> a(A, AGR), n(N, AGR).
np(np(N), AGR)       --> n(N, AGR).
pp(pp(P, E), AGR)    --> p(P, AGR), e(E, AGR).


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

test(elternteil,[fail]):- elternteil(anneRoyal, antonyArmstrongJones).
test(elternteil,[fail]):- elternteil(davidLinley, elizabethII).

test(opa,[fail]):- opa(williamWales, charlesWales).
test(opa,[fail]):- opa(sarah, antonyArmstrongJones).

test(oma,[fail]):- oma(beatriceYork, sarahFergurson).
test(oma,[fail]):- oma(andrewDuke, elizabethII).

test(vorfahre,[fail]):- vorfahre(henryWales, williamWales).
test(vorfahre,[fail]):- vorfahre(henryWales, beatriceYork).
test(vorfahre,[fail]):- vorfahre(henryWales, eugineYork).
test(vorfahre,[fail]):- vorfahre(henryWales, anneRoyal).
test(vorfahre,[fail]):- vorfahre(henryWales, andrewDuke).
test(vorfahre,[fail]):- vorfahre(henryWales, sarahFergurson).
test(vorfahre,[fail]):- vorfahre(henryWales, edwardWessex).
test(vorfahre,[fail]):- vorfahre(henryWales, davidLinley).
test(vorfahre,[fail]):- vorfahre(henryWales, sarah).
test(vorfahre,[fail]):- vorfahre(henryWales, margaretRose).
test(vorfahre,[fail]):- vorfahre(henryWales, antonyArmstrongJones).
test(vorfahre,[fail]):- vorfahre(henryWales, henryWales).

test(schwester,[fail]) :- schwester(eugineYork, sarahFergurson).
test(schwester,[fail]) :- schwester(andrewDuke, sarah).

test(bruder,[fail]) :-  bruder(sarah, edwardWessex).
test(bruder,[fail]) :-  bruder(charlesWales, davidLinley).

test(onkel,[fail]) :-   onkel(eugineYork, davidLinley).
test(onkel,[fail]) :-   onkel(henryWales, phillipDuke).

test(tante,[fail]):-    tante(andrewDuke, elizabethBowsLyon).
test(tante,[fail]):-    tante(sarah, beatriceYork).

test(grosstante,[fail]):- grosstante(beatriceYork, elizabethII).
test(grosstante,[fail]):- grosstante(henryWales, elizabethBowsLyon).

test(grossonkel,[fail]):- grossonkel(williamWales, phillipDuke).
test(grossonkel,[fail]):- grossonkel(beatriceYork, georgeWindsowVI).

test(schwager, [fail]) :- schwager(charlesWales, anneRoyal).
test(schwager, [fail]) :- schwager(georgeWindsowVI, elizabethII).

test(schwaegerin, [fail]) :- schwaegerin(sarah, margaretRose).
test(schwaegerin, [fail]) :- schwaegerin(sarahFergurson, dianaSpencer).

test(schwippschwager, [fail]) :- schwippschwager(henryWales, williamWales).
test(schwippschwager, [fail]) :- schwippschwager(dianaSpencer, andrewDuke).

test(schwippschwaegerin, [fail]) :- schwippschwaegerin(eugineYork, beatriceYork).
test(schwippschwaegerin, [fail]) :- schwippschwaegerin(phillipDuke, antonyArmstrongJones).
:- end_tests(stammbaum).

:- begin_tests(grammatik).
test(s,[nondet]) :- s(S,[ist,margaretRose,die,tante,von,andrewDuke],[]).

:- end_tests(grammatik).