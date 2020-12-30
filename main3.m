clc
clear all 
close all


Image = imread('lena.bmp');
J = imread('iut5.bmp');
J = imbinarize(J);

Watermarked = embed_proj(Image, 8, 4, J, 70);

attack_proj(Watermarked, 8, 4, J);

