clc
clear all 
close all


Image = imread('lena.bmp');
J = imread('iut5.bmp');
J = imbinarize(J);

%[Watermarked, DCT, arr] = main_Adaptive(Image, 8, 4, J, 0.2);
arr = zeros(1, 100);
nc = zeros(1, 100);
mse = zeros(1, 100);

for i=1: 1: 100
    [Watermarked, DCT] = embed_proj(Image, 10, 5, J, i);
    mse(1, i) = MSE(Image, Watermarked);
    [DCT2, nc(1, i)] = attack_proj(Watermarked, 10, 5, J);
    arr(1, i) = nc(1, i)*mse(1, i);
end


mse = (mse-min(mse)) / (max(mse)-min(mse));
nc = (nc-min(nc)) / (max(nc)-min(nc));
for i=1: 1: 100
     arr(1, i) = nc(1, i)/mse(1, i);
end

