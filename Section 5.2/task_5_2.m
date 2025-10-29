% Task 5.2.10 (Matrix S of any size)
n=5;
S = zeros(n);

for i = 1:n
    for j = 1:n
        S(i,j) = sqrt(2/n) * sin(pi*(i-0.5)*(j-0.5)/n);
    end
end

% Task 5.2.11 (Verify that S=S^-1)

disp(round(S*inv(S)))

% Task 5.2.12 (Reverse DST)

% Because S=S^-1, SYS=x_g
% To prove, Y=S(x_g)S so SYS=S^2(x_g)S^2=I(x_g)I=x_g

% Task 5.2.13 (JPEG-like Compression on square.jpg)

x=imread('../square.jpg');
x_double=double(x);

x_r=x_double(:,:,1);
x_gr=x_double(:,:,2);
x_b=x_double(:,:,3);

n=length(x);
S = zeros(n);

for i = 1:n
    for j = 1:n
        S(i,j) = sqrt(2/n) * sin(pi*(i-0.5)*(j-0.5)/n);
    end
end

p=0.05;

for k=1:8

    p=1/2^(k-1);
    y_r=S*x_r*S;
    for i = 1:n
        for j = 1:n
            if (i+j > p*2*n)
            y_r(i,j) = 0;
            end
        end
    end
    x_r=S*y_r*S;
    
    y_gr=S*x_gr*S;
    for i = 1:n
        for j = 1:n
            if (i+j > p*2*n)
            y_gr(i,j) = 0;
            end
        end
    end
    x_gr=S*y_gr*S;
    
    y_b=S*x_b*S;
    for i = 1:n
        for j = 1:n
            if (i+j > p*2*n)
            y_b(i,j) = 0;
            end
        end
    end
    
    x_b=S*y_b*S;
    
    x_comp=cat(3,x_r,x_gr,x_b);
    imwrite(uint8(x_comp), sprintf('square_compressed_p_%.2f.jpg', p))

    y_trans=cat(3,y_r,y_gr,y_b);

    nnz_list(k,1)=p;
    nnz_list(k,2)=nnz(y_trans);

    size_list(k,1)=p;
    size_list(k,2) = dir(sprintf('square_compressed_p_%.2f.jpg', p)).bytes;
    comp_ratio = (size_list(1,2) / size_list(k, 2));
    size_list(k, 3) = comp_ratio; 
end

% Task 5.2.14 (Best p value)

nnz_table = array2table(nnz_list, 'VariableNames', {'p_value', 'non_zero_elements'});
writetable(nnz_table, 'nnz_table.csv');

% I think the best value of p is 0.125 because it retains almost 
% identical visual quality to the original image with 
% about 1/30 of the data.

% Task 5.2.15 (Compression ratios)

size_table = array2table(size_list, 'VariableNames', {'p_value', 'size_in_bytes', 'compression_ratio'});
writetable(size_table, 'size_table.csv');

% p=0.0625 gives the largest CR (1.3222) while still keeping decent
% image quality.

