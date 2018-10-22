
function p = dt (x)

d=size(x);
x=[x x(:,1)];
p=0;

for i = [1:d(2)]
	p += x(1,i)*x(2,i+1);
	p -= x(2,i)*x(1,i+1);
endfor

abs(p);

endfunction
