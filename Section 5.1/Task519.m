% Question 9: Crop the image by adding a black border

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

% Define border sizes (make them obvious)
border_vertical = 50;    % pixels to crop from top and bottom
border_horizontal = 80;  % pixels to crop from left and right

% Create VERTICAL cropping matrix (m×m)
% This will zero out the top and bottom rows
T_vert = eye(m);

% Zero out the first border_vertical rows (top border)
T_vert(1:border_vertical, 1:border_vertical) = 0;

% Zero out the last border_vertical rows (bottom border)
T_vert(m-border_vertical+1:m, m-border_vertical+1:m) = 0;

% Create HORIZONTAL cropping matrix (n×n)
% This will zero out the left and right columns
T_horiz = eye(n);

% Zero out the first border_horizontal columns (left border)
T_horiz(1:border_horizontal, 1:border_horizontal) = 0;

% Zero out the last border_horizontal columns (right border)
T_horiz(n-border_horizontal+1:n, n-border_horizontal+1:n) = 0;

% Apply cropping to each color channel
% Use both transformations: T_vert * X * T_horiz
X_red_cropped = T_vert * X_red * T_horiz;
X_green_cropped = T_vert * X_green * T_horiz;
X_blue_cropped = T_vert * X_blue * T_horiz;

% Reconstruct the original and cropped color images
X_color_original = zeros(m, n, 3);
X_color_original(:,:,1) = X_red;
X_color_original(:,:,2) = X_green;
X_color_original(:,:,3) = X_blue;

X_color_cropped = zeros(m, n, 3);
X_color_cropped(:,:,1) = X_red_cropped;
X_color_cropped(:,:,2) = X_green_cropped;
X_color_cropped(:,:,3) = X_blue_cropped;

% Display the transformation matrices using spy()
figure;
subplot(2,3,1);
spy(T_vert);
title(sprintf('Vertical Crop Matrix (%d×%d)', m, m));
xlabel('Column Index');
ylabel('Row Index');

subplot(2,3,2);
spy(T_horiz);
title(sprintf('Horizontal Crop Matrix (%d×%d)', n, n));
xlabel('Column Index');
ylabel('Row Index');

% Display original image
subplot(2,3,3);
imagesc(uint8(X_color_original));
title('Original Color Image');
axis image;

% Display cropped image (spans bottom row)
subplot(2,3,[4,5,6]);
imagesc(uint8(X_color_cropped));
title(sprintf('Cropped Image (Border: %d vertical, %d horizontal)', ...
    border_vertical, border_horizontal));
axis image;

fprintf('Image dimensions: %d rows × %d columns\n', m, n);
fprintf('Vertical border (top & bottom): %d pixels\n', border_vertical);
fprintf('Horizontal border (left & right): %d pixels\n', border_horizontal);
fprintf('Vertical crop matrix: %d × %d\n', m, m);
fprintf('Horizontal crop matrix: %d × %d\n', n, n);
fprintf('Operation: T_vert * X * T_horiz\n');
fprintf('Effect: Creates black borders by zeroing out edge pixels\n');