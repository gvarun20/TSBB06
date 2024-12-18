
im = double(imread('middlebury.png')); % Choose you image here!
M = 6;

N = 8;
A = im2col(im,[N N],'distinct');
size(A)

C = A*A';        
[e l] = eig(C);
[PM p] = sort(diag(l),'descend');
PC = e(:,p);

[PC S] = svd(A);
PM = diag(S);

figure(11);
subplot(2,1,1);plot(PM,'o');
subplot(2,1,2);plot(log(PM),'o');
figure(12);colormap('gray');
for M=1:6
c=PC(:,1:M)'*A; %Compute coordinates from blocks
Arec=PC(:,1:M)*c; %Reconstruct blocks from coordinates
imrec=col2im(Arec,[N N],size(im),'distinct'); %Reshape into image
subplot(2,3,M);imagesc(imrec);axis('off'); %Display image
title(sprintf('%d principal components',M)); %Set title
end
%Choose at least 4 different images and investigate 
% how many principal components you would like to use to make a reasonable representation of the image. 
% Which images and how many components?
% Sol: 5 or 6 PC maybe requried , depends on the image and what the picture
% needs, sunce fingerprint needs patterns and clear markings
%In which part of an image do you obtain a good representation of the original image, 
% and where is it not as good?
%sol: details of the image are bad , but the overall picture is better.
%The image middlebury contains a white box with some text on it. 
% How many principal components are needed in order to represent
% an image where you can read the text? Is this number something can you
% can derive from the distribution of principal magnitudes?
%Sol:no we cant see the text .it is based on the
%%
figure(12);colormap('gray');
c=PC(:,1:M)'*A;    %Compute coordinates from blocks
Arec=PC(:,1:M)*c;  %Reconstruct blocks from coordinates
imrec=col2im(Arec,[N N],size(im),'distinct');  %Reshape into image
imagesc(imrec);axis('off');     %Display image

%%
figure(12);colormap('gray');
for M=1:6,
c=PC(:,1:M)'*A; %Compute coordinates from blocks
Arec=PC(:,1:M)*c; %Reconstruct blocks from coordinates
imrec=col2im(Arec,[N N],size(im),'distinct'); %Reshape into image
subplot(2,3,M);imagesc(imrec);axis('off'); %Display image
title(sprintf('%d principal components',M)); %Set title
end
%%


im = double(imread('boat.png')); % Choose you image here!

figure(13);colormap('gray');
A = im2col(im,[N N],'distinct');
c=PC(:,1:M)'*A;    %Compute coordinates from blocks
Arec=PC(:,1:M)*c;  %Reconstruct blocks from coordinates
imrec=col2im(Arec,[N N],size(im),'distinct');  %Reshape into image
imagesc(imrec);axis('off');     %Display image

% ANSWER: There is nott a signifficant different. The six first principal
% vectors are lways almost the same

%%
% 3.1

figure(14);colormap('gray');
for cnt=1:6,
subplot(2,3,cnt);h=mesh(reshape(PC(:,cnt),N,N));
set(h,'edgecolor','black');axis([1 N 1 N -0.5 0.5]);
title(sprintf('principal component %d',cnt));
end

% Can you characterize the principal components in some simple way? 
%Sol:lower N better im quality but more block -> more data, they are
%orthonormal,1st one might be line,2nd is the curve
%Is there a significant difference in the quality of the reconstruction compared to when the principal 
% components comes from the same image? Why?
% Sol:here is nott a signifficant different. The six first principal
% vectors are always almost the same.Pc1 contain so much that
% ??????????????????12 is better substitute for 6

%% 3.2 Changing the block size

im_boat = double(imread('boat.png')); % Choose you image here!
%image_rep(im_boat, 20,16)
% What is the significant difference when the block size changes? Why?
% Sol: lower N better im quality but more block -> more data
%How many components do you need for block size 16 × 16 
% in order to get the same quality in the reconstruction as with 6 components with block size 8 × 8? Explain why.
% ANSWER: 18 is almost equalt to 8. when the blocksize is 16x16.
% Larger pixel blocks -> fewer blocks higher order principal components needed for the same detail
% 


%% 3.3  PCA of synthetic images

im = double(imread('ploop.png')); % Choose you image here!
M = 64;

N = 8;
A = im2col(im,[N N],'distinct');
size(A)

