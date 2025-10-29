% Question 5: Horizontal shift of 306 pixels to rectangle.jpg (color version)
% For horizontal shifts, we multiply on the RIGHT with a transformation
% matrix, refer to task 514 for my reasoning on that!!

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

% For horizontal shift, we need to transform the COLUMNS
% Start with an n×n identity matrix (since we have n columns)
I_R = eye(n);

% Horizontal shift of 306 pixels (shift columns to the right)
r = 306;

% Create transformation matrix T_horizontal
T_horizontal = zeros(n);

% Fill in the first r columns of T with the last r columns of I_R
% (wraps the rightmost columns around to the left)
T_horizontal(:, 1:r) = I_R(:, n-(r-1):n);

% Fill in the rest of T with the first part of I_R
T_horizontal(:, r+1:n) = I_R(:, 1:n-r);

% Apply horizontal shift to each color channel
% Multiply on the RIGHT for horizontal (column) transformation
X_red_shifted = X_red * T_horizontal;
X_green_shifted = X_green * T_horizontal;
X_blue_shifted = X_blue * T_horizontal;

% Reconstruct the original and shifted color images
X_color_original = zeros(m, n, 3);
X_color_original(:,:,1) = X_red;
X_color_original(:,:,2) = X_green;
X_color_original(:,:,3) = X_blue;

X_color_shifted = zeros(m, n, 3);
X_color_shifted(:,:,1) = X_red_shifted;
X_color_shifted(:,:,2) = X_green_shifted;
X_color_shifted(:,:,3) = X_blue_shifted;

% Display the transformation matrix using spy()
figure;
subplot(2,2,1);
spy(T_horizontal);
title(sprintf('Horizontal Shift Transformation Matrix (%d×%d)', n, n));
xlabel('Column Index');
ylabel('Row Index');

%To be honest I'm confused on exactly what they're asking here..? But I
%just made a matrix graph to represent, I dont know if they want the matrix
%in like handrwitten matrix form...

% Display original image
subplot(2,2,2);
imagesc(uint8(X_color_original));
title('Original Color Image');
axis image;

% Display shifted image
subplot(2,2,[3,4]);
imagesc(uint8(X_color_shifted));
title('Horizontally Shifted Image (306 pixels)');
axis image;

fprintf('Image dimensions: %d rows × %d columns\n', m, n);
fprintf('Horizontal shift: %d pixels to the right (with wrapping)\n', r);
fprintf('Transformation matrix dimensions: %d × %d\n', n, n);