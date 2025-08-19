% shady nikooei

function [features_dataSet, sizeOfDataSet] = CBIR_dataBase (dataset_folder)
% This a function can extract features of images in a dataset and save them
% in an structure
% Input is the directory address from dataSet
% Output is an structure of features that extracted from images in dataSet

%%%% you can download this dataset in : https://www.kaggle.com/datasets/elkamel/corel-images
    
    imageFile = dir(fullfile(dataset_folder,'*.jpg')); % sort file in folder
    numImage = length(imageFile); % number of files
    
    % structure that save features
    fetureMtx(1,numImage) = struct('name','', 'features', []);
    
    sizeOfDataSet = numImage;
    
    for i=1:numImage
        
       % preallocation (zero matrix) for save features
       features = zeros(9,16);
       
       fetureMtx(i).name = fullfile(dataset_folder, imageFile(i).name);

       img = imread(fullfile(dataset_folder, imageFile(i).name));
       img = rgb2gray(img);
        
       % divide image to 16 parts for compute features
       [rows, colns, ~] = size(img);
       block_rows = floor(rows/4);
       block_colns = floor(colns/4);
    
       for j=0:3
           for k=0:3
    
               % set block of each part
               start_row = j*block_rows+1;
               stop_row = (j+1)*block_rows;
               start_cln = k*block_colns+1;
               stop_cln = (k+1)*block_colns;
    
               part_img = img(start_row:stop_row,start_cln:stop_cln);
               
               % find column
               part_num = j*4 + k + 1;
               
               % extract features
               features(1,part_num) = mean2(part_img); % mean2 -> row:1
               features(2,part_num)= std2(part_img);  % std2 -> row:2
               features(3,part_num) = min(part_img(:)); % minIntensity -> row:3
               features(4,part_num) = max(part_img(:)); % maxIntensity -> row:4
               features(5,part_num) = sum(part_img(:)); % area -> row:5
               
               % entropy and energy
               features(6,part_num) = entropy(mat2gray(part_img)); % entropy
               features(7,part_num) = sum(double(part_img(:)).^2); % energy

               % morphological operations
               part_img = imbinarize(part_img);
               part_img = ~part_img;
               part_img = imfill(part_img,"holes");
               part_img = bwareaopen(part_img,10);
               se = strel('disk', 10);
               part_img = imclose(part_img,se);
               
                % Region properties: centroid
               states = regionprops(part_img,'Centroid');
               if ~isempty(states)
                   allCentroids = cat(1, states.Centroid); % Collect all centroids
                   x = mean(allCentroids(:,1));            % Mean X
                   y = mean(allCentroids(:,2));            % Mean Y
               else
                   x = 0;
                   y = 0;
               end
               features(8,part_num) = x; % Centroid X
               features(9,part_num) = y; % Centroid Y;
           end
       end
       % Save features into struct
       fetureMtx(i).features = features;
    end

    features_dataSet = fetureMtx;




