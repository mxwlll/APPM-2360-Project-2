%% Task 5.2.10 (Matrix S of any size)

function S = creatematrix(n)
    %Inputs: n (number) the size of the nxn square matrix
    %Outputs: S (matrix) produces the requested matrix size
    
    % Initialize the matrix
    S = zeros(n);
    
    % Use a single loop structure for clarity and efficiency in MATLAB:
    for i = 1:n
        for j = 1:n
            S(i,j) = sqrt(2/n) * sin(pi*(i-0.5)*(j-0.5)/n);
        end
    end
end