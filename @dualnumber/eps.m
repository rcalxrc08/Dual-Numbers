function r = eps(P)
%Written by Jeff Fike, Aerospace Design Lab, Stanford University
%This function is a member of the dualnumber class designed to compute exact first derivatives and should be located in the @dualnumber directory
%This function is extracted from dualnumber.tgz which was downloaded from http://adl.stanford.edu/hyperdual/

[nrp,ncp] = size(P);
r=zeros(nrp,ncp);
for i=1:nrp
    for j=1:ncp
        p = P(i,j);
        r(i,j) = p.eps;
    end
end
