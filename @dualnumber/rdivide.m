function r = rdivide(P,Q)
%Written by Jeff Fike, Aerospace Design Lab, Stanford University
%This function is a member of the dualnumber class designed to compute exact first derivatives and should be located in the @dualnumber directory
%This function is extracted from dualnumber.tgz which was downloaded from http://adl.stanford.edu/hyperdual/

[nrp,ncp] = size(P);
[nrq,ncq] = size(Q);
if (nrp==1) && (ncp==1)
    for i=1:nrq
        for j=1:ncq
            q = Q(i,j);
            r(i,j) = P*q^(-1);
        end
    end
elseif (nrq==1) && (ncq==1)
    for i=1:nrp
        for j=1:ncp
            p = P(i,j);
            r(i,j) = p*Q^(-1);
        end
    end
elseif (nrp == nrq) && (ncp == ncq)
    for i=1:nrp
        for j=1:ncp
            p = P(i,j);
            q = Q(i,j);
            r(i,j) = p*q^(-1);
        end
    end
else
    Error('Matrix dimensions must agree') 
end
