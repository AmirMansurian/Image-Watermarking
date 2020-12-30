clc
clear all 
close all


Image = imread('lena.bmp');
J = imread('iut5.bmp');
J = imbinarize(J);

DCT2 = embed_proj(Image, 8, 4, J, 70);

imwrite(DCT2, 'gg.jpg', 'quality', 60);
I = imread('gg.jpg');
I = DCT2;
DCT = zeros(size(I));
[ROW, COL] = size(I);
ROW = ROW/8;
COL = COL/8;

K = zeros(ROW, COL);

for i=1: 1: ROW
    for j=1: 1: COL
        
        DCT(1+(i-1)*8:i*8, 1+(j-1)*8:j*8) = dct2(I(1+(i-1)*8:i*8, 1+(j-1)*8:j*8));
        
        a = DCT(4+(i-1)*8, 5+(j-1)*8); 
        b = DCT(5+(i-1)*8, 4+(j-1)*8);
        
        if  a > b
            
            K(i, j) = 1;
        elseif b > a
            
            K(i, j) = 0;
        end
    end
end

imshow(K);


