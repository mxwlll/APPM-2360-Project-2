% Question 6: Horizontal AND Vertical shift (306 pixels horizontal, 230 pixels vertical)
% Horizontal shift: multiply on the RIGHT with n×n matrix
% Vertical shift: multiply on the LEFT with m×m matrix

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

% HORIZONTAL SHIFT MATRIX (n×n) - shifts columns, multiply on RIGHT
r_horizontal = 306;
I_R = eye(n);
T_horizontal = zeros(n);

% Fill in the first r_horizontal columns with the last r_horizontal columns of I_R
T_horizontal(:, 1:r_horizontal) = I_R(:, n-(r_horizontal-1):n);
% Fill in the rest with the first part of I_R
T_horizontal(:, r_horizontal+1:n) = I_R(:, 1:n-r_horizontal);

% VERTICAL SHIFT MATRIX (m×m) - shifts rows, multiply on LEFT
r_vertical = 230;
I_L = eye(m);
T_vertical = zeros(m);

% Fill in the first r_vertical rows with the last r_vertical rows of I_L
T_vertical(1:r_vertical, :) = I_L(m-(r_vertical-1):m, :);
% Fill in the rest with the first part of I_L
T_vertical(r_vertical+1:m, :) = I_L(1:m-r_vertical, :);

% Apply BOTH transformations to each color channel
% Order: T_vertical * X * T_horizontal (vertical shift on left, horizontal on right)
X_red_shifted = T_vertical * X_red * T_horizontal;
X_green_shifted = T_vertical * X_green * T_horizontal;
X_blue_shifted = T_vertical * X_blue * T_horizontal;

% Reconstruct the original and shifted color images
X_color_original = zeros(m, n, 3);
X_color_original(:,:,1) = X_red;
X_color_original(:,:,2) = X_green;
X_color_original(:,:,3) = X_blue;

X_color_shifted = zeros(m, n, 3);
X_color_shifted(:,:,1) = X_red_shifted;
X_color_shifted(:,:,2) = X_green_shifted;
X_color_shifted(:,:,3) = X_blue_shifted;

% Display the transformation matrices using spy()
figure;
subplot(2,3,1);
spy(T_vertical);
title(sprintf('Vertical Shift Matrix (%d×%d)', m, m));
xlabel('Column Index');
ylabel('Row Index');

subplot(2,3,2);
spy(T_horizontal);
title(sprintf('Horizontal Shift Matrix (%d×%d)', n, n));
xlabel('Column Index');
ylabel('Row Index');

% Display original image
subplot(2,3,3);
imagesc(uint8(X_color_original));
title('Original Color Image');
axis image;

% Display shifted image (spans bottom row)
subplot(2,3,[4,5,6]);
imagesc(uint8(X_color_shifted));
title('Horizontally AND Vertically Shifted Image (306H, 230V)');
axis image;

fprintf('Image dimensions: %d rows × %d columns\n', m, n);
fprintf('Horizontal shift: %d pixels (right, wrapping)\n', r_horizontal);
fprintf('Vertical shift: %d pixels (down, wrapping)\n', r_vertical);
fprintf('Vertical transformation matrix: %d × %d\n', m, m);
fprintf('Horizontal transformation matrix: %d × %d\n', n, n);
fprintf('Combined operation: T_vertical * X * T_horizontal\n');