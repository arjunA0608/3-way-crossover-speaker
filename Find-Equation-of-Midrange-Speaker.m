syms s L2 C2 L3 C3 R2 Vi

C2inv = s*C2;
L2inv = 1/(s*L2);
L3inv = 1/(s*L3);
C3inv = s*C3;
R2inv = 1/8;


A = [ (C2inv + L2inv + L3inv),-L3inv; 
    -L3inv,(L3inv + C3inv + R2inv) ];

B = [ Vi * C2inv; 
        0       ];

X = A \ B; 

% Extract Vout (the second element in the vector X)
Vout = X(2);
H = simplify(Vout / Vi);
[num, den] = numden(H);


num_grouped = collect(num, s);
den_grouped = collect(den, s);
% Display them cleanly
disp('Numerator:'); pretty(num_grouped)
disp('Denominator:'); pretty(den_grouped)
