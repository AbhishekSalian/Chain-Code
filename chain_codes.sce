clc;clear;xdel(winsid());
I = imread('C:\Users\Admin\Desktop\chaincodes\binary2.jpg');//input image path
figure,imshow(I);title("original image");
[M,N] = size(I);
//binary conversion of image
I_bin=zeros(M,N)
for x = 1:M
    for y = 1:N
      if I(x,y)<=255 && I(x,y)>=210
         I_bin(x,y)=255; 
      end
    end
end
I_bin=uint8(I_bin);
//detect first white pixel
first_pix = [];
r=zeros(M,N)
i=0
for x = 1:M
    for y = 1:N
        //r(x,y)=255;
        //subplot(111);imshow(uint8(r));
      if I(x,y)==255 && i==0
         first_pix = [x,y]; 
         i=1;
     end

    end
    
end
I=double(I);
//show the coordinate of  first white pixel
I_sample = zeros(M,N);
I_sample(first_pix(1),first_pix(2))=255;
figure,imshow(uint8(I_sample));title("tracing boundary");

chain_codes=[]
x_c=first_pix(1);
y_c=first_pix(2);
//chain code process
boolean=1;
connect4=[I_bin(x_c,y_c+1),I_bin(x_c+1,y_c),I_bin(x_c,y_c-1),I_bin(x_c-1,y_c)];
x_ci=x_c;
y_ci=y_c;
while(boolean==1)
   //coonect4=[East,south,west,north]
   if connect4(1)==255
       y_c=y_c+1;
       chain_codes=[chain_codes,0];
       connect4=[I_bin(x_c,y_c+1),I_bin(x_c+1,y_c),uint8(0),I_bin(x_c-1,y_c)]
       r(x_c,y_c)=255
       subplot(111);imshow(uint8(r));
      
       
   else
       if connect4(2)==255
       x_c=x_c+1;
       chain_codes=[chain_codes,3];
       connect4=[I_bin(x_c,y_c+1),I_bin(x_c+1,y_c),I_bin(x_c,y_c-1),uint8(0)]
       r(x_c,y_c)=255
       subplot(111);imshow(uint8(r));
      
       
       else
            if connect4(3)==255
               y_c=y_c-1;
               chain_codes=[chain_codes,2];
               connect4=[uint8(0),I_bin(x_c+1,y_c),I_bin(x_c,y_c-1),I_bin(x_c-1,y_c)]
               r(x_c,y_c)=255
               subplot(111);imshow(uint8(r));
               
      
             else
                if connect4(4)==255
                   x_c=x_c-1;
                   chain_codes=[chain_codes,1];
                   connect4=[I_bin(x_c,y_c+1),uint8(0),I_bin(x_c,y_c-1),I_bin(x_c-1,y_c)]
                   r(x_c,y_c)=255
                   subplot(111);imshow(uint8(r));
                end
             end
         end
    end 
    if x_ci==x_c && y_ci==y_c
        break;
    end               
end
chain_code=[chain_codes(1)]
j=0;
for i=1:length(chain_codes)-1
     if chain_codes(i)~=chain_codes(i+1)
          chain_code=[chain_code,chain_codes(i+1)]
      end
         
end
disp(chain_code,"final chain code for the given binary image is:");



