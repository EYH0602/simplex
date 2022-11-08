function [B_idx, N_idx, x, z, optimal] = dual_simplex(A, b, c, B_idx, N_idx, verbose)
    # init dictionary
    N = A(:, N_idx);
    B = A(:, B_idx);
    l = length(B_idx) + length(N_idx);
    x = zeros(l, 1);
    z = zeros(l, 1);
    x(B_idx) = inv(B) * b - inv(B) * N * x(N_idx);
    z(N_idx) = (inv(B) * N)' * c(B_idx) - c(N_idx) + (inv(B) * N)' * z(B_idx);

    counter = 1;

    while ~all(x >= 0)
        [x_min, i_idx] = min(x(B_idx));
        i = B_idx(i_idx);

        e_i = zeros(length(B_idx), 1);
        e_i(i_idx) = 1;
        delta_z_N = -(inv(B) * N)' * e_i;

        [s, j_idx] = max(delta_z_N ./ z(N_idx));
        s = s^(-1);

        j = N_idx(j_idx);

        e_j = zeros(length(N_idx), 1);
        e_j(j_idx) = 1;
        delta_x_B = inv(B) * N * e_j;

        t = x(i) / delta_x_B(i_idx);

        x(j) = t;
        x(B_idx) = x(B_idx) - t * delta_x_B;
        z(i) = s;
        z(N_idx) = z(N_idx) - s * delta_z_N;

        B_idx(find(B_idx == i)) = j;
        N_idx(find(N_idx == j)) = i;

        B = A(:, B_idx);
        N = A(:, N_idx);

        if verbose
            fprintf("Iteration %d\n", counter);
            x_min
            i
            delta_z_N
            s
            j
            delta_x_B
            t
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
