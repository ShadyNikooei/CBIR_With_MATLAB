% shady nikooei

function main
% in main test CBIR System(tatol work run in this script): extract features and find top 3 similar images
    clear
    clc
    
    dataset_folder = "E:\shady\term6\Image Process\06_Nikooei_WB_2_403\ex47\archive(2)\dataset\test_set";
    query_folder = "E:\shady\term6\Image Process\06_Nikooei_WB_2_403\ex47\archive(2)\dataset";
    
    output_folder = "E:\shady\term6\Image Process\06_Nikooei_WB_2_403\ex47\archive(2)\dataset\test_set_resized";

    if exist(output_folder, 'dir')
        disp("All before images resized and saved to output folder.");
    else
        resize_dataset(dataset_folder, output_folder, [1024,1024]);
    end

    % call CBIR_dataBase for extract features from images of dataSet
    [features_DS , size] = CBIR_dataBase(output_folder);
    
    % call CBIR_Query for extraction features from query image
    [features_Q , features_H]= CBIR_Query(query_folder);
    
    % Preallocate array for distances
    distances = zeros(1, size);
    distances_H = zeros(1, size);

    % Convert features into row vectors for pdist2
    fQ = features_Q(:)'; 
    fQ = (fQ - mean(fQ)) / std(fQ); % z-score normalization

    % HOG query vector: concatenate all HOG blocks
    fQh = double(cell2mat(features_H(:))');
    %fQh = (fQh - mean(fQh)) / std(fQh);
    fQh = fQh / norm(fQh);


    % finding the most similar image to a query
    for i=1:size
        
        % Statistical features
        fDS = double(features_DS(i).features(:)');
        fDS = (fDS - mean(fDS)) / std(fDS); % z-score normalization

        % HOG features
        fDH = double(cell2mat(features_DS(i).featuresHOG(:))');
        %fDH = (fDH - mean(fDH)) / std(fDH);
        fDH = fDH / norm(fDH);

        % Make vectors equal length by padding with zeros
        % len = max(length(fQh), length(fDH));
        % fQh(len) = 0;
        % fDH(len) = 0;
        
        fQh = double(fQh(:)');  
        fDH = double(fDH(:)');
        
        
        % Cosine distance 
        distances(i) = pdist2(fQ, fDS,'euclidean');
        distances_H(i) = pdist2(fQh ,fDH , 'cosine');

        % distances(i) = norm(features_Q - features_DS(i).features); % Euclidean distance
    end

    
    % Combine distances with weighting
    w_stat = 0.6;
    w_hog = 0.4;
    combined_distance = w_stat*distances + w_hog*distances_H;

    % Top-3 images based on both features
    [~, top3Idx_dis] = sort(combined_distance);
    top3Idx_dis = top3Idx_dis(1:5);

    % Display 
    for j = 1:5
        figure
        imshow(features_DS(top3Idx_dis(j)).name);
        title(['Rank ' num2str(j)]);
    end

   

    