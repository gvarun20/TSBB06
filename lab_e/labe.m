load A
size(A)
%--------------------------------------------
C = A*A'; %Compute the correlation matrix C
[e l] = eig(C); %Compute EVD of C
[PM p] = sort(diag(l),'descend'); %Sort the eigenvalues: largest first
PC = e(:,p);
%------------------------------------------
[PC S] = svd(A); %Compute SVD of A
PM = diag(S); %magnitudes are given by the
%singular values
%--------------------------------------------------------------------
PM = PM;
PC = PC;
figure(1);
subplot(2,1,1):plot(PM,'o');
subplot(2,1,2):plot(log(PM),'o');
%-------------------------------------------------
M = 1000
figure(2);plot(diff(PM((M + 1):end)),'o');

%--------------------------------------------
%--------------------------------------------------------------------
