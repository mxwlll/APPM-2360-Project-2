%To swap the leftmost column with the rightmost column of a 4x4 grayscale
%image represented by a matrix A, you would multiply A on the right by a
%4x4 permuation matrix E that switches the first and last columns. The
%matrix E is given by:


%E = [0 0 0 1; 0 1 0 0; 0 0 1 0; 1 0 0 0;]

%Multiplying A by E on the right, AE, swaps the first and fourth columns of
%A while leaving other columns unchanged, producing the result we want.
%Multiplying on the left (in other words, EA) would swap the ROWS instead,
%so only right multiplication achieves the intended column swap we want.


%Here is more-or-less my thought process in mathematical form. Bare with me
%with the look of it.

%Let A = [a_11 a_12 a_13 a_14; a_21 a_22 a_23 a_24; a_31 a_32 a_33 a_34;
%a_41 a_42 a_43 a_44]

%We want the resulting matrix to look something like:

%[a_14 a_12 a_13 a_11; a_24 a_22 a_23 a_21; a_34 a_32 a_33 a_31, a_44 a_42
%a_43 a_41]. Notice that the first and fourth column is swapped, whereas
%the middle columns (2 and 3) stay the same.

%From what I understand by writing on paper, left multiplication (EA)
%affects the rows of A. On the other hand, right multiplication (AE)
%affects the columns of A. Since we want to swap columns, we need right
%multiplication, AE.