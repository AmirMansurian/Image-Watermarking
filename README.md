# Image Watermarking

#### Watermarking a logo in an Image with bit embeding in DCT domain
##### we have an imgae and a binary image named 'logo' and we want embed logo in the main image. after embeding save image as jpeg format with 60, 80, 100 percent of quality and extract embeded logo from jpeg images to perform jpeg attack on watermarked image. at last calculate PSNR value between main image and watermarked image (Transparency) and NC between main logo and extracted logo (Robustness).
##### When we save image as jpeg because of Quantizatoin that happens in jpeg commpression numbers of DCT coeeficients are set to 0 so we lose embeded bits in watermarked image. so we use ALPHA Amplification coefficient to preventing lossing bits. after expriments on different values of ALPHA i get the best results in AlPHA = 38  for 60% of jpeg quality. so after we get DCT transformation from image we use two coefficients for example (4,5) and (5,4) and we compare these values. if (4,5) is bigger, it means watermarked bit in this block is 1 and if (5,4) is bigger it means that embedded bit is 0. so according to the logo and comparison between two specified coeeficients we replace these two coefficients and we increase difference between these coeeficients to ALPHA. for more security first we randomize logo with specific Key and after extraction decrypt logo with the Key.

##### also we can calculate ALPHA adaptively for each blocks of image. blocks with higher pixels value and higher edges are less important for human eyes so we use canny filter to detect edges of each blocks of image and calculate ALPHA for each block according to it's brighness and edges.

#### 
####
##### results for ALPHA  = 38 and jpeg 60% is shown below . full results are shown for ALPHA = 38, Block size = 8, coeeficients (4,5) and (5,4), Randomization key = 19 on Lena image:
##

![Alt Text](https://raw.githubusercontent.com/AmirMansurian/Image-Watermarking/master/PSNR.png)
![Alt Text](https://raw.githubusercontent.com/AmirMansurian/Image-Watermarking/master/NC.png)

##

| JPEG quality = 100 |   0.91518     |  1     | 1 |  1  |
| ------  | ------ | ------ | ------ | -------|
| JPEG quality = 80  |0.57844 | 0.62628 | 0.98693  | 1 |
| JPEG quality = 60  | 0.48852 | 0.49235 | 0.54082 | 0.94101|
|   | ALPHA = 0 | ALPHA = 4  | ALPHA = 19 | ALPHA = 38 |
|PSNR | 47.171 | 45.5425 | 40.3251 | 35.9352 |





