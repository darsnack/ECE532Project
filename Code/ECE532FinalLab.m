% Standard video that all (as far as I can tell) MATLAB distributions have
% these days
v = VideoReader('xylophone.mp4');
videoMatrix = v.read;
% Constants
numberOfFrames = v.Duration*v.FrameRate;
videoDim1 = size(videoMatrix,1);
videoDim2 = size(videoMatrix,2);

greyVideo = zeros(videoDim1, videoDim2, numberOfFrames);

% Convert from rgb video to gray video, just as a matter of course
for ii=1:numberOfFrames
    greyVideo(:,:,ii) = rgb2gray(videoMatrix(:,:,:,ii));
end

% implay(uint8(greyVideo));

% Flatten the video in the standard way with reshape
flattenedVideo = reshape(greyVideo,[videoDim1*videoDim2,141]);

% Econ svd is required here, unless you like matrices that are around 50 GB
% total stored on your computer. A good question to ask in the prep/lab -
% why do we have to use econ here? Does it make a difference?
[U,S,V] = svd(double(flattenedVideo),'econ');

% Pull out large and small singular values to play with them.
singularValues = diag(S);
largeSVs = singularValues;
largeSVs(7:end) = 0;

smallSVs = singularValues;
smallSVs(1:6) = 0;

% Note: implay only works like you think it should when you use uint8
% values. It reads doubles as a greyscale gradient from 0 to 1, which
% causes problems.

% Recreate the videos. Use implay() to play them back in MATLAB
largeSVVideo = uint8(reshape(U*diag(largeSVs)*V.',[videoDim1,videoDim2,numberOfFrames]));
smallSVVideo = uint8(reshape(U*diag(smallSVs)*V.',[videoDim1,videoDim2,numberOfFrames]));

% What's the best rank-1 approximation to a video? Here's a kind of PCA
% thing. 
singleSV = singularValues;
singleSV(2:end) = 0;
topSVVideo = uint8(reshape(U*diag(singleSV)*V.',[videoDim1,videoDim2,numberOfFrames]));