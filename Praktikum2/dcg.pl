% ########## Wissensbasis und Funktionen aus Aufgabe 1 Beginn ##########

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
% ########## Wissensbasis und Funktionen aus Aufgabe 1 Ende ##########


% ########## Aufgabe 2 ##########
% agr(Numerus, Person, Geschlecht)
% Eigennamen
e(e(GE), AGR) --> [E], {lex(E, GE, e, AGR)}.
lex(georgeWindsowVI, georgeWindsowVI, e, agr(sg, 3, m)).
lex(phillipDuke, phillipDuke, e, agr(sg, 3, m)).
lex(antonyArmstrongJones, antonyArmstrongJones, e, agr(sg, 3, m)).
lex(charlesWales, charlesWales, e, agr(sg, 3, m)).
lex(andrewDuke, andrewDuke, e, agr(sg, 3, m)).
lex(edwardWessex, edwardWessex, e, agr(sg, 3, m)).
lex(davidLinley, davidLinley, e, agr(sg, 3, m)).
lex(williamWales, williamWales, e, agr(sg, 3, m)).
lex(henryWales, henryWales, e, agr(sg, 3, m)).
lex(elizabethBowsLyon, elizabethBowsLyon, e, agr(sg, 3, f)).
lex(elizabethII, elizabethII, e, agr(sg, 3, f)).
lex(margaretRose, margaretRose, e, agr(sg, 3, f)).
lex(dianaSpencer, dianaSpencer, e, agr(sg, 3, f)).
lex(anneRoyal, anneRoyal, e, agr(sg, 3, f)).
lex(sarahFergurson, sarahFergurson, e, agr(sg, 3, f)).
lex(sarah, sarah, e, agr(sg, 3, f)).
lex(beatriceYork, beatriceYork, e, agr(sg, 3, f)).
lex(eugineYork, eugineYork, e, agr(sg, 3, f)).

% Nomen
n(n(GN), AGR) --> [N], {lex(N, GN, n, AGR)}.
lex(vater, vater, n, agr(sg, 3, m)).
lex(mutter, mutter, n, agr(sg, 3, f)).
lex(onkel, onkel, n, agr(sg, 3, m)).
lex(onkel, onkel, n, agr(pl, _, m)).
lex(tante, tante, n, agr(sg, 3, f)).
lex(tanten, tante, n, agr(pl, _, f)).
lex(opa, opa, n, agr(sg, 3, m)).
lex(opas, opa, n, agr(pl, _, m)).
lex(oma, oma, n, agr(sg, 3, f)).
lex(omas, oma, n, agr(pl, _, f)).
lex(grossonkel, grossonkel, n, agr(sg, 3, m)).
lex(grossonkel, grossonkel, n, agr(pl, _, m)).
lex(grosstante, grosstante, n, agr(sg, 3, f)).
lex(grosstanten, grosstante, n, agr(pl, _, f)).
lex(schwager, schwager, n, agr(sg, 3, m)).
lex(schwager, schwager, n, agr(pl, _, m)).
lex(schwaegerin, schwaegerin, n, agr(sg, 3, f)).
lex(schwaegerinnen, schwaegerin, n, agr(pl, _, f)).
lex(schwippsschwager, schwippsschwager, n, agr(sg, 3, m)).
lex(schwippsschwager, schwippsschwager, n, agr(pl, _, m)).
lex(schwippsschwaegerin, schwippsschwaegerin, n, agr(sg, 3, f)).
lex(schwippsschwaegerinnen, schwippsschwaegerin, n, agr(pl, _, f)).

% Verben
v(v(GV), AGR) --> [V], {lex(V, GV, v, AGR)}.
lex(bin, sein, v, agr(sg, 1, _)).
lex(bist, sein, v, agr(sg, 2, _)).
lex(ist, sein, v, agr(sg, 3, _)).
lex(sind, sein, v, agr(pl, 1, _)).
lex(seid, sein, v, agr(pl, 2, _)).
lex(sind, sein, v, agr(pl, 3, _)).

% Artikel
a(a(GA), AGR) --> [A], {lex(A, GA, a, AGR)}.
lex(der, der, a, agr(sg, _, m)).
lex(die, die, a, agr(pl, _, _)).
lex(die, die, a, agr(sg, _, f)).

% Präposition
p(p(GP), AGR) --> [P], {lex(P, GP, p, AGR)}.
lex(von, von, p, agr(_, _, _)).

% Interrogativpronomen
i(i(GI), AGR) --> [I], {lex(I, GI, i, AGR)}.
lex(wer, wer, i, agr(_, 3, _)).

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

test(elternteil,[fail]):-       elternteil(anneRoyal, antonyArmstrongJones),
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

test(schwester,[fail]) :-       schwester(eugineYork, sarahFergurson).
test(schwester,[fail]) :-       schwester(andrewDuke, sarah).

test(bruder,[fail]) :-  bruder(sarah, edwardWessex).
test(bruder,[fail])     :-      bruder(charlesWales, davidLinley).

test(onkel,[fail]) :-   onkel(eugineYork, davidLinley).
test(onkel,[fail]) :-   onkel(henryWales, phillipDuke).

test(tante,[fail]):-    tante(andrewDuke, elizabethBowsLyon).
test(tante,[fail]):-    tante(sarah, beatriceYork).

test(grosstante,[fail]):-       grosstante(beatriceYork, elizabethII).
test(grosstante,[fail]):-       grosstante(henryWales, elizabethBowsLyon).

test(grossonkel,[fail]):-       grossonkel(williamWales, phillipDuke).
test(grossonkel,[fail]):-       grossonkel(beatriceYork, georgeWindsowVI).

test(schwager, [fail]) :-       schwager(charlesWales, anneRoyal).
test(schwager, [fail]) :-       schwager(georgeWindsowVI, elizabethII).

test(schwaegerin, [fail]) :- schwaegerin(sarah, margaretRose).
test(schwaegerin, [fail]) :- schwaegerin(sarahFergurson, dianaSpencer).

test(schwippschwager, [fail]) :- schwippschwager(henryWales, williamWales).
test(schwippschwager, [fail]) :- schwippschwager(dianaSpencer, andrewDuke).

test(schwippschwaegerin, [fail]) :- schwippschwaegerin(eugineYork, beatriceYork).
test(schwippschwaegerin, [fail]) :- schwippschwaegerin(phillipDuke, antonyArmstrongJones).
:- end_tests(stammbaum).