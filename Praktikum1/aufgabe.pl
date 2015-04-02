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
frau(eliztabethII).
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
vater(eliztabethII, georgeWindsowVI).
vater(margaretRose, georgeWindsowVI).

mutter(williamWales, dianaSpencer).
mutter(henryWales, dianaSpencer).
mutter(beatriceYork, sarahFergurson).
mutter(eugineYork, sarahFergurson).
mutter(charlesWales, eliztabethII).
mutter(anneRoyal, eliztabethII).
mutter(andrewDuke, eliztabethII).
mutter(edwardWessex, eliztabethII).
mutter(davidLinley, margaretRose).
mutter(sarah, margaretRose).
mutter(eliztabethII, elizabethBowsLyon).
mutter(margaretRose, elizabethBowsLyon).

person(Person) :- mann(Person).
person(Person) :- frau(Person).

elternteil(Kind, Eltern) :- vater(Kind, Eltern).
elternteil(Kind, Eltern) :- mutter(Kind, Eltern).

% Grosseltern
opa(Neffe, Opa) :- person(Neffe), mann(Opa), mann(Vater),
                   vater(Neffe, Vater), vater(Vater, Opa).
opa(Neffe, Opa) :- person(Neffe), mann(Opa), frau(Mutter),
                   mutter(Neffe, Mutter), vater(Mutter, Opa).

oma(Neffe, Oma) :- person(Neffe), frau(Oma), mann(Vater),
                   vater(Neffe, Vater), mutter(Vater, Oma).
oma(Neffe, Oma) :- person(Neffe), frau(Oma), frau(Mutter),
                   mutter(Neffe, Mutter), mutter(Mutter, Oma).

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