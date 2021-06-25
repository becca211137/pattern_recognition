%initialize
delta_t = 0.1;
f = zeros(1,4)+0.1;
g = zeros(1,4)+0.1;
% self programming
lf = length(f');
lg = length(g');
lc = lf + lg - 1;
c = zeros(1,lc);
for ii = 1:lf
    for jj = 1:lg
        kk = ii + jj - 1;
        c(1,kk) = c(1,kk) + f(ii)*g(jj);
    end
end
c = c .* delta_t
% using toolbox
c_toolbox = conv(f,g) .* delta_t 