C = A*A';        
[e l] = eig(C);
[PM p] = sort(diag(l),'descend');
PC = e(:,p);

[PC S] = svd(A);
PM = diag(S);

figure(15);
subplot(2,1,1);plot(PM,'o');
subplot(2,1,2);plot(log(PM),'o');

figure(16);colormap('gray');
for M=1:6,
c=PC(:,1:M)'*A;    %Compute coordinates from blocks
Arec=PC(:,1:M)*c;  %Reconstruct blocks from coordinates
imrec=col2im(Arec,[N N],size(im),'distinct');  %Reshape into image
subplot(2,3,M);imagesc(imrec);axis('off'); %Display image
title(sprintf('%d principal components',M)); %Set title
end



figure(17);colormap('gray');
for cnt=1:6,
subplot(2,3,cnt);h=mesh(reshape(PC(:,cnt),N,N));
set(h,'edgecolor','black');axis([1 N 1 N -0.5 0.5]);
title(sprintf('principal component %d',cnt));
end

%QUESTION: Is there any qualitative difference between the principal components and 
% principal values derived from this image compared to those derived from natural images?
% ANSER: Yes there is a significant differance in the principal components 
% and principal values between ploop and the natural images. 

%Question :Is the reconstruction reasonably good? Explain why.
% ANSWER: No, the recunstruction is not good at all. Princible components
% are not linear . the plot don't go down to zero.

%% Random image

im = rand(512,512);

M = 8;

N = 8;
A = im2col(im,[N N],'distinct');
size(A)

C = A*A';        
[e l] = eig(C);
[PM p] = sort(diag(l),'descend');
PC = e(:,p);

%[PC S] = svd(A);
%PM = diag(S);

figure(18);
subplot(2,1,1);plot(PM,'o');
subplot(2,1,2);plot(log(PM),'o');

figure(19);colormap('gray');
c=PC(:,1:M)'*A;    %Compute coordinates from blocks
Arec=PC(:,1:M)*c;  %Reconstruct blocks from coordinates
imrec=col2im(Arec,[N N],size(im),'distinct');  %Reshape into image
imagesc(imrec);axis('off');     %Display image


figure(20);colormap('gray');
for cnt=1:6,
subplot(2,3,cnt);h=mesh(reshape(PC(:,cnt),N,N));
set(h,'edgecolor','black');axis([1 N 1 N -0.5 0.5]);
title(sprintf('principal component %d',cnt));
end

% Do they appear as your answer to preparatory exercise 7?

% ANSWER: Yes, there is no consistency, that's what we expected.
% What is the result?
%


%%

im = double(imread('boat.png')); % Choose you image here!

figure(21);colormap('gray');
A = im2col(im,[N N],'distinct');
c=PC(:,1:M)'*A;    %Compute coordinates from blocks
Arec=PC(:,1:M)*c;  %Reconstruct blocks from coordinates
imrec=col2im(Arec,[N N],size(im),'distinct');  %Reshape into image
imagesc(imrec);axis('off');     %Display image

% ANSWER: We can se what picture it is, but compared to how many M were
% needed previasly its bad. 

%% Use nataural image to reconstruct rand image

im = double(imread('taxi.png')); % Choose you image here!
M = 8;

N = 8;
A = im2col(im,[N N],'distinct');
size(A)

C = A*A';        
[e l] = eig(C);
[PM p] = sort(diag(l),'descend');
PC = e(:,p);

[PC S] = svd(A);
PM = diag(S);

figure(22);
subplot(2,1,1);plot(PM,'o');
subplot(2,1,2);plot(log(PM),'o');

figure(23);colormap('gray');
c=PC(:,1:M)'*A;    %Compute coordinates from blocks
Arec=PC(:,1:M)*c;  %Reconstruct blocks from coordinates
imrec=col2im(Arec,[N N],size(im),'distinct');  %Reshape into image
imagesc(imrec);axis('off');     %Display image



im = rand(512,512);

figure(24);colormap('gray');
A = im2col(im,[N N],'distinct');
c=PC(:,1:M)'*A;    %Compute coordinates from blocks
Arec=PC(:,1:M)*c;  %Reconstruct blocks from coordinates
imrec=col2im(Arec,[N N],size(im),'distinct');  %Reshape into image
imagesc(imrec);axis('off');     %Display image
%What is the result? How is it different compared to the  original noise image?
% ANSWER: The previous image were more detailed.