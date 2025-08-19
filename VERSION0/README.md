# CBIR System in MATLAB

This project implements a **Content-Based Image Retrieval (CBIR)** system in MATLAB.  
The system extracts features from images, compares them to a query image, and returns the **top-3 most similar images** from the dataset.

----

## Features

- Extracts 7 features (intensity and morphological-based) from each image:
  - Mean intensity
  - Standard deviation of intensity
  - Minimum intensity
  - Maximum intensity
  - Area (sum of pixel values)
  - Centroid X, Centroid Y (from morphological analysis)
- Divides each image into 16 equal blocks and extracts features per block.
- Computes similarity between query and dataset images using **Euclidean distance**.
- Returns and displays the **Top-3 most similar images** to the query image.

---

## Dataset

This project uses the **Corel Image Dataset** available on Kaggle:  
[Download dataset](https://www.kaggle.com/datasets/elkamel/corel-images)

---

## Usage

1. Place your dataset and query images in the respective folders.
2. Run the `main.m` script in MATLAB.
3. The top-3 most similar images to the query will be displayed automatically.

---

## Author

**Shady Nikooei**  
Digital Image Processing  
CBIR_Using_MATLAB
