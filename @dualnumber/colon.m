function r = colon(a,d,b)
%Written by Jeff Fike, Aerospace Design Lab, Stanford University
%This function is a member of the dualnumber class designed to compute exact first derivatives and should be located in the @dualnumber directory
%This function is extracted from dualnumber.tgz which was downloaded from http://adl.stanford.edu/hyperdual/


if (d == 0) || ((d > 0) && (a > b)) || ((d < 0) && (a < b))
    r = dualnumber;
elseif (d > 0)
    if isa(a,'numeric')
        a = dualnumber(a,0);
    end
    i=1;
    run=1;
    r(1,i) = a;
    while run == 1
        i=i+1;
        new = r(1,i-1) + d;
        if new <= b + 1e-10
            if new > b
                new.real = real(b);
            end
            r(1,i) = new;
        else
            run = 0;
        end
    end
elseif (d < 0)
    if isa(a,'numeric')
        a = dualnumber(a,0);
    end
    i=1;
    run=1;
    r(1,i) = a;
    while run == 1
        i=i+1;
        new = r(1,i-1) + d;
        if new < b - 1e-10
            run = 0;
        else
            if new < b
                new.real = real(b);
            end
            r(1,i) = new;
        end
    end
end
