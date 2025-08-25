% solve_tsp10_heuristic.m

% --- 辅助函数：计算路径总长度 ---
function total_len = calculate_path_length(path, dist_matrix)
    total_len = 0;
    num_cities = length(path);
    for i = 1:(num_cities - 1)
        total_len = total_len + dist_matrix(path(i), path(i+1));
    end
    % 回到起始城市
    total_len = total_len + dist_matrix(path(num_cities), path(1));
end

% --- 主脚本 ---
% 问题一：10个城市的最短总路程问题 (MATLAB - 启发式算法)

% 距离矩阵
D = [
    0,  7,  4,  5,  8,  6, 12, 13, 11, 18;
    7,  0,  3, 10,  9, 14,  5, 14, 17, 17;
    4,  3,  0,  5,  9, 10, 21,  8, 27, 12;
    5, 10,  5,  0, 14,  9, 10,  9, 23, 16;
    8,  9,  9, 14,  0,  7,  8,  7, 20, 19;
    6, 14, 10,  9,  7,  0, 13, 12, 16, 15;
    12,  5, 21, 10,  8, 13,  0, 19, 16, 20;
    13, 14,  8,  9,  7, 12, 19,  0, 10, 11;
    11, 17, 27, 23, 20, 16, 16, 10,  0, 14;
    18, 17, 12, 16, 19, 15, 20, 11, 14,  0
];

num_cities = size(D, 1);

disp('-----------------------------------------------');
disp('问题一：10个城市的最短总路程问题 (启发式算法)');

% --- 1. 最邻近算法生成初始路径 ---
% 尝试从每个城市出发，找到最好的初始路径
best_initial_path = [];
min_initial_length = inf;

for start_node = 1:num_cities
    current_path = zeros(1, num_cities);
    visited = false(1, num_cities);
    current_node = start_node;
    current_path(1) = current_node;
    visited(current_node) = true;

    for i = 2:num_cities
        min_dist = inf;
        next_node = -1;
        for j = 1:num_cities
            if ~visited(j) && D(current_node, j) < min_dist
                min_dist = D(current_node, j);
                next_node = j;
            end
        end
        if next_node ~= -1
            current_path(i) = next_node;
            visited(next_node) = true;
            current_node = next_node;
        else
            % Should not happen in a connected graph
            break;
        end
    end

    current_path_length = calculate_path_length(current_path, D);
    if current_path_length < min_initial_length
        min_initial_length = current_path_length;
        best_initial_path = current_path;
    end
end

fprintf('最邻近算法初始路径: %s\n', num2str(best_initial_path));
fprintf('最邻近算法初始总路程: %f\n', min_initial_length);

% --- 2. 2-opt 改进算法 ---
current_path = best_initial_path;
current_length = min_initial_length;
improved = true;

while improved
    improved = false;
    for i = 1:(num_cities - 1)
        for k = (i + 1):num_cities
            % 创建新路径 (2-opt 交换操作)
            new_path = current_path;
            % 交换路径段：i+1 到 k 之间反转
            new_path(i+1:k) = fliplr(current_path(i+1:k));

            new_length = calculate_path_length(new_path, D);

            if new_length < current_length
                current_path = new_path;
                current_length = new_length;
                improved = true;
                % 一旦有改进就重新开始循环，因为新的交换可能会带来更多改进
                break;
            end
        end
        if improved
            break;
        end
    end
end

fprintf('2-opt 改进后的最佳路径: %s\n', num2str(current_path));
fprintf('2-opt 改进后的最短总路程: %f\n', current_length);
disp('-----------------------------------------------');