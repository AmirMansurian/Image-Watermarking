function attack_proj( W_image, B, a, K, W2D)

    imwrite(W_image, 'W_image100.jpg', 'quality', 100);
    imwrite(W_image, 'W_image80.jpg', 'quality', 80);
    imwrite(W_image, 'W_image60.jpg', 'quality', 60);
    
    Image100 = imread('W_image100.jpg');
    Image80 = imread('W_image80.jpg');
    Image60 = imread('W_image60.jpg');
    
    DCT100 = zeros(size(W_image));
    DCT80 = zeros(size(W_image));
    DCT60 = zeros(size(W_image));
    
    [ROW, COL] = size(W_image);
    ROW = ROW - rem(ROW, B);
    COL = COL - rem(COL, B);
    ROW = ROW/B;
    COL = COL/B;
    W2D = imresize(W2D, [ROW, COL]);
    
    W1D100 = zeros(1, ROW*COL);
    W1D80 = zeros(1, ROW*COL);
    W1D60 = zeros(1, ROW*COL);
    W1D = zeros(1, ROW*COL);
    
    for i=1: 1: ROW
       for j=1: 1: COL
            W1D(1, ((i-1)*COL + j)) = W2D(i, j);
       end
   end
   

    Extracted100 = zeros(ROW, COL);    
    Extracted80 = zeros(ROW, COL);
    Extracted60 = zeros(ROW, COL);

    for i=1: 1: ROW
        for j=1: 1: COL

            DCT100(1+(i-1)*B:i*B, 1+(j-1)*B:j*B) = dct2(Image100(1+(i-1)*B:i*B, 1+(j-1)*B:j*B));
            DCT80(1+(i-1)*B:i*B, 1+(j-1)*B:j*B) = dct2(Image80(1+(i-1)*B:i*B, 1+(j-1)*B:j*B));
            DCT60(1+(i-1)*B:i*B, 1+(j-1)*B:j*B) = dct2(Image60(1+(i-1)*B:i*B, 1+(j-1)*B:j*B));

            c = DCT100(a+(i-1)*B, a+1+(j-1)*B); 
            d = DCT100(a+1+(i-1)*B, a+(j-1)*B);

            if  c > d
                W1D100(1, ((i-1)*COL + j)) = 1;
            elseif d > c
                W1D100(1, ((i-1)*COL + j)) = 0;
            end
            
            c = DCT80(a+(i-1)*B, a+1+(j-1)*B); 
            d = DCT80(a+1+(i-1)*B, a+(j-1)*B);

            if  c > d
                W1D80(1, ((i-1)*COL + j)) = 1;
            elseif d > c
                W1D80(1, ((i-1)*COL + j)) = 0;
            end
            
            c = DCT60(a+(i-1)*B, a+1+(j-1)*B); 
            d = DCT60(a+1+(i-1)*B, a+(j-1)*B);

            if  c > d
                W1D60(1, ((i-1)*COL + j)) = 1;
            elseif d > c
                W1D60(1, ((i-1)*COL + j)) = 0;
            end
            
        end
    end
        
    rng(K);
    index100 = randperm(ROW*COL);
    [~, index100] = sort(index100);
    W1D100 = W1D100(index100);
    
    rng(K);
    index80 = randperm(ROW*COL);
    [~, index80] = sort(index80);
    W1D80 = W1D80(index80);
    
    rng(K);
    index60 = randperm(ROW*COL);
    [~, index60] = sort(index60);
    W1D60 = W1D60(index60);
    
    counter100 = 0;
    counter80 = 0;
    counter60 = 0;
    for i=1: 1: ROW
        for j=1: 1: COL
            
            if (W1D(1, (i-1)*COL + j) == 0 && W1D100(1, (i-1)*COL + j) == 0) || (W1D(1, (i-1)*COL + j) == 1 && W1D100(1, (i-1)*COL + j) == 1)
                counter100 = counter100 + 1;
            end 
            
             if (W1D(1, (i-1)*COL + j) == 0 && W1D80(1, (i-1)*COL + j) == 0) || (W1D(1, (i-1)*COL + j) == 1 && W1D80(1, (i-1)*COL + j) == 1)
                counter80 = counter80 + 1;
             end 
            
             if (W1D(1, (i-1)*COL + j) == 0 && W1D60(1, (i-1)*COL + j) == 0) || (W1D(1, (i-1)*COL + j) == 1 && W1D60(1, (i-1)*COL + j) == 1)
                counter60 = counter60 + 1;
            end 
        end
    end
    
    counter100 = counter100 / (ROW*COL);
    counter80 = counter80 / (ROW*COL);
    counter60 = counter60 / (ROW*COL);
    
    
    for i=1: 1: ROW
       for j=1: 1: COL
            Extracted100(i, j) = W1D100(1, ((i-1)*COL + j));
            Extracted80(i, j) = W1D80(1, ((i-1)*COL + j));
            Extracted60(i, j) = W1D60(1, ((i-1)*COL + j));
       end
   end
   


    figure 
    subplot(1, 3, 1)
    imshow(Extracted100);
    title(['NC100 = ' num2str(counter100)]);

    subplot(1, 3, 2)
    imshow(Extracted80);
   title(['NC80 = ' num2str(counter80)]);
    
    subplot(1, 3, 3)
    imshow(Extracted60);
    title(['NC60 = ' num2str(counter60)]);
        
end