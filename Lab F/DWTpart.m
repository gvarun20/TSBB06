%%4.DWT of 1D
% 4.1 The two-channel filter bank
fprintf('\n\n ------- 4.1 The two-channel filter bank -------\n\n')
% Create random signal
l=256;
u=((-l/2):(l/2-1))*2*pi/l;
s0=rand(1,l);
S0=fftshift(fft(ifftshift(s0)));
S=S0.*(abs(u)<pi/4);
s=real(ifftshift(ifft(fftshift(S))));
figure(1);plot(0:255,s);
title('Input signal');

% Create filters from the db3 family
[h0, g0, h1, g1]=wfilters('db3');

% Look at the Fourier transforms of the filters
flength=length(h0);
u1=((-flength/2):(flength/2-1))*2*pi/flength;
figure(2);
subplot(4,1,1);plot(u1,abs(fftshift(fft(h0))));title('FT of h0');
subplot(4,1,2);plot(u1,abs(fftshift(fft(g0))));title('FT of g0');
subplot(4,1,3);plot(u1,abs((fftshift(fft(h1)))));title('FT of h1');
subplot(4,1,4);plot(u1,abs(fftshift(fft(g1))));title('FT of g1');
%QUESTION: How would you characterise the filters in terms of their frequency response functions?
%Sol:h0 and h1 are low pass filter ,,g0,g1 are high pass filter.
%QUESTION: Are the filter coefficients related to each other in the way you expected?
%Sol:yes
dwtmode('per');  %Set periodic mode of filtering operations
[a, d]=dwt(s,h0,g0);
figure(3);
subplot(2,1,1);plot(a);title('a');
subplot(2,1,2);plot(d);title('d');
%QUESTION: How would you characterise the two signals a and d?
%Sol:a contailns data,approximation,,,d contains details

% Reconstruct
srec1=idwt(a,d,h1,g1);
figure(4);plot(0:255,srec1);
title('Reconstructed signal');
%QUESTION: The reconstructed signal should be equal to the input signal.
% Verify this. Are they equal?
%Sol:almost same with small error

%Notice: the signals a and d each have half as many samples as the input
% signal s, and together they represent the same amount of data as s. Instead
% of plotting a and d one on top of the other, as in figure 3, they can be
% represented as the concatenation [a d] which is a signal of the same length 
% as the input signal. This form will be used in the following task.
%% 4.2 Multi-level filter bank
% Apply the filter on a0 instead
[a1, d1]=dwt(s,h0,g0);
[a2, d2]=dwt(a1,h0,g0);
figure(5);
subplot(3,1,1);plot(a2);title('a2');
subplot(3,1,2);plot(d2);title('d2');
subplot(3,1,3);plot(d1);title('d1');

a1rec=idwt(a2,d2,h1,g1);
srec2=idwt(a1rec,d1,h1,g1);
figure(6);plot(srec2);title('Reconstructed signal');
%QUESTION: Verify that the reconstructed signal equals the input signal.
% Are they equal?
%Sol:yes

% Code snippet (A)
N=3;ad=s;p=length(s);figure(7);
for cnt=1:N
[a, d]=dwt(ad(1:p),h0,g0);
ad(1:p)=[a d];

subplot(N+1,1,N+2-cnt);
plot(d);title(sprintf('details level %d',cnt));
p=p/2;
end
subplot(N+1,1,1);plot(a);
title(sprintf('approximation level %d',cnt));
figure(8);plot(ad);
title('Concatenated approximation and details');
% Code snippet (B)
for cnt=1:N
ad(1:(2*p))=idwt(ad(1:p),ad((p+1):(2*p)),h1,g1);
p=2*p;
end
figure(9);plot(ad);title('Reconstructed signal');
%QUESTION: Is the reconstructed signal in figure 9 equal to the input signal, figure 1?
%Sol:yes

%Try different values for N and look at the results!

%% 4.3 Simple signal compression
%QUESTION: If you use some reasonable value for N and consider the approximation and detail signals,
% how would you implement such a quantisation? Which components seem to need more bits than others?
% Sol:high level need more data,,a needs more bits than d

% Code snippet (A)
N=5;ad=s;p=length(s);figure(7);
for cnt=1:N
[a, d]=dwt(ad(1:p),h0,g0);
ad(1:p)=[a d];

subplot(N+1,1,N+2-cnt);
plot(d);title(sprintf('details level %d',cnt));
p=p/2;
end

subplot(N+1,1,1);plot(a);
title(sprintf('approximation level %d',cnt));
figure(10);plot(ad);
title('Concatenated approximation and details');

p_save = p;
q = zeros((N+1),2);
q(:,1) = 4;
ad_test = ad;
ad_save = ad;

q(1,2) = max(abs(ad_test(1:p)));
ad_test = ad_test(p+1:end);

for i = 1:N
   q(i+1,2) = max(abs(ad_test(1:p)));
   ad_test = ad_test(p+1:end);
   p = 2*p; 
end

[ad, bps] = quantisead(ad,q);

p= p_save;
% Reconstruct
% Code snippet (B)
for cnt=1:N
ad(1:(2*p))=idwt(ad(1:p),ad((p+1):(2*p)),h1,g1);
p=2*p;
end

figure(100);
subplot(3,1,1);plot(s);title('Original signal');
subplot(3,1,2);plot(ad);title('Reconstructed signal');
subplot(3,1,3);plot(s-ad);title('Difference');
SNR=log10(max(s)/std(ad-s))*20;
bps;

%QUESTION: What SNR do you get? What is the average number of bits per sample?
%sol:4.457db,,16 bitsper second

%QUESTION: What parameter do you use, what is the resulting SNR and average bits per sample?
%sol: