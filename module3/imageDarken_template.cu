#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#include <cuda.h>
#include <cuda_runtime.h>

#include "headers/image.h"

#define TILE_WIDTH 16

#define emax(x, y) ((x) >= (y)) ? (x) : (y)
#define emin(x, y) ((x) <= (y)) ? (x) : (y)

__global__ void imgDarken(int *outputImage, int *inputImage,
			int width, int height)
{
	// Create indexing variables (need 2 dimensional)
	int x = ????;
	int y = ????;

	if (x < width && y < height)
	{
		// Calculate image offset
		int offset = ????;
		outputImage[offset] = emax(inputImage[offset] - 75, 0);
	}
}

int main (int argc, char **argv)
{
	int imageWidth, imageHeight;
	int *hostInputImage, *hostOutputImage;
	int *deviceInputImage, *deviceOutputImage;

	if (argc != 3)
	{
		printf("Usage: ./imageDarken <input-image> <output-image-name>\n");
		exit(1);
	}

	// Read in image and convert to readable format
	read_image_template<int>(argv[1], &hostInputImage, &imageWidth, &imageHeight);

	// Set image size information
	int img_size = imageWidth * imageHeight * sizeof(int);

	// Allocate memory for host image (output)
	hostOutputImage = ????;

	// Allocate memory for images (input and output) on GPU
	????
	
	// Copy host input image to device input image
	????

	// Set kernel dimensions and call kernel
	dim3 dimGrid(????,????);
	dim3 dimBlock(????, ????, 1);
	imgDarken <<< dimGrid, dimBlock >>>(deviceOutputImage, deviceInputImage, imageWidth, imageHeight);

	// Copy resulting image back to host
	????

	// Write image to output file	
	write_image_template<int>(argv[2], hostOutputImage, imageWidth, imageHeight);

	// Free device memory (for input and output image)
	????
	
	// Free host memory (for output image)
	????

	return 0;
}
