% shady nikooei

function [features_dataSet, sizeOfDataSet] = CBIR_dataBase (dataset_folder)
% This a function can extract features of images in a dataset and save them
% in an structure
% Input is the directory address from dataSet
% Output is an structure of features that extracted from images in dataSet

%%%% you can download this dataset in : https://www.kaggle.com/datasets/elkamel/corel-images
    
    imageFile = dir(fullfile(dataset_folder,'*.jpg')); % sort file in folder
    numImage = length(imageFile); % number of files
   
    % Preallocate structure for save dataset features
    featureMtx(1,numImage) = struct('name','', 'features', [], 'featuresHOG', []);

    
    sizeOfDataSet = numImage;
    
    for i=1:numImage
        
       % preallocation (zero matrix) for save features
       features = zeros(12,16);
       
       % Preallocate cell array for HOG features of each block
       featuresHOG = cell(1,16);

       featureMtx(i).name = fullfile(dataset_folder, imageFile(i).name);

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
               
               % morphological operations
               part_img_b = imbinarize(part_img);
               part_img_b = ~part_img_b;
               part_img_b = imfill(part_img_b,"holes");
               part_img_b = bwareaopen(part_img_b,10);
               se = strel('disk', 10);
               part_img_b = imclose(part_img_b,se);
               
                % Region properties: centroid
               states = regionprops(part_img_b,'Centroid');
               if ~isempty(states)
                   allCentroids = cat(1, states.Centroid); % Collect all centroids
                   x = mean(allCentroids(:,1));            % Mean X
                   y = mean(allCentroids(:,2));            % Mean Y
               else
                   x = 0;
                   y = 0;
               end
               features(6,part_num) = x; % Centroid X -> row:6
               features(7,part_num) = y; % Centroid Y -> row:7

               % Compute the Gray-Level Co-occurrence Matrix (GLCM) for the image block
               % 'Offset' specifies 4 directions: horizontal, diagonal, vertical, anti-diagonal
               offsets = [0 1; -1 1; -1 0; -1 -1]; 
               glcm = graycomatrix(part_img, 'Offset', offsets, 'Symmetric', true);

               % Extract statistical properties from the GLCM
               % Properties: Contrast, Correlation, Energy, and Homogeneity
               statsGLCM = graycoprops(glcm, {'Contrast','Correlation','Energy','Homogeneity'});


               % Aggregate the features by taking the mean across all directions
               % Result = a single 1x4 feature vector for image block
               glcmFeatures = [mean(statsGLCM.Contrast), mean(statsGLCM.Correlation),mean(statsGLCM.Energy),...
                    mean(statsGLCM.Homogeneity)];
                
               % store each feature separately (row 8-11)
               features(8,part_num)  = mean(glcmFeatures(1)); % Contrast
               features(9,part_num)  = mean(glcmFeatures(2)); % Correlation
               features(10,part_num) = mean(glcmFeatures(3)); % Energy
               features(11,part_num) = mean(glcmFeatures(4)); % Homogeneity
               
               % HOG features
               [hogFeature, ~] = extractHOGFeatures(part_img,'CellSize',[8 8]);
               featuresHOG{part_num} = hogFeature;

           end
       end
       % Save features into struct
       featureMtx(i).features = features;
       featureMtx(i).featuresHOG = featuresHOG;
    end

    features_dataSet = featureMtx;




