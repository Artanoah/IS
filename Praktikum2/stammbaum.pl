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