%im = double(imread('middlebury.png'));
%im = double(imread('cameraman.png'));
%im = double(imread('flowergarden.png'));
%im = double(imread('baboon.png'));
im = rand(512,512);
im = double(imread('ploop.png'));
size(im)
figure(10); colormap('gray');imagesc(im);

N = 16;
A = im2col(im,[N N],'distinct');
size(A)

%%

[PC, S] = svd(A);
PM = diag(S);
figure(11);
subplot(2,1,1);plot(PM,'o');
subplot(2,1,2);plot(log(PM),'o');
%%

figure(12);colormap('gray');
for M=(1:6),
c=PC(:,M)'*A;    %Compute coordinates from blocks
Arec=PC(:,M)*c;  %Reconstruct blocks from coordinates
imrec=col2im(Arec,[N N],size(im),'distinct');  %Reshape into image
subplot(2,3,M);imagesc(imrec);axis('off');     %Display image
title(sprintf('%d principal components',M));   %Set title
end

%%

figure(14);colormap('gray');
for cnt=1:6,
subplot(2,3,cnt);h=mesh(reshape(PC(:,cnt),N,N));
set(h,'edgecolor','black');axis([1 N 1 N -0.5 0.5]);
title(sprintf('principal component %d',cnt));
end