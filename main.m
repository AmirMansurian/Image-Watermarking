clc
clear all 
close all


I = imread('Hi.tif');
J = imread('IUT.tif');


[row, col] = size(I);
[ROW, COL] = size(J);

for i=1: 1: ROW
    for j=1: 1: COL
        
        a = I(4+(i-1)*8, 5+(j-1)*8); 
        b = I(5+(i-1)*8, 4+(j-1)*8);
        
        if  (a > b && J(i, j) == 0)  || (a < b && J(i, j) == 1)
            
            I(4+(i-1)*8, 5+(j-1)*8) = b;
            I(5+(i-1)*8, 4+(j-1)*8) = a;
        elseif a == b &&  J(i, j) == 0
            
            I(5+(i-1)*8, 4+(j-1)*8) = a + 1;
        elseif a == b &&  J(i, j) == 1
            
            I(4+(i-1)*8, 5+(j-1)*8) = b + 1;
        end
    end
end

K = zeros(size(J));

for i=1: 1: ROW
    for j=1: 1: COL
        
        a = I(4+(i-1)*8, 5+(j-1)*8); 
        b = I(5+(i-1)*8, 4+(j-1)*8);
        
        if  a > b
            
            K(i, j) = 1;
        elseif b > a
            
            K(i, j) = 0;
        end
    end
end

imshow(K);


