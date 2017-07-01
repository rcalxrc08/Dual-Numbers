function r = gt(p,q)
%Written by Jeff Fike, Aerospace Design Lab, Stanford University
%This function is a member of the dualnumber class designed to compute exact first derivatives and should be located in the @dualnumber directory
%This function is extracted from dualnumber.tgz which was downloaded from http://adl.stanford.edu/hyperdual/

if isa(p,'dualnumber')
    if isa(q,'dualnumber')
        r = (p.real > q.real);
    elseif isa(q,'numeric')
        r = (p.real > q);
    end
elseif isa(p,'numeric')
    if isa(q,'dualnumber')
        r = (p > q.real);
    end
end
