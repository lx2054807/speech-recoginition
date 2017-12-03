 
D=hw3_1;
% Initial D1 D2
D1=[0;0];
D2=[0;0];
% Because \rho=0.5, we choose 1:50 as D1, 51:100 as D2.
for i=1:100,
    if i<=50
        D1=[D1,D(:,i)];
    else 
        D2=[D2,D(:,i)];
    end
end
n1=size(D1,2);
n2=size(D2,2);
% Because D1 D2 contain [0:0}, we delete the first element.
D1=D1(:,2:n1);
D2=D2(:,2:n2);
% The actual size should deduct 1
n1=n1-1;
n2=n2-1;
% Use Maximum-likelihood estimation method, we know in Gaussian case:
mu1=mean(D1,2);
mu2=mean(D2,2);
xm1=bsxfun(@minus,D1,mu1);
cov1=abs(xm1*xm1')/n1;
xm2=bsxfun(@minus,D2,mu2);
cov2=abs(xm2*xm2')/n2;
rho1=n1/(n1+n2);
rho2=1-rho1;
m1=0;
s=0;
while (m1~=n1),
s=s+1;%iteration times
m1=n1;
% E-step:
% Use likelihood function
n1=0;
n2=0;
xk=[0;0];
D1=[0;0];
D2=[0;0];

 for i=1:100,
    xk=D(:,i);
    %calculte probability
    xm1=(bsxfun(@minus,xk,mu1));
    g1=mvnpdf(xk,mu1,sqrt(cov1));
    xm2=(bsxfun(@minus,xk,mu2));
    g2=mvnpdf(xk,mu2,sqrt(cov2));
    %likelihood function
    L=g1*rho1-g2*rho2;
    if L>=0
       D1(:,n1+1)=xk;
       n1=n1+1;
    else 
       D2(:,n2+1)=xk;
       n2=n2+1;
    end
 end

% M-step:
% use maximum-likelihood method:
mu1=mean(D1,2);
mu2=mean(D2,2);
xm1=bsxfun(@minus,D1,mu1);
cov1=abs(xm1*xm1')/n1;
xm2=bsxfun(@minus,D2,mu2);
cov2=abs(xm2*xm2')/n2;
rho1=n1/(n1+n2)
rho2=n2/(n1+n2)
end
