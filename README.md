# JPEG Ghost Detecting Algorithm

The **JPEG Ghost Detecting Algorithm** is a MATLAB function designed to identify potential JPEG ghosts, which are artifacts introduced in images due to recompression. This algorithm takes an input image and performs a series of operations on it to detect such artifacts. Below is a detailed explanation of the algorithm and its usage.

## Function Signature

```matlab
function diffImages = jpeg_ghosts(file, b, minQ, maxQ, stepQ)
```

### Parameters

- `file`: The filename of the input image in JPEG format.
- `b`: Block size for comparing image regions.
- `minQ`: Minimum JPEG quality factor for the compression.
- `maxQ`: Maximum JPEG quality factor for the compression.
- `stepQ`: Step size to iterate over quality factors.

## Algorithm Overview

1. **Input Image Preparation**: Read the input JPEG image and convert it to double precision.

2. **Output Array Allocation**: Pre-allocate an output cell array to store the difference images.

3. **Iterating Over Quality Factors**: Iterate over a range of quality factors, compress, and decompress the input image.

4. **Difference Image Calculation**: For each quality factor iteration, calculate the difference between the original and compressed images.

5. **Block-wise Difference Calculation**: Divide the images into blocks of size `b x b` and calculate the difference between corresponding blocks in the original and compressed images.

6. **RGB Component Differences**: Calculate the differences for each RGB channel separately.

7. **Sum of Squared Differences**: Sum the squared differences of RGB components to obtain an overall difference value for each block.

8. **Normalize Differences**: Normalize the differences to a range between 0 and 1.

9. **Contrast Enhancement (Optional)**: Apply contrast enhancement techniques (imadjust, histeq) to make the artifacts more visible (optional step).

10. **Store Results**: Store the normalized difference image in the output array for each quality factor iteration.

## Usage

1. Make sure you have MATLAB installed on your system.

2. Copy and paste the provided algorithm into a MATLAB script file (e.g., `jpeg_ghost_detection.m`).

3. Call the `jpeg_ghosts` function with appropriate arguments to detect JPEG ghosts in your image.

```matlab
file = 'input_image.jpg';
b = 8; % Block size
minQ = 10; % Minimum quality factor
maxQ = 90; % Maximum quality factor
stepQ = 10; % Quality factor step
diffImages = jpeg_ghosts(file, b, minQ, maxQ, stepQ);
```

4. The `diffImages` array will contain normalized difference images for each quality factor iteration. You can visualize or analyze these images to identify potential JPEG ghost artifacts.

Please note that while the algorithm provides a general approach to detecting JPEG ghosts, it might require adjustments based on specific use cases or image characteristics. Additionally, the contrast enhancement steps are optional and can be modified or removed based on your preferences.
