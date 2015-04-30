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