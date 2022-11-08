# Simplex

code for simplex method in matrix notation.

## Usage

### Primal

```matlab
N = [
    2 1 1 3;
    1 3 1 2
];
B = eye(2);
c = [6 8 5 9];
c = [c zeros(1, 2)]';
b = [5 3]';

A = [N B];
B_idx = [col + 1:row + col];
N_idx = [1:col];

[B, B_idx, N, N_idx, optimal] = primal_simplex(A, b, c, B_idx, N_idx, 0)
```

### Dual

```matlab
N = [
    -2 7;
    -3 1;
    9 -4;
    1 -1;
    7 -3;
    -5 -2;
];
c = [-1 -2];
b = [6 -1 6 1 6 3]'

[row, col] = size(N);
B = eye(row);
c = [c zeros(1, row)]';
A = [N B];
B_idx = [col + 1:row + col];
N_idx = [1:col];

[B_idx, N_idx, x, z, optimal] = dual_simplex(A, b, c, B_idx, N_idx, 0)
```

### Dual-Primal Two Phase

```matlab
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
```

## ToDo

* [ ] function to generate initial dictionary
* [ ] ranging
* [ ] parametric self-dual