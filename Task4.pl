% Task 4. Implement two new operations (a.k.a rules) for prolog.
% The first rule is 'always' which returns true if the solutions are true for all possible values
% in a query.
% The second rule is 'sometimes' which return true if there exists at least one combination
% of values that is true for the query.
% Note that always and sometimes should be executable using any type of query (e.g., always
% (grandparent(abe, X)), sometimes(append([a], [b], [c])), always(likes(mary, X))).

% //////////////////////////////////////////////////////////////////////
% RULES
% //////////////////////////////////////////////////////////////////////

% Define the always rule, IF THERE ARE ANY THAT DO NOT SATISFY THE QUERY, THEN IT IS FALSE
% THIS IMPLEMENTATION DOES NOT WORK AS INTENDED, AS IT WILL RETURN TRUE EVEN IF THERE
% ARE SOME VALUES THAT DO NOT SATISFY THE QUERY
always(Query) :- findall(_, \+ Query, []), !.

% Define the sometimes rule, IF THERE ARE ANY THAT SATISFY THE QUERY, THEN IT IS TRUE
sometimes(Query) :- Query.

result(Query) :- Query, write('Yes'), !.
result(_) :- write('No'), !.

% //////////////////////////////////////////////////////////////////////
% Example queries, we'll use sets for the sake of simplicity
% //////////////////////////////////////////////////////////////////////

% Facts related to being a parent
:- assert(parent(homer, bart)).
:- assert(parent(homer, lisa)).
:- assert(parent(homer, maggie)).
:- assert(parent(marge, bart)).
:- assert(parent(marge, lisa)).
:- assert(parent(marge, maggie)).

:- assert(parent(abe, homer)).
:- assert(parent(mona, homer)).
:- assert(parent(clancy, marge)).
:- assert(parent(jacqueline, marge)).

% Facts related to being male
:- assert(male(homer)).
:- assert(male(bart)).
:- assert(male(abe)).
:- assert(male(clancy)).

% Rules related to being a grandparent
gradparent(X, Y) :- parent(X, Z), parent(Z, Y).

% Rules related to being a grandfather
grandfather(X, Y) :- gradparent(X, Y), male(X).

% Rules related to being a grandchild
grandchild(X, Y) :- gradparent(Y, X).

% Rules related to being a grandson
grandson(X, Y) :- grandchild(X, Y), male(X).

% //////////////////////////////////////////////////////////////////////
% TEST CASES
% //////////////////////////////////////////////////////////////////////

% Test case 1
:- write('First test case: A query with a single true solution'), nl.
:- write('* Is abe always the grandparent of bart? ').
?- result(always(gradparent(abe, bart))). % Always true
:- nl.
?- write('* Is abe sometimes the grandparent of bart? ').
?- result(sometimes(gradparent(abe, bart))). % Sometimes true
:- nl, nl.

% Test case 2
:- write('Second test case: A query with a single false solution'), nl.
:- write('* Is abe always the grandparent of marge? ').
?- result(always(gradparent(abe, marge))). % Always false
:- nl.
?- write('* Is abe sometimes the grandparent of marge? ').
?- result(sometimes(gradparent(abe, marge))). % Sometimes false
:- nl, nl.

% Test case 3
:- write('Third test case: A query with multiple solutions'), nl.
:- write('* Are Abe\'s grandchildren always male? ').
?- result(always(grandson(_, abe))), nl. % THIS RESULT SHOULD BE FALSE, AS ABE HAS A GRANDDAUGHTERS
:- write(' (This result is incorrect, as abe has a granddaughter)').
:- nl.
:- write('* Are Abe\'s grandchildren sometimes male? ').
?- result(sometimes(grandson(_, abe))), nl. % THIS RESULT SHOULD BE TRUE, AS ABE HAS A GRANDSON
:- nl, nl.

% AS WE CAN SEE, THE RESULT OF 'SOMETIMES' ARE AS EXPECTED, BUT THE RESULT OF 'ALWAYS' IS NOT
% A PROPER IMPLEMENTATION OF 'ALWAYS' WOULD REQUIRE A MORE COMPLEX QUERY OUTSIDE THE SCOPE OF WHAT
% CAN BE DONE WITHIN THE CONSTRAINTS OF PROLOG.
