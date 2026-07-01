-- DIFFERENCE BETWEEN CTEs and TEMP TABLES 

-- CTE is a temporary named result set that exists only for the duration of a single query,
-- And, is mainly used to improve query readability and handle recursive queries.

-- TEMPORARY TABLE is a physical temporary table stored in the database session, 
-- That can be referenced multiple times across different queries and is useful for handling large intermediate datasets.


-- CTE_1 :-
-- Exists only for a single query.
-- TEMP_TABLE_1 :-
-- Exists for the entire session(or until dropped).

-- CTE_2 :-
-- Not stored as a physical table.
-- TEMP_TABLE_2 :-
-- Data is stored in a temporary table.

-- CTE_3 :-
-- Improves query readability.
-- TEMP_TABLE_3 :-
-- Useful for reusing intermediate results.

-- CTE_4 :-
-- Cannot be referenced in seperate queries.
-- TEMP_TABLE_4 :-
-- Can be referenced in multiple queries.

-- CTE_5 :-
-- Best for simple or one-time calculations.
-- TEMP_TABLE_5 :-
-- Best for large datasets and replaced use.
