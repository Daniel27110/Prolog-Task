% Task 1. Write a LP program implementation for real open intervals. The intervals should
% respond to the following messages:
% • left that returns the left endpoint of the interval
% • right that returns the right endpoint of the interval
% • in that receives a floating number and determines if the point is in the interval
% • in that receives an interval an determines whether the interval is contained, left-
% contained (only the left endpoint of the parameter is in the interval), right-contained
% (only the right endpoint of the parameter is in the interval), disjoint, or contains
% the interval
% • update that receives two floating numbers and updates the left and right endpoints
% of the interval

% //////////////////////////////////////////////////////////////////////
% RULES
% //////////////////////////////////////////////////////////////////////

% Define the interval as a (Left, Right) pair, where Left must be less than Right
createInterval(Left, Right) :- Left >= Right, write('The interval is not valid').
createInterval(Left, Right) :- Left < Right, assert(interval(Left, Right)).

% Get the left endpoint of the interval, given the interval (Left, Right)
left(Left, Right) :- interval(Left, Right), write(Left).

% Get the right endpoint of the interval, given the interval (Left, Right)
right(Left, Right) :- interval(Left, Right), write(Right).

% Check if a point is in the interval, given the interval (Left, Right) and the point
in(Left, Right, Point) :- interval(Left, Right), Point > Left, Point < Right, write('Yes'), !.

in(_, _, _) :- write('No').

% Check if an interval is contained, left-contained, right-contained, disjoint, or contains the interval
% It receives two intervals (Left1, Right1) and (Left2, Right2).
relation(Left1, Right1, Left2, Right2) :- 
    interval(Left1, Right1), interval(Left2, Right2),
    Left1 = Left2, Right1 = Right2, write('equals'), !.

relation(Left1, Right1, Left2, Right2) :- 
    interval(Left1, Right1), interval(Left2, Right2),
    Left1 < Left2, Right1 > Right2, write('contains'), !.

relation(Left1, Right1, Left2, Right2) :-
    interval(Left1, Right1), interval(Left2, Right2),
    Left1 > Left2, Right1 < Right2, write('contained'), !.

relation(Left1, Right1, Left2, Right2) :-
    interval(Left1, Right1), interval(Left2, Right2),
    Right1 >= Left2, Left1 =< Left2, write('right-contained'), !.

relation(Left1, Right1, Left2, Right2) :-
    interval(Left1, Right1), interval(Left2, Right2),
    Left1 =< Right2, Right1 >= Right2, write('left-contained'), !.

relation(_, _, _, _) :- write('disjoint').

% Update the interval, given the interval (Left, Right) and the new left and right endpoints
update(Left, Right, NewLeft, NewRight) :- retract(interval(Left, Right)), assert(interval(NewLeft, NewRight)).

% Check if an interval exists in the knowledge base
exists(Left, Right) :- interval(Left, Right), write('Yes'), !.
exists(_, _) :- write('No').


% //////////////////////////////////////////////////////////////////////
% TEST CASES
% //////////////////////////////////////////////////////////////////////

% First test case: Interval (1, 5)

% Define the interval
:- write('First test Case: Interval (1, 5)'), nl.
:- createInterval(1.0, 5.0). % Add the interval (1, 5) to the knowledge base
:- nl.

% Get the left endpoint of the interval
:- write('The left endpoint of the interval is: ').
?- left(1.0, 5.0). % 1
:- nl.

% Get the right endpoint of the interval
:- write('The right endpoint of the interval is: ').
?- right(1.0, 5.0). % 5
:- nl. 

% Check if the point 3 is in the interval
:- write('Is the point 3 in the interval? ').
?- in(1.0, 5.0, 3.0). % Yes
:- nl.

% Check if the point 7 is in the interval
:- write('Is the point 7 in the interval? ').
?- in(1.0, 5.0, 7.0). % No
:- nl.

% Check if the interval (1, 5) is contained in the interval (1, 5)
:- write('The interval (1, 5) ').
?- relation(1.0, 5.0, 1.0, 5.0). % Equals
:- write(' the interval (1, 5)').
:- nl.

% Check if the interval (1, 5) is contained in the interval (0, 6)
:- write('The interval (1, 5) ').
?- relation(1.0, 5.0, 0.0, 6.0). % Is contained by
:- write(' the interval (0, 6)').
:- nl.

% Check if the interval (1, 5) is contained in the interval (2, 4)
:- write('The interval (1, 5) ').
?- relation(1.0, 5.0, 2.0, 4.0). % Contains
:- write(' the interval (2, 4)').
:- nl.

% Check if the interval (1, 5) is contained in the interval (5, 7)
:- write('The interval (1, 5) is ').
?- relation(1.0, 5.0, 5.0, 7.0). % Is right-contained in
:- write(' in the interval (5, 7)').
:- nl.

% Check if the interval (1, 5) is contained in the interval (0, 1)
:- write('The interval (1, 5) is ').
?- relation(1.0, 5.0, 0.0, 1.0). % Is left-contained in
:- write(' in the interval (0, 1)').
:- nl.

% Check if the interval (1, 5) is contained in the interval (6, 7)
:- write('The interval (1, 5) is ').
?- relation(1.0, 5.0, 6.0, 7.0). % Disjoint
:- write(' with the interval (6, 7)').
:- nl, nl.

% Update the interval (1, 5) to (2, 6)
:- write('Updating the interval (1, 5) to (2, 6)').
?- update(1.0, 5.0, 2.0, 6.0).
:- nl.

% Check if interval (1, 5) is still in the knowledge base
:- write('Is the interval (2, 6) in the knowledge base? ').
?- exists(2.0, 6.0). % Yes
:- nl.

% Check if interval (1, 5) is still in the knowledge base
:- write('Is the interval (1, 5) in the knowledge base? ').
?- exists(1.0, 5.0). % No
:- nl.

% //////////////////////////////////////////////////////////////////////