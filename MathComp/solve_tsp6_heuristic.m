% 文件名: solve_tsp6_heuristic.m

% 问题二：6个城市的最短总路程问题 (MATLAB - 启发式算法)

% 距离矩阵
% 城市名称对应：1-新乡, 2-北京, 3-上海, 4-广州, 5-深圳, 6-杭州
D = [
    0,   620,  983, 1526, 1608,  975;
    620,   0, 1203, 2123, 2172, 1278;
    983, 1203,    0, 1436, 1461,  185;
    1526, 2123, 1436,    0,  143, 1247;
    1608, 2172, 1461,  143,    0, 1269;
    975, 1278,  185, 1247, 1269,    0
];

num_cities = size(D, 1);

disp('-----------------------------------------------');
disp('问题二：6个城市的最短总路程问题 (启发式算法)');

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
        
        % 寻找当前节点未访问过的最近邻城市
        for j = 1:num_cities
            if ~visited(j) && D(current_node, j) < min_dist
                min_dist = D(current_node, j);
                next_node = j;
            end
        end
        
        % 将最近邻城市添加到路径中
        if next_node ~= -1
            current_path(i) = next_node;
            visited(next_node) = true;
            current_node = next_node;
        else
            % 如果找不到下一个未访问的城市，这通常不应该发生
            % 但为了健壮性，可以加入此判断
            break; 
        end
    end

    % 计算当前初始路径的总长度
    current_path_length = calculate_path_length(current_path, D);

    % 更新最佳初始路径
    if current_path_length < min_initial_length
        min_initial_length = current_path_length;
        best_initial_path = current_path;
    end
end

fprintf('最邻近算法初始路径: %s\n', num2str(best_initial_path));
fprintf('最邻近算法初始总路程: %f\n', min_initial_length);

% --- 2. 2-opt 改进算法 ---
% 从最佳初始路径开始改进
current_path = best_initial_path;
current_length = min_initial_length;
improved = true; % 标记是否还有改进空间

% 持续迭代直到无法再通过2-opt操作改进
while improved
    improved = false;
    for i = 1:(num_cities - 1) % 选择第一个断点 i
        for k = (i + 1):num_cities % 选择第二个断点 k
            % 2-opt 交换操作：反转路径段 (i+1) 到 k 之间的城市顺序
            % 例如，路径 1-2-3-4-5，如果 i=1, k=3，则反转 2-3-4
            % 得到 1-4-3-2-5
            new_path = current_path;
            new_path(i+1:k) = fliplr(current_path(i+1:k)); % fliplr 反转数组

            % 计算新路径的长度
            new_length = calculate_path_length(new_path, D);

            % 如果新路径更短，则更新当前最佳路径
            if new_length < current_length
                current_path = new_path;
                current_length = new_length;
                improved = true; % 标记为已改进，继续下一轮循环
                break; % 找到一个改进就跳出内层循环，重新从头开始找新的改进
            end
        end
        if improved % 如果在内层循环中找到了改进，也跳出外层循环，重新开始找新的改进
            break;
        end
    end
end

fprintf('2-opt 改进后的最佳路径: %s\n', num2str(current_path));
fprintf('2-opt 改进后的最短总路程: %f\n', current_length);
disp('-----------------------------------------------');

% 清理变量（可选，为了防止下次运行残留）
clear D num_cities best_initial_path min_initial_length ...
      start_node current_path visited current_node i j ...
      min_dist next_node current_path_length k new_path new_length ...
      improved;