X = imread('rectangle.jpg');
imagesc(X)
axis image
figure()

X_int = imread('rectangle.jpg');
X_double = double(X_int);
imwrite(uint8(X_double),'rectangleOutput.jpg')

X_gray= X_double(:,:,1)/3.0 + X_double(:,:,2)/3.0 + X_double(:,:,3)/3.0;
imagesc(uint8(X_gray))
colormap('gray')
axis image

hold on
X_exposed=X_gray+150;
imagesc(uint8(X_exposed))
colormap('gray')
axis image
hold off
figure()