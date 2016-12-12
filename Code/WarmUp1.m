clear variables, close all

% Read in image data and display it
A = csvread('bucky.csv');
figure(1); imagesc(A,[0 1])
colormap gray; axis image; axis off

% Compute the SVD of A
[U, S, V] = svd(A);
s = diag(S);

% Set our compression to rank 50
k = 50;

figure(2);
[m, n] = size(S);
% Zero out the > k singular values of A
S_prime = diag(s(1:k));
S_prime = [S_prime zeros(k, n - k); ...
    zeros(m - k, k) zeros(m - k, n - k)];
% Reconstruct the image matrix and display it
A_prime = U * S_prime * V';
imagesc(A_prime,[0 1]);
title(['Compression with k = ', num2str(k)]);
colormap gray; axis image; axis off;