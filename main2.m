clc
clear all 
close all


Image = imread('Hi.tif');
J = imread('IUT.tif');

I = dct2(Image);

DCT = zeros(size(Image));
DCT2 = zeros(size(Image));

[row, col] = size(I);
[ROW, COL] = size(J);

for i=1: 1: ROW
    for j=1: 1: COL
        
        DCT(1+(i-1)*8:i*8, 1+(j-1)*8:j*8) = dct2(Image(1+(i-1)*8:i*8, 1+(j-1)*8:j*8));
        
        a = DCT(4+(i-1)*8, 5+(j-1)*8); 
        b = DCT(5+(i-1)*8, 4+(j-1)*8);
        
        if  a > b && J(i, j) == 0
            
            DCT(4+(i-1)*8, 5+(j-1)*8) = b - 35;
            DCT(5+(i-1)*8, 4+(j-1)*8) = a + 35;
        
        elseif a > b && J(i, j) == 1
            
            DCT(4+(i-1)*8, 5+(j-1)*8) = a + 35;
            DCT(5+(i-1)*8, 4+(j-1)*8) = b - 35;
        
        elseif a < b && J(i, j) == 1
            
            DCT(4+(i-1)*8, 5+(j-1)*8) = b + 35;
            DCT(5+(i-1)*8, 4+(j-1)*8) = a - 35;
        
        elseif a < b && J(i, j) == 0
            
            DCT(4+(i-1)*8, 5+(j-1)*8) = a - 35;
            DCT(5+(i-1)*8, 4+(j-1)*8) = b + 35;
                
        elseif a == b &&  J(i, j) == 0
            
            DCT(5+(i-1)*8, 4+(j-1)*8) = a + 35;
            DCT(4+(i-1)*8, 5+(j-1)*8) = b - 35;
        elseif a == b &&  J(i, j) == 1
            
            DCT(5+(i-1)*8, 4+(j-1)*8) = a - 35;
            DCT(4+(i-1)*8, 5+(j-1)*8) = b + 35;
        end
                
        DCT2(1+(i-1)*8:i*8, 1+(j-1)*8:j*8) = idct2(DCT(1+(i-1)*8:i*8, 1+(j-1)*8:j*8));
    end
end

DCT2 = uint8(DCT2);
imshow(uint8(DCT2));
% DCT = uint8(idct2(DCT));

DCT3 = DCT;

imwrite(DCT2, 'gg.jpg', 'quality', 40);
I = imread('gg.jpg');

K = zeros(size(J));

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

