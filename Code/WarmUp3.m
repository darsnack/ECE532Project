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

% Set our compression to rank 20 (change to 50 if desired)
k = 20;

% Compress the video frame by frame
compressed_video = zeros(video_dim1, video_dim2, num_frames);
for i = 1:num_frames
    % Compute the SVD of the frame
    [U, S, V] = svd(gray_video(:, :, i));
    s = diag(S);
    [m, n] = size(S);
    % Zero out the > k singular values of A
    S_prime = diag(s(1:k));
    S_prime = [S_prime zeros(k, n - k); ...
        zeros(m - k, k) zeros(m - k, n - k)];
    % Reconstruct the frame matrix
    compressed_video(:, :, i) = U * S_prime * V';
end

% Play the results
implay(uint8(compressed_video));