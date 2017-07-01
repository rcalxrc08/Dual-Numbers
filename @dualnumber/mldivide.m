function r = mldivide(P,Q)
%Written by Jeff Fike, Aerospace Design Lab, Stanford University
%This function is a member of the dualnumber class designed to compute exact first derivatives and should be located in the @dualnumber directory
%This function is extracted from dualnumber.tgz which was downloaded from http://adl.stanford.edu/hyperdual/

[nrp,ncp] = size(P);
[nrq,ncq] = size(Q);

if nrp == 2 && ncp == 2
    det = P(1,1)*P(2,2) - P(1,2)*P(2,1);
    Pinv = [P(2,2) -P(1,2);-P(2,1) P(1,1)];
    r = (1/det)*Pinv*Q;
elseif nrp==ncp
    P_real = real(P);
    P_eps = eps(P);

    Q_real = real(Q);
    Q_eps = eps(Q);

    
    %option 1:  store inverse and use it 2 times
    Pinv = inv(P_real);
    x_real = Pinv*Q_real;
    x_eps = Pinv*(Q_eps - P_eps*x_real);

    
    %option 2:  use left divide 2 times with same RHS
%     x_real = P_real\Q_real;
%     x_eps1 = P_real\(Q_eps1 - P_eps1*x_real);

    
    %option 1 slightly faster?  
    %  difference not noticeable:  max .06 sec out of 17.6 sec for CMS case
    
    r = x_real + x_eps*dualnumber(0,1);
else
    error('Left divide currently defined only for square matrices') 
end
