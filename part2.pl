schedule(istanbul, izmir, 2).
schedule(izmir, istanbul, 2).

schedule(istanbul, ankara, 1).
schedule(ankara, istanbul, 1).

schedule(istanbul, rize, 4).
schedule(rize, istanbul, 4).

schedule(antalya, diyarbakir, 4).
schedule(diyarbakir, antalya, 4).

schedule(canakkale, erzincan, 6).
schedule(erzincan, canakkale, 6).

schedule(izmir, ankara, 6).
schedule(ankara, izmir, 6).

schedule(van, gaziantep, 3).
schedule(gaziantep, van, 3).

schedule(izmir, antalya, 2).
schedule(antalya, izmir, 2).

schedule(ankara, van, 3).
schedule(van, ankara, 3).

schedule(ankara, diyarbakir, 8).
schedule(diyarbakir, ankara, 8).

schedule(istanbul, trabzon, 4).
schedule(trabzon, istanbul, 4).

schedule(rize, artvin, 4).
schedule(artvin, rize, 4).

connection(X, Y, C) :-
    schedule(X, Y, C).
connection(X, Y, C) :-
    schedule(Y, X, C).
connection(X, Y, C) :-
    schedule(X, Z, Cfirst),
    schedule(Z, Y, Csecond),
    C is Cfirst + Csecond.