load A
size(A);

%%
%Approach 1
C = A*A'; %Compute the correlation matrix C
[e l] = eig(C); %Compute EVD of C
[PM p] = sort(diag(l),'descend'); %Sort the eigenvalues: largest first
PC = e(:,p);


%Approach2
%[PC, S] = svd(A);                  %Compute SVD of A
%PM = diag(S);                     %magnitudes are given by the
                                  %singular values
%% QUESTION: How many of the principal components M do you consider to be significant for representing the signal? Why?
%%% Question 1: 4

figure(1);
subplot(2,1,1); plot(PM,'o');
subplot(2,1,2); plot(log(PM),'o');

%% What value did you choose for M ? Was it the same as before?
%Question 2: Yes,if we choose a number greter than 4 it also captures the
%noise

M = 4;
figure(2);plot(diff(PM((M + 1):end)),'o');

%% Question 3: What can you say about the statistical properties of the signal from this view, 
% .g., its distribution along the two principal components? 
% sol: Principal componnt 1 has much greater variance.
% projecting pc1 and pc2 on a ...pc1 is more similar to A than pc2


figure(3); 
plot(PC(:, 1)' * A, PC(:,2)'*A,'o'); % Project A on these two axis 
axis('equal');

%%

m=mean(A,2);
A0 = A - m*ones(1,size(A,2));
[PC S] = svd(A0);
PM = diag(S);
figure(4);
subplot(2,1,1);plot(PM,'o');
subplot(2,1,2);plot(log(PM),'o');
figure(5);
subplot(4,1,1); plot(PC(:,1)'*A0, PC(:,2)'*A0,'o'); axis('equal')
subplot(4,1,2); plot(PC(:,2)'*A0, PC(:,3)'*A0,'o'); axis('equal')
subplot(4,1,3); plot(PC(:,3)'*A0, PC(:,4)'*A0,'o'); axis('equal')
subplot(4,1,4); plot(PC(:,4)'*A0, PC(:,5)'*A0,'o'); axis('equal')

%% Compute and plot the residual error ϵ as a function of the number of principal components that you use. 
% Hint: use the Matlab function cumsum. 
% Remember that the eigenvalues of C are the squares of the singular values of A!
error1 =cumsum(PC(1:M));
figure(6);plot(error1 ,'o');
% Question 4:How many principal components do you believe to be significant in this case? Why?
%sol:3, less than before,  the pricipal component calculating
%the mean is not needed.
% Question 5:It the same number as before, when the mean was not subtracted? Why?
%Sol: No. Removed a dimension by subtracting the mean
figure(7);
plot3(PC(:,1)'*A0 ,PC(:,2)'*A0,PC(:,3)'*A0, 'o'); axis('equal');

  
% Question 6: Given the observations that you have made during the analysis of this signal, 
% how would you describe its distribution?
% Sol:Normal distribution .?????????

% Question 7:  Try suggest some other strategy for determining the number of significant principal components M .
% Sol:Rolling a dice (magnitude of SVD)
%%
figure(8);
mesh(A0);
%imagesc(A0);

% Question 8:Plot the data matrix A0 using mesh or imagesc. 
% Is it possible to make the same observation from these plots as you did using plot3? 
% Sol: No, might be possible, can see a sine wave 