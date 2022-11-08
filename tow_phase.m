N = [
    -1 -1 -1;
    2 -1 1;
];

c_N = [-1 -1 -1];

b = [-2 1]';

B = eye(2);
c = [c_N zeros(1, 2)]';
A = [N B];
B_idx = [4, 5];
N_idx = [1, 2, 3];

[B_idx, N_idx, x, z, optimal] = dual_simplex(A, b, c, B_idx, N_idx, 0)


c = [2 -6 0 0 0]';
[B_idx, N_idx, x, z, optimal] = primal_simplex(A, b, c, B_idx, N_idx, 0)
