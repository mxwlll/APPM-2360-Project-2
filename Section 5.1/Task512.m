% Question 2: Increase exposure of grayscale image

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

% Increase exposure by adding a constant value to all pixel intensities
% Adding 80 units will brighten the image significantly
exposure_increase = 80;
X_gray_bright = X_gray + exposure_increase;

% Alternative method: Multiply by a factor greater than 1
% X_gray_bright = X_gray * 1.5;  % Increases by 50%

% Make sure values don't exceed 255 (the maximum intensity)
X_gray_bright(X_gray_bright > 255) = 255;

% Display original and increased exposure side by side
figure;
subplot(1,2,1);
imagesc(uint8(X_gray));
colormap(gca, 'gray');
title('Original Grayscale Image');
axis image;
colorbar;

subplot(1,2,2);
imagesc(uint8(X_gray_bright));
colormap(gca, 'gray');
title('Increased Exposure (Whited Out)');
axis image;
colorbar;

% Display the difference
fprintf('Original intensity range: [%.1f, %.1f]\n', min(X_gray(:)), max(X_gray(:)));
fprintf('Increased exposure range: [%.1f, %.1f]\n', min(X_gray_bright(:)), max(X_gray_bright(:)));