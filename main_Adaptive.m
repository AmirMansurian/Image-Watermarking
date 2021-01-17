function [W_image, WW, arr] = main_Adaptive(I, B, a, W2D, alpha)

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
    
    arr = zeros(1, ROW*COL);
    count = 1;
    
     for i=1: 1: ROW
        for j=1: 1: COL

            DCT(1+(i-1)*B:i*B, 1+(j-1)*B:j*B) = dct2(I(1+(i-1)*B:i*B, 1+(j-1)*B:j*B));

            c = DCT(a+(i-1)*B, a+1+(j-1)*B); 
            d = DCT(a+1+(i-1)*B, a+(j-1)*B);
            f = abs(DCT(5+(i-1)*B, 5+(j-1)*B)) + abs(DCT(4+(i-1)*B, 4+(j-1)*B)); 
            e = DCT(1+(i-1)*B, 1+(j-1)*B);
            
            Embed =  sqrt(e)*alpha + f*(1-alpha) - abs(c - d);

            
            arr(1, count) = Embed;
            count = count + 1;
            
            if  c > d && W2D(i, j) == 0

                DCT(a+(i-1)*B, a+1+(j-1)*B) = d - Embed;
                DCT(a+1+(i-1)*B, a+(j-1)*B) = c + Embed;

            elseif c > d && W2D(i, j) == 1

                DCT(a+(i-1)*B, a+1+(j-1)*B) = c + Embed;
                DCT(a+1+(i-1)*B, a+(j-1)*B) = d - Embed;

            elseif c < d && W2D(i, j) == 1

                DCT(a+(i-1)*B, a+1+(j-1)*B) = d + Embed;
                DCT(a+1+(i-1)*B, a+(j-1)*B) = c - Embed;

            elseif c < d && W2D(i, j) == 0

                DCT(a+(i-1)*B, a+1+(j-1)*B) = c - Embed;
                DCT(a+1+(i-1)*B, a+(j-1)*B) = d + Embed;

            elseif c == d &&  W2D(i, j) == 0

                DCT(a+1+(i-1)*B, a+(j-1)*B) = c + Embed;
                DCT(a+(i-1)*B, a+1+(j-1)*B) = d - Embed;
            
            elseif c == d &&  W2D(i, j) == 1

                DCT(a+1+(i-1)*B, a+(j-1)*B) = c - Embed;
                DCT(a+(i-1)*B, a+1+(j-1)*B) = d + Embed;
            end

            DCT2(1+(i-1)*B:i*B, 1+(j-1)*B:j*B) = idct2(DCT(1+(i-1)*B:i*B, 1+(j-1)*B:j*B));
        end
     end

    W_image = uint8(DCT2);
    WW = DCT;
    
    subplot(1, 2, 1)
    imshow(I);
    title(['Original Image' '    PSNR = ' num2str(psnr(I, W_image))]);

    subplot(1, 2, 2)
    imshow(W_image, []);
    title('Watermarked Image');

end