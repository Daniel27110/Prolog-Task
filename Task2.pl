% Task 2. Write a LP program to operate over square matrices (e.g., [[1 2 3][2 4 6] [7 8 9
% ]]). The program should have four messages to sum or multiply the elements in a column
% or row (i.e., SumCol. SumRow, MultCol, MultRow receiving the matrix and the column/row to
% operate on), and two messages to sum or multiply all elements in the matrix (i.e., SumMat
% and MultMat receiving a matrix).


% //////////////////////////////////////////////////////////////////////
% RULES
% //////////////////////////////////////////////////////////////////////

% /////////////////// Sum all elements in a column ///////////////////// 

% Sum all elements in the Nth row of a matrix 
sumNthRow(Matrix, RowIndex, Sum) :-
    getNthRow(Matrix, RowIndex, Row),
    sumRow(Row, Sum).

% Sum all elements in a row
sumRow([], 0).
sumRow([H|T], N):-
    sumRow(T, X),
    N is X + H.

% Get the Nth row of a matrix
getNthRow([], _, []).
getNthRow([H|_], 1, H).
getNthRow([_|T], N, R):-
    N1 is N - 1,
    getNthRow(T, N1, R).

% /////////////////// Sum all elements in a column /////////////////////

% Sum all elements in a column
sumNthCol(Matrix, ColIndex, Sum) :-
    getNthCol(Matrix, ColIndex, Col),
    sumCol(Col, Sum).

% Sum all elements in a column
sumCol([], 0).
sumCol([H|T], N):-
    sumCol(T, X),
    N is X + H.

% Get the Nth column of a matrix
getNthCol([], _, []).
getNthCol([Row|Rest], N, [Elem|ColRest]):-
    getNthElement(Row, N, Elem),
    getNthCol(Rest, N, ColRest).

% Get the Nth element of a list
getNthElement([], _, _) :- fail.
getNthElement([H|_], 1, H).
getNthElement([_|T], N, R):-
    N > 1,
    N1 is N - 1,
    getNthElement(T, N1, R).

% /////////////////// Sum all elements in a matrix /////////////////////

% Sum all elements in a matrix
sumMat([], 0).
sumMat([Row|Rest], Sum):-
    sumMat(Rest, X),
    sumRow(Row, RowSum),
    Sum is X + RowSum.

% /////////////////// Multiply all elements in a row /////////////////////

% Multiply all elements in a row
multNthRow(Matrix, RowIndex, Mult) :-
    getNthRow(Matrix, RowIndex, Row),
    multRow(Row, Mult).

% Multiply all elements in a row
multRow([], 1).
multRow([H|T], N):-
    multRow(T, X),
    N is X * H.

% /////////////////// Multiply all elements in a column /////////////////////

% Multiply all elements in a column
multNthCol(Matrix, ColIndex, Mult) :-
    getNthCol(Matrix, ColIndex, Col),
    multCol(Col, Mult).

% Multiply all elements in a column
multCol([], 1).
multCol([H|T], N):-
    multCol(T, X),
    N is X * H.

% /////////////////// Multiply all elements in a matrix /////////////////////

% Multiply all elements in a matrix
multMat([], 1).
multMat([Row|Rest], Mult):-
    multMat(Rest, X),
    multRow(Row, RowMult),
    Mult is X * RowMult.

% //////////////////////////////////////////////////////////////////////
% TEST CASES
% //////////////////////////////////////////////////////////////////////

% First test case: Matrix [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

% Define the matrix
:- write('First test Case: Matrix [1, 2, 3]'), nl.
:- write('                        [4, 5, 6]'), nl.
:- write('                        [7, 8, 9]'), nl.
:- nl.

% sum all elements in the first row
:- write('The sum of all elements in the second row is: ').
?- sumNthRow([[1, 2, 3], [4, 5, 6], [7, 8, 9]], 2, Sum), write(Sum). % 15 = 4 + 5 + 6
:- nl.

% sum all elements in the second column
:- write('The sum of all elements in the third column is: ').
?- sumNthCol([[1, 2, 3], [4, 5, 6], [7, 8, 9]], 3, Sum), write(Sum). % 18 = 3 + 6 + 9
:- nl.

% sum all elements in the matrix
:- write('The sum of all elements in the matrix is: ').
?- sumMat([[1, 2, 3], [4, 5, 6], [7, 8, 9]], Sum), write(Sum). % 42 = 1 + 2 + 3 + 2 + 4 + 6 + 7 + 8 + 9
:- nl.
:- nl.

% multiply all elements in the third row
:- write('The product of all elements in the third row is: ').
?- multNthRow([[1, 2, 3], [4, 5, 6], [7, 8, 9]], 3, Mult), write(Mult). % 504 = 7 * 8 * 9
:- nl.

% multiply all elements in the first column
:- write('The product of all elements in the first column is: ').
?- multNthCol([[1, 2, 3], [4, 5, 6], [7, 8, 9]], 1, Mult), write(Mult). % 28 = 1 * 4 * 7
:- nl.

% multiply all elements in the matrix
:- write('The product of all elements in the matrix is: ').
?- multMat([[1, 2, 3], [4, 5, 6], [7, 8, 9]], Mult), write(Mult). % 362880 = 1 * 2 * 3 * 2 * 4 * 6 * 7 * 8 * 9
:- nl.



