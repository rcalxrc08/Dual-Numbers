function r = mtimes(P,Q)
%Written by Jeff Fike, Aerospace Design Lab, Stanford University
%This function is a member of the dualnumber class designed to compute exact first derivatives and should be located in the @dualnumber directory
%This function is extracted from dualnumber.tgz which was downloaded from http://adl.stanford.edu/hyperdual/

[nrp,ncp] = size(P);
[nrq,ncq] = size(Q);

if (nrp==1) && (ncp==1)
    r = P.*Q;
elseif (nrq==1) && (ncq==1)
    r = P.*Q;
elseif (ncp == nrq)
%     tic
    if (isa(P,'dualnumber') && isa(Q,'dualnumber'))
        P_real = real(P);
        P_eps = eps(P);
        Q_real = real(Q);
        Q_eps = eps(Q);
        r_real = P_real*Q_real;
        r_eps = P_eps*Q_real + P_real*Q_eps;
    elseif (isa(P,'dualnumber') && isa(Q,'numeric'))
        P_real = real(P);
        P_eps = eps(P);
        Q_real = Q;
        r_real = P_real*Q_real;
        r_eps = P_eps*Q_real;
    elseif (isa(P,'numeric') && isa(Q,'dualnumber'))
        P_real = P;
        Q_real = real(Q);
        Q_eps = eps(Q);
        r_real = P_real*Q_real;
        r_eps = P_real*Q_eps;
    else
        error('unknown data type in dualnumber/mtimes.m')
    end
    r = r_real + r_eps*dualnumber(0,1);
%     toc
else
    error('Inner matrix dimestions must agree.')
end
