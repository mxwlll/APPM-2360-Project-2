% Question 3: Change colors in the color image
% Remove red, keep green unchanged, increase blue by 80 units

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

% Manipulate the color channels:
% 1. Remove all red by multiplying by 0
X_red_modified = X_red * 0;

% 2. Leave green unchanged
X_green_modified = X_green;

% 3. Increase blue intensity by 80 units
X_blue_modified = X_blue + 80;

% Make sure blue values don't exceed 255
X_blue_modified(X_blue_modified > 255) = 255;

% Reconstruct the original color image
[m, n] = size(X_gray);
X_color_original = zeros(m, n, 3);
X_color_original(:,:,1) = X_red;
X_color_original(:,:,2) = X_green;
X_color_original(:,:,3) = X_blue;

% Reconstruct the modified color image
X_color_modified = zeros(m, n, 3);
X_color_modified(:,:,1) = X_red_modified;
X_color_modified(:,:,2) = X_green_modified;
X_color_modified(:,:,3) = X_blue_modified;

% Display original and modified color images side by side
figure;
subplot(1,2,1);
imagesc(uint8(X_color_original));
title('Original Color Image');
axis image;

subplot(1,2,2);
imagesc(uint8(X_color_modified));
title('Modified Color Image (No Red, Blue +80)');
axis image;

% Display information about the changes
fprintf('Red channel: All values set to 0\n');
fprintf('Green channel: Unchanged\n');
fprintf('Blue channel: Increased by 80 units (capped at 255)\n');