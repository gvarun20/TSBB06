s = randn(1024,1);
S = fftshift(fft(s));
u = (-512:511)' * pi/512;
Rect8 = (abs(u) < pi/8);
Sbl = S .* Rect8; %Create a pi/4-band-limited transform
sbl = ifft(ifftshift(Sbl));
figure(1);subplot(2,1,1);plot(0:1023,sbl);
title('band-limited signal');
subplot(2,1,2);plot(u,abs(Sbl));
title('Fourier transform of band-limited signal');

% Downsample by 8
downsampl8=sbl(1:8:end);

% Upsample by inserting zeroes
upsampl8 = zeros(1024,1);
upsampl8(1:8:end) = downsampl8;
figure(2); subplot(2,1,1); plot(0:1023,upsampl8);
title('The signal down-sampled with a factor 8');
subplot(2,1,2); plot(u,abs(fftshift(fft(upsampl8))));
title('Fourier transform of down-sampled signal');


% Plot rect signal
rect8 = ifft(fftshift(8*Rect8));
figure(3);
subplot(2,1,1); plot(-512:511, ifftshift(rect8));
title('Reconstructing filter rect8');
subplot(2,1,2); plot(u,abs(fftshift(fft(rect8))));

for ix=0:127,
    B8(:,ix+1) = circshift(rect8,8*ix);
end
figure(4); plot(0:1023,B8(:,[1 2 3]));
%QUESTION: What do the reconstructing functions look like? 
% Are they in accordance with your expectations described in preparatory exercise 2?
% SOL:Since its linear function its additive,point is from the graph and
% the rest is the function and repeatedly
%128 sinc function presesnt

sblrec8 = B8*upsampl8(1:8:end);
figure(5);
subplot(2,1,1); plot(0:1023,sblrec8);
title('Reconstructed signal from factor 8 down-sampled signal');
subplot(2,1,2); plot(u,abs(fftshift(fft(sblrec8))));
title('Fourier transform of reconstructed signal');
fprintf('Reconstruction from factor 8 down-sampled signal (no noise)\n');
%err=sbl-sblrec8;
%Question 2:hat amount of noise do you get (mean and standard deviation)? 
% Is it consistent with your answer to preparatory exercise 3?
%sol:mean 0 and sd is 0
%% 
%disp(norm(err));
%disp(mean(err));
%disp(std(err));
sigma=0.1;
downsampl8n=sbl(1:8:end)+sigma*randn(128,1);
upsampl8n=zeros(1,1024);
upsampl8n(1:8:end)=downsampl8n;
figure(6);
subplot(2,1,1);plot(0:1023,upsampl8n);
title('The signal down-sampled with a factor 8 with noise');
subplot(2,1,2);plot(u,abs(fftshift(fft(upsampl8n))));
title('Fourier transform of down-sampled signal with noise');


sblrec8n=B8*downsampl8n;
figure(7);subplot(2,1,1);plot(0:1023,sblrec8n);
title('Reconstructed signal from factor 8 down-sampled signal with noise');
subplot(2,1,2);plot(u,abs(fftshift(fft(sblrec8n))));
title('Fourier transform of reconstructed signal with noise');
err=sbl-sblrec8n;
fprintf('Reconstruction from factor 8 down-sampled signal with noise\n');

%Question:QUESTION: What amount of noise do you get (mean and standard deviation)?
% Is it consistent with your answer to preparatory exercise 5?
%Sol:mean is 0 and sd is somwhere around 0.1

%% 3.3 Over-sampling, reconstruction with a basis
downsampl4n=sbl(1:4:end)+sigma*randn(256,1);
upsampl4n=zeros(1,1024);
upsampl4n(1:4:end)=downsampl4n;
figure(8);
subplot(2,1,1);plot(0:1023,upsampl4n);
title('The signal down-sampled with a factor 4 with noise');
subplot(2,1,2);plot(u,abs(fftshift(fft(upsampl4n))));
title('Fourier transform of down-sampled signal with noise');

Rect4=(abs(u)<=pi/4);
rect4=ifft(fftshift(4*Rect4));
figure(9);
subplot(2,1,1);plot(-512:511,ifftshift(rect4));
title('Reconstructing filter rect4' );
subplot(2,1,2);plot(u,abs(fftshift(fft(rect4))));

for ix=0:255,
    B4(:,ix+1)=circshift(rect4,4*ix);
end
figure(10);plot(0:1023,B4(:,[1 2 3])');
% Question 4:QUESTION: What do the reconstructing functions look like in this case?
% Are they as you expected?
%Answer:yes

sblrec4b=B4*downsampl4n;
figure(11);subplot(2,1,1);plot(0:1023,sblrec4b);
title('Reconstructed signal from factor 4 down-sampled signal (basis)');
subplot(2,1,2);plot(u,abs(fftshift(fft(sblrec4b))));
title('Fourier transform of reconstructed signal (basis)');
err=sbl-sblrec4b;
fprintf('Reconstruction from factor 4 down-sampled signal (basis)\n');
fprintf('Reconstruction error: mean %f std %f\n',mean(err),std(err));
%QUESTION: What amount of noise do you get (mean and standard deviation)?
% Is it consistent with your answer to preparatory exercise 7?
%Sol:0 mean and sd close to 0.1
%QUESTION: Does it give you the expected answer?̈́
%sol:yes it checks for the last value

%% 3.4 Over-sampling, reconstruction with a frame
for ix=0:255,
    F8(:,ix+1)=circshift(rect8,4*ix);
end
figure(13);plot(0:1023,F8(:,[1 2 3])');
%QUESTION: What do these functions look like? 
% How do they differ from the reconstructing functions in the previous exercise? Compare!
%Sol:It is out of phase ,,the combination will not cancel each other.
sblrec4f=0.5*F8*downsampl4n;
figure(15);
subplot(2,1,1);plot(0:1023,sblrec4f);
title('Reconstructed signal from factor 4 down-sampled signal (frame)');
subplot(2,1,2);plot(u,abs(fftshift(fft(sblrec4f))));
title('Fourier transform of reconstructed signal (frame)');
err=sbl-sblrec4f;
fprintf('Reconstruction from factor 4 down-sampled signal (frame)\n');
fprintf('Reconstruction noise error: mean %f std %f\n',mean(err),std(err));
%QUESTION: Did you get a noise level in accordance with preparatory exercise 10?
%Sol:yes ,,lower the svd
%QUESTION: Is it a proper frame?
%Sol:it is a frame

%Now to confirm that F8 holds a proper frame
% Check frame F8
[U S V] = svd(F8);
diagS  = diag(S);
zeros_S = find( diagS == 0); % zeros_S is empty -> F8 correct frame