
l=256;
u=((-l/2):(l/2-1))*2*pi/l;
s0=rand(1,l);
S0=fftshift(fft(ifftshift(s0)));
S=S0.*(abs(u)<pi/4);
s=real(ifftshift(ifft(fftshift(S))));

% Code snippet (A)
N=3;ad=s;p=length(s);figure(7);
for cnt=1:N,
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

ad_test = ad;
ad_save = ad;
energy_vec = [];

q(1,2) = max(abs(ad_test(1:p)));
energy_vec = sum(ad_test(1:p))/q(1,2);
ad_test = ad_test(p+1:end);


for i = 1:N
   q(i+1,2) = max(abs(ad_test(1:p)));
   energy_vec = [energy_vec sum(ad_test(1:p))/q(i+1,2)];
   ad_test = ad_test(p+1:end);
   p = 2*p; 
end


energy_vec;
% q(:,1) = make_q(energy_vec,4);
q(:,1) = [6 3 2 1];
%q(:,1) = [6 3  1 1];

[ad, bps] = quantisead(ad,q); %Replace the channels with quantised values



p= p_save;
% Reconstruct
% Code snippet (B)
for cnt=1:N,
ad(1:(2*p))=idwt(ad(1:p),ad((p+1):(2*p)),h1,g1);
p=2*p;
end



SNR=log10(max(s)/std(ad-s))*20;
bps;