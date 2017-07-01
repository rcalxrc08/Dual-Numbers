function hd = dualnumber(a,b)
%Written by Jeff Fike, Aerospace Design Lab, Stanford University
%This function is a member of the dualnumber class designed to compute exact first derivatives and should be located in the @dualnumber directory
%This function is extracted from dualnumber.tgz which was downloaded from http://adl.stanford.edu/hyperdual/

if nargin == 0
   hd.real = [];
   hd.eps = [];
   hd = class(hd,'dualnumber');
elseif nargin == 1
    if isa(a,'dualnumber')
        hd = a;
    else
        hd.real = a;
        hd.eps = 0;
        hd = class(hd,'dualnumber');
    end
elseif nargin == 2
   hd.real = a;
   hd.eps = b;
   hd = class(hd,'dualnumber');
else
    error('dualnumber called with wrong number of inputs.') 
end
