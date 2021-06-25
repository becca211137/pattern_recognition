%self programming
f = zeros(4,4) + 0.1;
g = f;
[f_x, f_y] = size(f);
[g_x, g_y] = size(g);
c_x = f_x + g_x - 1;
c_y = f_y + g_y - 1;
result = zeros(c_x, c_y);
for a = 1:f_x
    for b = 1:f_y
        for i = 1:g_x
            for j = 1:g_y
                xx = a+i-1;
                yy = b+j-1;
                result(xx,yy) = f(a,b)*g(i,j) + result(xx,yy);
            end
        end
    end
end
delta_x = 0.1;
delta_y = 0.1;
result = result.*delta_x.*delta_y;
% using toolbox
toolbox_result = conv2(f,g).*delta_x.*delta_y;