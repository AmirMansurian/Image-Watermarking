function W_image = embed_proj(I, B, a, W2D, alpha)

   [row, col] = size(I);
   row = row + (B - rem(row, B));
   col = col + (B - rem(col, B));
   I = imresize(I, [row, col]);
   
   Vector_Size = (row*col)/(B*B);
   W1D = zeros(1, Vector_Size);
   W2D = imresize(W2D, [row/B, col/B]);
   [ROW, COL] = size(W2D);
   
   for i=1: 1: ROW
       for j=1: 1: COL
            W1D(1, ((i-1)*COL + j)) = W2D(i, j);
       end
   end
    
    DCT = zeros(row, col);
    DCT2 = zeros(row, col);
    
     for i=1: 1: ROW
        for j=1: 1: COL

            DCT(1+(i-1)*B:i*B, 1+(j-1)*B:j*B) = dct2(I(1+(i-1)*B:i*B, 1+(j-1)*B:j*B));

            c = DCT(a+(i-1)*B, a+1+(j-1)*B); 
            d = DCT(a+1+(i-1)*B, a+(j-1)*B);

            if  c > d && W2D(i, j) == 0

                DCT(a+(i-1)*B, a+1+(j-1)*B) = d - alpha/2;
                DCT(a+1+(i-1)*B, a+(j-1)*B) = c + alpha/2;

            elseif c > d && W2D(i, j) == 1

                DCT(a+(i-1)*B, a+1+(j-1)*B) = c + alpha/2;
                DCT(a+1+(i-1)*B, a+(j-1)*B) = d - alpha/2;

            elseif c < d && W2D(i, j) == 1

                DCT(a+(i-1)*B, a+1+(j-1)*B) = d + alpha/2;
                DCT(a+1+(i-1)*B, a+(j-1)*B) = c - alpha/2;

            elseif c < d && W2D(i, j) == 0

                DCT(a+(i-1)*B, a+1+(j-1)*B) = c - alpha/2;
                DCT(a+1+(i-1)*B, a+(j-1)*B) = d + alpha/2;

            elseif c == d &&  W2D(i, j) == 0

                DCT(a+1+(i-1)*B, a+(j-1)*B) = c + alpha/2;
                DCT(a+(i-1)*B, a+1+(j-1)*B) = d - alpha/2;
            
            elseif c == d &&  W2D(i, j) == 1

                DCT(a+1+(i-1)*B, a+(j-1)*B) = c - alpha/2;
                DCT(a+(i-1)*B, a+1+(j-1)*B) = d + alpha/2;
            end

            DCT2(1+(i-1)*B:i*B, 1+(j-1)*B:j*B) = idct2(DCT(1+(i-1)*B:i*B, 1+(j-1)*B:j*B));
        end
     end

    W_image = uint8(DCT2);
    
    subplot(1, 2, 1)
    imshow(I);
    title(['Original Image' '    PSNR = ' num2str(psnr(I, W_image))]);

    subplot(1, 2, 2)
    imshow(W_image, []);
    title('Watermarked Image');

end