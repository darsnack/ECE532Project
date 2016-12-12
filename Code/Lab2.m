% Econ svd is required here, unless you like matrices that are around 50 GB
% total stored on your computer.
[U,S,V] = svd(double(flattenedVideo),'econ');

% Reconstructing the video
reconstructedVideo = uint8(reshape(U*S*V',[videoDim1,videoDim2,numberOfFrames]));

% Find a low-rank approximation
singularValues = diag(S);
largeSVs = singularValues;
largeSVs(7:end) = 0;

% Recreate the videos. Use implay() to play them back in MATLAB
largeSVVideo = uint8(reshape(U*diag(largeSVs)*V.',[videoDim1,videoDim2,numberOfFrames]));