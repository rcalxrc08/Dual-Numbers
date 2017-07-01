function r = sum(P)
%Written by Jeff Fike, Aerospace Design Lab, Stanford University
%This function is a member of the dualnumber class designed to compute exact first derivatives and should be located in the @dualnumber directory
%This function is extracted from dualnumber.tgz which was downloaded from http://adl.stanford.edu/hyperdual/

[nrp,ncp] = size(P);
if nrp == 1
    temp = dualnumber(0,0);
    for i=1:ncp
        temp = temp + P(1,i);
    end
    r = temp;
else
    for j=1:ncp
        temp = dualnumber(0,0);
        for i=1:nrp
            temp = temp + P(i,j);
        end
        r(1,j) = temp;
    end
end
