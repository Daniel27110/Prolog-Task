% Task 3. Implement the quicksort algorithm using a logic algorithm. Given an array it
% should return the quick-sorted array

% //////////////////////////////////////////////////////////////////////
% RULES
% //////////////////////////////////////////////////////////////////////

% Quicksort algorithm
quicksort([], []).
quicksort([H|T], Sorted) :-
    partition(H, T, L, R),
    quicksort(L, SortedL),
    quicksort(R, SortedR),
    append(SortedL, [H|SortedR], Sorted).

% Partition the list into two lists, one with elements less than the pivot and the other with elements greater than the pivot
partition(_, [], [], []).
partition(Pivot, [H|T], [H|L], R) :- H =< Pivot, partition(Pivot, T, L, R).
partition(Pivot, [H|T], L, [H|R]) :- H > Pivot, partition(Pivot, T, L, R).

% //////////////////////////////////////////////////////////////////////
% TEST CASES
% //////////////////////////////////////////////////////////////////////

:- write('First test Case: [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]'), nl.
:- write('Sorted list: ').
?- quicksort([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5], Sorted), write(Sorted).
:- nl.
:- nl.

:- write('Second test Case: [1, 2, 3, 4, 5, 6, 7, 8, 9]'), nl.
:- write('Sorted list: ').
?- quicksort([1, 2, 3, 4, 5, 6, 7, 8, 9], Sorted), write(Sorted).
:- nl.
:- nl.

:- write('Third test Case: [9, 8, 7, 6, 5, 4, 3, 2, 1]'), nl.
:- write('Sorted list: ').
?- quicksort([9, 8, 7, 6, 5, 4, 3, 2, 1], Sorted), write(Sorted).
:- nl.