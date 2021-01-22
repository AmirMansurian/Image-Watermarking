clc
clear all 
close all


Image = imread('lena.bmp');
J = imread('iut5.bmp');
J = imbinarize(J);

%Watermarked = main_Adaptive(Image, 8, 4, J, 19, 38);
Watermarked = embed_proj(Image, 8, 4, J, 19, 38);

attack_proj(Watermarked, 8, 4, 19, J);

