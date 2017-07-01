function [V,d] = eig_Nsort(K,M,num_modes)
%Written by Jeff Fike, Aerospace Design Lab, Stanford University
%This function is a member of the dualnumber class designed to compute exact first derivatives and should be located in the @dualnumber directory
%This function is extracted from dualnumber.tgz which was downloaded from http://adl.stanford.edu/hyperdual/

% function to compute smallest "num_modes" number of eigenvalues and
% normalized eigenvectors
%
% num modes is an integer
% function returns d as a 1D vector rather than a diagonal matrix


% Need derivatives of matrices, not h (or h^2) times the derivatives.
% Therefore this only works with h=1. ????
% Although it should work for any value of h ???
% issue seems to be with first derivative...

% Solving for eigenvector derivatives involves a singular (or at least
% nearly singular matrix.  Turn off the warning for this function.
warning('off','MATLAB:nearlySingularMatrix')
warning('off','MATLAB:singularMatrix')

if nargin~=3
    error('dualnumber version of ''eig_Nsort'' requires three inputs, i.e.  [V,d]=eig_Nsort(K,M,num_modes)')
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

mags=sqrt(diag(V_unsorted'*M_real*V_unsorted));
V_sorted = zeros(length(d_sorted),num_modes);
for k=1:num_modes
    V_sorted(:,k)=V_unsorted(:,sort_index(k))/mags(sort_index(k));
end

d_real = d_sorted(1:num_modes);
V_real = V_sorted;

d_eps = zeros(num_modes,1);
V_eps = zeros(length(d_sorted),num_modes);

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

warning('on','MATLAB:nearlySingularMatrix')
warning('on','MATLAB:singularMatrix')
