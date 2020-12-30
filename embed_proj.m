function [W_image, W1D]= embed_proj(I, B, a, W2D, alpha)

   [row, col] = size(I);
    Vector_Size = (row*col)/(B*B);

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



end