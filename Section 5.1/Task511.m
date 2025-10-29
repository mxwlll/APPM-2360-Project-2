
%Task 5.1

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

% Script to display grayscale and color versions of rectangle.jpg
% Make sure rectangle.jpg is in your current directory

% Read the image using the function
[X_gray, X_red, X_green, X_blue] = readImage('rectangle.jpg');

% Display the grayscale version
figure;
subplot(1,2,1);
imagesc(uint8(X_gray));
colormap(gca, 'gray');
title('Grayscale Version');
axis image;

% Reconstruct the color image from separate channels
[m, n] = size(X_gray);
X_color = zeros(m, n, 3);
X_color(:,:,1) = X_red;
X_color(:,:,2) = X_green;
X_color(:,:,3) = X_blue;

% Display the color version
subplot(1,2,2);
imagesc(uint8(X_color));
title('Color Version');
axis image;