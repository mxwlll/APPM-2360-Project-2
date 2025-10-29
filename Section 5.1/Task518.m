
%This upper portion represents our expectations.

%When you transpose a matrix, you are swapping its rows and columns, then
%flipping the matrix over its main diagonal. To be more specific, row
%sbecome columns, and elements are swapped, but the main diagonal stays
%put. Our expected visual effects are that the transposed image should
%reflect the image across the main diagonal, swap dimensions, creating an
%effect that looks like the imagr has been rotated 90 degrees and flipped.
%Furthermore, we expect the top edge of the originaal image to become the
%left edge of the transposeed image, the bottom edge becomes the right
%edge, the left edge becomes the top edge, and the right edge becomes the
%bottom edge. 

%Here is the code 

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

% Transpose each color channel
X_red_transposed = X_red';
X_green_transposed = X_green';
X_blue_transposed = X_blue';

% Get new dimensions after transpose
[m_new, n_new] = size(X_red_transposed);

% Reconstruct the original color image
X_color_original = zeros(m, n, 3);
X_color_original(:,:,1) = X_red;
X_color_original(:,:,2) = X_green;
X_color_original(:,:,3) = X_blue;

% Reconstruct the transposed color image
X_color_transposed = zeros(m_new, n_new, 3);
X_color_transposed(:,:,1) = X_red_transposed;
X_color_transposed(:,:,2) = X_green_transposed;
X_color_transposed(:,:,3) = X_blue_transposed;

% Display original and transposed images
figure;
subplot(1,2,1);
imagesc(uint8(X_color_original));
title(sprintf('Original Color Image (%d×%d)', m, n));
axis image;

subplot(1,2,2);
imagesc(uint8(X_color_transposed));
title(sprintf('Transposed Image (%d×%d)', m_new, n_new));
axis image;

fprintf('Original image dimensions: %d rows × %d columns\n', m, n);
fprintf('Transposed image dimensions: %d rows × %d columns\n', m_new, n_new);
fprintf('\nWhat transposing does:\n');
fprintf('- Swaps rows and columns\n');
fprintf('- Element at position (i,j) moves to position (j,i)\n');
fprintf('- Reflects the image across the main diagonal (top-left to bottom-right)\n');
fprintf('- Result: Image is rotated 90° counterclockwise AND flipped horizontally\n');
fprintf('  (equivalent to rotating 90° clockwise and flipping vertically)\n');