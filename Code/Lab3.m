% Zero out only the largest singular values and examine the results.
smallSVs = singularValues;
smallSVs(1:5) = 0;

smallSVVideo = uint8(reshape(U*diag(smallSVs)*V.',[videoDim1,videoDim2,numberOfFrames]));

% What's the best rank-1 approximation to a video? A constant image!
singleSV = singularValues;
singleSV(2:end) = 0;
topSVVideo = uint8(reshape(U*diag(singleSV)*V.',[videoDim1,videoDim2,numberOfFrames]));