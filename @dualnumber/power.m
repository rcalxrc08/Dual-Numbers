function r = power(P,a)
%Written by Jeff Fike, Aerospace Design Lab, Stanford University
%This function is a member of the dualnumber class designed to compute exact first derivatives and should be located in the @dualnumber directory
%This function is extracted from dualnumber.tgz which was downloaded from http://adl.stanford.edu/hyperdual/

tol = 1e-15;
[nrp,ncp] = size(P);
[nra,nca] = size(a);
if isa(a,'numeric') && nra == 1 && nca ==1
    for i=1:nrp
        for j=1:ncp
            p=P(i,j);
            r(i,j) = dualnumber(p.real^a,a*p.eps*(p.real+tol)^(a-1));
        end
    end
else        
    error('Trying to raise a dualnumber to a non-scalar, non-numeric power.') 
end
