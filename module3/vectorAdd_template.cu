#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#include <cuda.h>
#include <cuda_runtime.h>

// CUDA kernel, Each thread takes care of one element of c
__global__ void vecAdd(double *a, double *b, double *c, int n)
{
	// Get global thread ID
	int idx = ????;

	// Make sure not to go out of bounds
	if (idx < n)
		????
}

int main (int argc, char **argv)
{
	// Size of vectors for addition
	int n = 10000000;

	// Host vectors
	double *h_a, *h_b, *h_c, *h_h;

	// Device vectors
	double *d_a, *d_b, *d_c;

	// Size in bytes for each vector
	size_t bytes = n*sizeof(double);

	// Allocate memory for each vector on host (h_a(b)(c)(h))
	????

	// Allocate memory for each vector on GPU (d_a(b)(c))
	????

	// Initialize all vectors on host
	int i;
	for (i = 0 ; i < n ; i++)
	{
		h_a[i] = sin(i) * sin(i);
		h_b[i] = cos(i) * cos(i);
	}

	// Copy host vectors to device
	????
		
	int blockSize, gridSize;
	// Number of threads in each thread block, number of thread blocks in grid
	blockSize = 1024;
	gridSize = (int)ceil((float)n/blockSize);

	// Execute on CPU and GPU
	clock_t cpu_start, cpu_end;
	clock_t gpu_start, gpu_end;
	cpu_start = clock();
	for (i = 0 ; i < n ; i++)
	{
		h_h[i] = h_a[i] + h_b[i];
	}
	cpu_end = clock();
	gpu_start = clock();

	// Kernel Call
	????

	gpu_end = clock();

	// Copy array back to host
	????

	// Sum up vector c and print result divided by n
	double sum = 0;
	for ( i = 0 ; i < n ; i++ )
		sum += h_c[i];
	printf("final:result: %f\n", sum/n);

	double cpu_time = ((double)cpu_end - cpu_start)/CLOCKS_PER_SEC;
	double gpu_time = ((double)gpu_end - gpu_start)/CLOCKS_PER_SEC;

	printf("CPU Time: %f\nGPU Time: %f\n", cpu_time, gpu_time);

	// Release device memory
	????

	// Release host memory
	????

	return 0;
}
