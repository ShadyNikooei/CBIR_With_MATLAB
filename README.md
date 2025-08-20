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

## Dataset
This project uses the **Corel Image Dataset** available on Kaggle:  
[Download dataset](https://www.kaggle.com/datasets/elkamel/corel-images

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

