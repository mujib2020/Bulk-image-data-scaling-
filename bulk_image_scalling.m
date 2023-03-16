%{

@author: Mujib Chowdhury, PhD 
March 16, 2023
scales images to a range of 0-255 and saves them into another folder in png format

%} 

% Set the input and output folders
input_folder = '.\Data\x_ray_images';
output_folder = ".\Data_scaled\x_ray_images";

% Create the output folder if it doesn't exist
if ~exist(output_folder, 'dir')
    mkdir(".\Data_scaled\x_ray_images");
end

% Get the list of image files in the input folder
image_files = dir(fullfile(input_folder, '*.*g')); % This will list files with extensions .jpg, .jpeg, .png, and .tiff

% Loop through each image file
for k = 1:length(image_files)
    % Read the image
    image_file = fullfile(input_folder, image_files(k).name);
    img = imread(image_file);
    
    % Convert the image to double precision
    img = im2double(img);
    
    % Scale the image to the range [0, 255]
    img = img - min(img(:));
    img = img ./ max(img(:));
    img = uint8(255 * img);
    
    % Save the scaled image to the output folder
    [~, filename, ~] = fileparts(image_file);
    output_file = fullfile(output_folder, [filename '.png']);
    imwrite(img, output_file, 'png');
end
