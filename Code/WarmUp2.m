% Read in all frames of built-in MATLAB video data
v = VideoReader('xylophone.mp4');
video_matrix = v.read;

% Get the dimensions of the video data
num_frames = v.Duration * v.FrameRate;
video_dim1 = size(video_matrix, 1);
video_dim2 = size(video_matrix, 2);

% Initialize a 3D matrix to store the grayscale video data
gray_video = zeros(video_dim1, video_dim2, num_frames);

% Convert from RGB to grayscale, frame by frame
for i = 1:num_frames
    gray_video(:, :, i) = rgb2gray(video_matrix(:, :, :, i));
end

% Play the results
implay(uint8(gray_video));