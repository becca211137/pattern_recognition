%initialize
dx = 0.1;
dy = 0.1;
f = zeros(4,4) + 0.1;
g = zeros(4,4) + 0.1;
%self programming
[xf, yf] = size(f);
[xg, yg] = size(g);
xc = xf+xg-1;
yc = yf+yg-1;
c = zeros(xc, yc);
for mm = 1:xf
    for nn = 1:yf
        for ii = 1:xg
            for jj = 1:yg
                xx = mm+ii-1;
                yy = nn+jj-1;
                c(xx,yy) = c(xx,yy) + f(mm,nn)*g(ii,jj);
            end
        end
    end
end
c = c.*dx.*dy
% using toolbox
c_toolbox = conv2(f,g).*dx.*dy