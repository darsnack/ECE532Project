% Our new background has too many pixels, so we downsample along both
% dimensions.
newBackground = imread('AT3_1m4_03.tif');
newBackground = downsample(downsample(newBackground,2)',2)';

vectorNewBackground = reshape(newBackground,[videoDim1*videoDim2,1]);
[Ux,Sx,Vx] = svd(double(vectorNewBackground),'econ');

U(:,1) = Ux; V(:,1) = ones(numberOfFrames,1);
S_prime = singularValues; S_prime(1) = Sx;

newBackgroundVideo = uint8(reshape(U*diag(S_prime)*V.',[videoDim1,videoDim2,numberOfFrames]));

implay(newBackgroundVideo);