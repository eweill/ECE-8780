#include <cuda.h>
#include "stdio.h" 
#include "math.h"
#include "stdlib.h"
#include "string.h"

#define BUFFER 512

// Function Declaration
// Function Definition
/*NOTE: You MAY or MAY NOT REQUIRE ALL of the functions below. */

void read_image(char *name, unsigned char **image, int *im_width, int *im_height)
{
	FILE *fip;
	char buf[BUFFER];
	char *parse;
	int im_size;
	
	fip=fopen(name,"rb");
	if(fip==NULL)
	{
		fprintf(stderr,"ERROR:Cannot open %s\n",name);
		exit(0);
	}
	fgets(buf,BUFFER,fip);
	do
	{
		fgets(buf,BUFFER,fip);
	}
	while(buf[0]=='#');
	parse=strtok(buf," ");
	(*im_width)=atoi(parse);

	parse=strtok(NULL,"\n");
	(*im_height)=atoi(parse);

	fgets(buf,BUFFER,fip);
	parse=strtok(buf," ");
	
	im_size=(*im_width)*(*im_height);
	(*image)=(unsigned char *)malloc(sizeof(unsigned char)*im_size);
	fread(*image,1,im_size,fip);
	
	fclose(fip);
}


/*Use this function to read an image */

template<class T>
void read_image_template(char *name, T **image, int *im_width, int *im_height)
{
	unsigned char *temp_img; 

	read_image(name, &temp_img, im_width, im_height);
	
	cudaMallocHost((void**)image,sizeof(T)*(*im_width)*(*im_height));
	
	for(int i=0;i<(*im_width)*(*im_height);i++)
	{
		(*image)[i]=(T)temp_img[i];
	}
	free(temp_img);
}

void write_image(char *name, unsigned char *image, int im_width, int im_height)
{
	FILE *fop; 
	int im_size=im_width*im_height;
	
	fop=fopen(name,"w+");
	fprintf(fop,"P5\n%d %d\n255\n",im_width,im_height);
	fwrite(image,sizeof(unsigned char),im_size,fop);
	
	fclose(fop);
}

template<class T>
void write_image_template(char *name, T *image, int im_width, int im_height)
{
	unsigned char *temp_img=(unsigned char*)malloc(sizeof(unsigned char)*im_width*im_height);
	for(int i=0;i<(im_width*im_height);i++)
	{
		temp_img[i]=(unsigned char)image[i];
	}
	write_image(name,temp_img,im_width,im_height);
	
	free(temp_img);
}

template<class T>
void add_padding(T **image,int width, int height)
{
        T *ip_img=*image;
        T *op_img;
	cudaMallocHost(&op_img,sizeof(T)*(width+2)*(height+2));

        for(int i=0;i<height;i++)
        {
                for(int j=0;j<width;j++)
                {
                        op_img[(i+1)*(width+2)+j+1]=ip_img[i*width+j];
                }
        }

        //Copy the first and last row
        for(int i=1;i<(width+1);i++)
        {
                op_img[i]=op_img[width+2+i];
                op_img[(height+1)*(width+2)+i]=op_img[height*(width+2)+i];
        }
        //Copy the first and last column
        for(int i=0;i<height+2;i++)
        {
                op_img[i*(width+2)]=op_img[i*(width+2)+1];
                op_img[i*(width+2)+width+1]=op_img[i*(width+2)+width];
        }
        cudaFreeHost(*image);
        (*image)=op_img;
}

template<class T>
void remove_padding(T **image,int width, int height)
{
        T *ip_img=*image;
        T *op_img;
	cudaMallocHost(&op_img,sizeof(T)*width*height);

        for(int i=0;i<height;i++)
        {
                for(int j=0;j<width;j++)
                {
                        op_img[i*width+j]=ip_img[(i+1)*(width+2)+(j+1)];
                }
        }
        cudaFreeHost((*image));
        (*image)=op_img;
}	
