function r = normcdf(p)
r = dualnumber(normcdf(p.real), normpdf(p.real));
