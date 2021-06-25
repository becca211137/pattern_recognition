% self programming
delta_t = 0.1;
f = zeros(1,4)+0.1;
g = zeros(1,4)+0.1;
[null leng_f] = size(f);
[null leng_g] = size(g);
leng_c = leng_f + leng_g - 1;
result = zeros(1,leng_c);
for i = 1:leng_f
    for j = 1:leng_g
        kk = i + j - 1;
        result(1,kk) = f(i)*g(j) + result(1,kk);
    end
end
result = result .* delta_t;
% toolbox
result_toolbox = conv(f,g) .* delta_t;

