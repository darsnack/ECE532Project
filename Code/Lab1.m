% Importing the video
v = VideoReader('xylophone.mp4');
videoMatrix = v.read;
% Constants pulled from the video
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
flattenedVideo = reshape(greyVideo,[videoDim1*videoDim2,numberOfFrames]);