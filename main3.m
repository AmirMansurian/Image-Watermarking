clc
clear all 
close all


Image = imread('lena.bmp');
J = imread('iut5.bmp');
J = imbinarize(J);

[Watermarked, DCT, arr] = main_Adaptive(Image, 8, 4, J, 0.8);
%[Watermarked, DCT] = embed_proj(Image, 12, 6, J, 38);

DCT2 = attack_proj(Watermarked, 12, 6, J);

