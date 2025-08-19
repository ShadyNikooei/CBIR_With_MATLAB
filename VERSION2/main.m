% shady nikooei

function main
% in main test CBIR System(tatol work run in this script): extract features and find top 3 similar images
    clear
    clc
    
    dataset_folder = "E:\shady\term6\Image Process\06_Nikooei_WB_2_403\ex47\archive(2)\dataset\test_set";
    query_folder = "E:\shady\term6\Image Process\06_Nikooei_WB_2_403\ex47\archive(2)\dataset";

    % directiory for save dataset resized
    output_folder = "E:\shady\term6\Image Process\06_Nikooei_WB_2_403\ex47\archive(2)\dataset\test_set_resized";
    
    % check exist of dataset resized
    if exist(output_folder, 'dir')
        disp("All before images resized and saved to output folder.");
    else
        resize_dataset(dataset_folder, output_folder, [1024,1024]);
    end

    % call CBIR_dataBase for extract features from images of dataSet
    [features_DS , size] = CBIR_dataBase(output_folder);
    
    % call CBIR_Query for extraction features from query image
    features_Q = CBIR_Query(query_folder);
    
    % Preallocate array for distances
    distances = zeros(1, size);

    % finding the most similar image to a query
    for i=1:size

        distances(i) = pdist2(features_Q(:)',features_DS(i).features(:)','euclidean');
        %distances(i) = norm(features_Q - features_DS(i).features); % Euclidean distance

    end
     % Sort distances for get the top 3 most similar images
    [~, sortedIdx] = sort(distances);
    top3Idx = sortedIdx(1:3);

    % Display 
    for j = 1:3
        figure
        imshow(features_DS(top3Idx(j)).name);
        title(['Rank ' num2str(j)]);
    end

   

    
