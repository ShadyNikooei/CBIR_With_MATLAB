# CBIR System in MATLAB

This project implements a **Content-Based Image Retrieval (CBIR)** system in MATLAB.  
The system extracts features from images, compares them to a query image, and returns the **top-3 most similar images** from the dataset.  

---

## Features
- Extracts 9 features (intensity, morphological, and texture-based) from each image:
  - Mean intensity  
  - Standard deviation of intensity  
  - Minimum intensity  
  - Maximum intensity  
  - Area (sum of pixel values)  
  - Entropy (texture feature)  
  - Energy (texture feature)  
  - Centroid X, Centroid Y (from morphological analysis)  
- Divides each image into 16 equal blocks and extracts features per block.  
- Computes similarity between query and dataset images using **Euclidean distance** via `pdist2`.  
- Includes a separate MATLAB script to **resize dataset and query images** before feature extraction.  
- Returns and displays the Top-3 most similar images to the query.  

---

## Project Structure
```
CBIR_Project/
  main.m              # Main script (runs the whole CBIR system)
  CBIR_dataBase.m     # Extracts and stores features from dataset images
  CBIR_Query.m        # Extracts features from query image
  resize_dataset.m    # Script/function for resizing images
  README.md           # Project description
```

---

## Dataset
This project uses the **Corel Image Dataset** available on Kaggle:  
[Download dataset](https://www.kaggle.com/datasets/elkamel/corel-images)

Place your dataset inside a folder, for example:
```
dataset/
    test_set/        # images for the database
    query_set/       # query images
```

Update the dataset and query folder paths in `main.m`:
```matlab
dataset_folder = "path_to_your_dataset/test_set";
query_folder   = "path_to_your_dataset/query_set";
```

---

## Example Output
- Input query: `query.jpg`  
- Returned results:  
  - Rank 1: Most similar image  
  - Rank 2: Second most similar  
  - Rank 3: Third most similar  

---

## Author
Shady Nikooei  
Digital Image Processing

