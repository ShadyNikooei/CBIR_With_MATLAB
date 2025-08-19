function resize_dataset(input_folder, output_folder, target_size)
% This function resizes all images in a dataset to the same size.
%
% input_folder: path to original dataset
% output_folder: path to save resized images
% target_size: desired output size (e.g., [256 256])

    % Create output folder if it doesn't exist
    if ~exist(output_folder, 'dir')
        mkdir(output_folder);
    end

    % Get list of all JPG images
    imageFiles = dir(fullfile(input_folder, '*.jpg'));

    % Loop through each image
    for i = 1:length(imageFiles)
        % Read image
        img = imread(fullfile(input_folder, imageFiles(i).name));

        % Resize directly to the target size
        resized = imresize(img, target_size);

        % Save resized image
        imwrite(resized, fullfile(output_folder, imageFiles(i).name));
    end

    disp("All images resized and saved to output folder.");
end
