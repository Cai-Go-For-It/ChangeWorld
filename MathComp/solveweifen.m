A = [2, -3, 3;
     4, -5, 3;
     4, -4, 2];

[V, D] = eig(A);

lambda1 = D(1,1);
lambda2 = D(2,2);
lambda3 = D(3,3);

v1 = V(:,1);
v2 = V(:,2);
v3 = V(:,3);

disp('系数矩阵 A:');
disp(A);
disp('特征值 (lambda):');
disp(diag(D));
disp('特征向量 V:');
disp(V);

syms t c1 c2 c3

X_t_sym = c1 * exp(lambda1 * t) * v1 + ...
          c2 * exp(lambda2 * t) * v2 + ...
          c3 * exp(lambda3 * t) * v3;

disp('微分方程组的通解 (符号表示):');
disp('x(t) = ');
disp(X_t_sym(1));
disp('y(t) = ');
disp(X_t_sym(2));
disp('z(t) = ');
disp(X_t_sym(3));