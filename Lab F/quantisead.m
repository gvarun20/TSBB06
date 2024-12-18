function [qad, bps] = quantisead(ad, q),

s = size(q);
N = s(1)-1;
l = length(ad);

qad=ad;
qad(1:(l*2^(-N))) = quantise(ad(1:(l*2^(-N))),q(1,1),q(1,2));
bps = (l*2^(-N))*q(1,1);

p=l*2^(-N)+1;
for cnt=1:N,
  qad(p:l*2^(-N+cnt)) = quantise(qad(p:l*2^(-N+cnt)),q(cnt+1,1),q(cnt+1,2));
  bps = bps + (l*2^(-N+cnt)-p+1)*q(cnt+1,1);
  p = 2*(p-1)+1;
end

bps = bps/l;

return



function qx = quantise(x, b, r);

qx = round(x/r*2^(b-1))*r*2^(1-b);

return
