%On top here will be my explanation: Flipping an image upside down means
%reversing the order of rows. Essentially, Row 1 becomes row m (last row),
%Row 2 becomes row m - 1, and row m becomes row 1.

%Here is my mathematical approach

%Im = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1]

%Reversed Im = [0 0 0 1; 0 0 1 0; 0 1 0 0; 1 0 0 0]

%Need to do LEFT multiplication, as that is the type of multiplication that
%affects the rows. Each row of the result is a linear combination of rows
%from X. The transofmration matrix determines which rows to pick. When you
%multiply on the left, the i-th row of the result is obtained by taking hte
%i-th row of T_flip and multiplying it with X. Since row I of the left
%multiplication has a 1 in position (m - i + 1) and zeros elsewhere, it
%selects row (m - 1 + 1) from X, effectively reversing the row order. 

%Here is my code for task 5.1 (7)

% Question 7: Flip image upside down using transformation matrices

function [X_gray, X_red, X_green, X_blue] = readImage(filename)
    % Read the image file
    X_int = imread(filename);
    
    % Convert to double format for mathematical operations
    X_double = double(X_int);
    
    % Extract individual color channels
    X_red = X_double(:,:,1);
    X_green = X_double(:,:,2);
    X_blue = X_double(:,:,3);
    
    % Create grayscale image by averaging the three color channels
    X_gray = X_double(:,:,1)/3.0 + X_double(:,:,2)/3.0 + X_double(:,:,3)/3.0;
end

% Read the image using the function from Question 1
[X_gray, X_red, X_green, X_blue] = readImage('rectangle.jpg');

% Get dimensions
[m, n] = size(X_gray);

% Create the flip transformation matrix (m×m)
% To flip upside down, we need to reverse the order of rows
% Start with identity matrix and reverse its rows

I_flip = eye(m);

% Create flip matrix by reversing the rows of the identity matrix
% Row 1 should become row m, row 2 should become row m-1, etc.
T_flip = zeros(m);

for i = 1:m
    T_flip(i, :) = I_flip(m - i + 1, :);
end

% Alternative construction (more explicit):
% T_flip = I_flip(m:-1:1, :);  % reverses rows of identity

% Apply flip transformation to each color channel
% Multiply on the LEFT for row (vertical) transformation
X_red_flipped = T_flip * X_red;
X_green_flipped = T_flip * X_green;
X_blue_flipped = T_flip * X_blue;

% Reconstruct the original and flipped color images
X_color_original = zeros(m, n, 3);
X_color_original(:,:,1) = X_red;
X_color_original(:,:,2) = X_green;
X_color_original(:,:,3) = X_blue;

X_color_flipped = zeros(m, n, 3);
X_color_flipped(:,:,1) = X_red_flipped;
X_color_flipped(:,:,2) = X_green_flipped;
X_color_flipped(:,:,3) = X_blue_flipped;

% Display the transformation matrix using spy()
figure;
subplot(2,2,1);
spy(T_flip);
title(sprintf('Flip Transformation Matrix (%d×%d)', m, m));
xlabel('Column Index');
ylabel('Row Index');

% Display original image
subplot(2,2,2);
imagesc(uint8(X_color_original));
title('Original Color Image');
axis image;

% Display flipped image
subplot(2,2,[3,4]);
imagesc(uint8(X_color_flipped));
title('Flipped Upside Down Image');
axis image;

fprintf('Image dimensions: %d rows × %d columns\n', m, n);
fprintf('Flip transformation matrix dimensions: %d × %d\n', m, m);
fprintf('Operation: T_flip * X (multiply on LEFT to affect rows)\n');
fprintf('Effect: Row 1 → Row %d, Row %d → Row 1, etc.\n', m, m);