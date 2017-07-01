function [V,D] = eig(K,M)
%Written by Jeff Fike, Aerospace Design Lab, Stanford University
%This function is a member of the dualnumber class designed to compute exact first derivatives and should be located in the @dualnumber directory
%This function is extracted from dualnumber.tgz which was downloaded from http://adl.stanford.edu/hyperdual/

% Need derivatives of matrices, not h (or h^2) times the derivatives.
% Therefore this only works with h=1. ????
% Although it should work for any value of h ???
% issue seems to be with first derivative...

% Solving for eigenvector derivatives involves a singular (or at least
% nearly singular matrix.  Turn off the warning for this function.
warning('off','MATLAB:nearlySingularMatrix')
warning('off','MATLAB:singularMatrix')

if nargin~=2
    error('Hyperdual version of ''eig'' requires two inputs, i.e.  [V,D]=eig(K,M)')
end

M_real = real(M);
M_eps = eps(M);

K_real = real(K);
K_eps = eps(K);

[V_unsorted,D_unsorted] = eig(K_real,M_real);

% Sort eigenvalues and normalize?
% this may not be necessary for Nelson's method, but is needed for
% truncated summation in Fox's method

[d_sorted,sort_index] = sort(diag(D_unsorted));
num_modes = length(d_sorted);

mags=sqrt(diag(V_unsorted'*M_real*V_unsorted));
V_sorted = zeros(num_modes);
for k=1:num_modes
    V_sorted(:,k)=V_unsorted(:,sort_index(k))/mags(sort_index(k));
end

d_real = d_sorted;
V_real = V_sorted;

d_eps = zeros(num_modes,1);
V_eps = zeros(num_modes);
for k=1:num_modes
    % First derivatives of the eigenvalues
    d_eps(k,1) = V_real(:,k)'*(K_eps-d_real(k)*M_eps)*V_real(:,k);

    % Nelson's method for finding first derivatives of eigenvectors
    KLM = K_real-d_real(k)*M_real;
    VTM = V_real(:,k)'*M_real;
    KLM_eps = K_eps-d_eps(k)*M_real-d_real(k)*M_eps;
    f_eps = -KLM_eps*V_real(:,k);
    z_eps = KLM\f_eps;
    VTMepsV = V_real(:,k)'*M_eps*V_real(:,k);
    V_eps(:,k) = (-0.5*VTMepsV - VTM*z_eps)*V_real(:,k)+z_eps;

end


V = V_real+V_eps*dualnumber(0,1);
d = d_real+d_eps*dualnumber(0,1);
D = zeros(num_modes)*dualnumber(1,0);
for k=1:num_modes
    D(k,k) = d(k);
end

warning('on','MATLAB:nearlySingularMatrix')
warning('on','MATLAB:singularMatrix')

