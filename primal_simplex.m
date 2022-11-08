function [B_idx, N_idx, x, z, optimal] = primal_simplex(A, b, c, B_idx, N_idx, verbose)

    # init dictionary
    N = A(:, N_idx);
    B = A(:, B_idx);
    l = length(B_idx) + length(N_idx);
    x = zeros(l, 1);
    z = zeros(l, 1);
    x(B_idx) = inv(B) * b - inv(B) * N * x(N_idx);
    z(N_idx) = (inv(B) * N)' * c(B_idx) - c(N_idx) + (inv(B) * N)' * z(B_idx);

    counter = 1;

    # step 1 check for optimality
    while ~all(z >= 0)
        # step 2 select entering variable
        [z_min, j_idx] = min(z(N_idx));
        j = N_idx(j_idx);

        # step 3 compute primal step direction
        e_j = zeros(length(N_idx), 1);
        e_j(j_idx) = 1;
        delta_x_B = inv(B) * N * e_j;

        # step 4 compute primal step length
        [t, i_idx] = max(delta_x_B ./ x(B_idx));
        t = t^(-1);

        # step 5 select leaving variable
        i = B_idx(i_idx);

        # step 6 compute dual step direction
        e_i = zeros(length(B_idx), 1);
        e_i(i_idx) = 1;
        delta_z_N = -(inv(B) * N)' * e_i;

        # step 7 compute dual step length
        s = z(j) / delta_z_N(j_idx);

        # step 8 update current primal and dual solutions
        x(j_idx) = t;
        x(B_idx) = x(B_idx) - t * delta_x_B;
        z(i) = s;
        z(N_idx) = z(N_idx) - s * delta_z_N;

        # step 9 update basis
        B_idx(find(B_idx == i)) = j;
        N_idx(find(N_idx == j)) = i;

        B = A(:, B_idx);
        N = A(:, N_idx);

        if verbose
            fprintf("Iteration %d\n", counter);
            z_min
            j
            delta_x_B
            t
            i
            delta_z_N
            s
            B_idx
            N_idx
            B
            N
            current_x = x(B_idx)
            current_z = z(N_idx)
            fprintf("-------------------------------\n\n")
        end

        counter = counter + 1;
    end

    optimal = dot(c(B_idx), x(B_idx));

end
