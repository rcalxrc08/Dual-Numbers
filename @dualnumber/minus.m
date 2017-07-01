function r = minus(P,Q)
%Written by Jeff Fike, Aerospace Design Lab, Stanford University
%This function is a member of the dualnumber class designed to compute exact first derivatives and should be located in the @dualnumber directory
%This function is extracted from dualnumber.tgz which was downloaded from http://adl.stanford.edu/hyperdual/

[nrp,ncp] = size(P);
[nrq,ncq] = size(Q);

if (nrp==1) && (ncp==1)
    if isa(P,'dualnumber')
        if isa(Q,'dualnumber')
            for i=1:nrq
                for j=1:ncq
                    p = P;
                    q = Q(i,j);
                    r(i,j) = dualnumber(p.real - q.real,p.eps - q.eps);
                end
            end
        elseif isa(Q,'numeric')
            for i=1:nrq
                for j=1:ncq
                    p = P;
                    q = Q(i,j);
                    r(i,j) = dualnumber(p.real - q ,p.eps);
                end
            end
        end
    elseif isa(P,'numeric')
        if isa(Q,'dualnumber')
            for i=1:nrq
                for j=1:ncq
                    p = P;
                    q = Q(i,j);
                    r(i,j) = dualnumber(p - q.real,-q.eps);
                end
            end
        end
    end

elseif (nrq==1) && (ncq==1)
    if isa(P,'dualnumber')
        if isa(Q,'dualnumber')
            for i=1:nrp
                for j=1:ncp
                    p = P(i,j);
                    q = Q;
                    r(i,j) = dualnumber(p.real - q.real,p.eps - q.eps);
                end
            end
        elseif isa(Q,'numeric')
            for i=1:nrp
                for j=1:ncp
                    p = P(i,j);
                    q = Q;
                    r(i,j) = dualnumber(p.real - q ,p.eps);
                end
            end
        end
    elseif isa(P,'numeric')
        if isa(Q,'dualnumber')
            for i=1:nrp
                for j=1:ncp
                    p = P(i,j);
                    q = Q;
                    r(i,j) = dualnumber(p - q.real,-q.eps);
                end
            end
        end
    end
    
elseif (nrp == nrq) && (ncp == ncq)
    if isa(P,'dualnumber')
        if isa(Q,'dualnumber')
            for i=1:nrp
                for j=1:ncp
                    p = P(i,j);
                    q = Q(i,j);
                    r(i,j) = dualnumber(p.real - q.real,p.eps - q.eps);
                end
            end
        elseif isa(Q,'numeric')
            for i=1:nrp
                for j=1:ncp
                    p = P(i,j);
                    q = Q(i,j);
                    r(i,j) = dualnumber(p.real - q ,p.eps);
                end
            end
        end
    elseif isa(P,'numeric')
        if isa(Q,'dualnumber')
            for i=1:nrp
                for j=1:ncp
                    p = P(i,j);
                    q = Q(i,j);
                    r(i,j) = dualnumber(p - q.real,-q.eps);
                end
            end
        end
    end
    
else
    Error('Matrix dimensions must agree') 
end
