% --- 6个城市TSP问题 (使用最近邻算法) ---

clear; clc;

% 1. 定义距离矩阵 D6
D6 = [
    0   620   983  1526  1608   975;
    620   0  1203  2123  2172  1278;
    983  1203   0  1436  1461   185;
    1526  2123  1436   0   143  1247;
    1608  2172  1461   143   0  1269;
    975  1278   185  1247  1269    0
];

cities_names = {'新乡', '北京', '上海', '广州', '深圳', '杭州'};
N = size(D6, 1); % 城市数量

% 2. 最近邻算法实现
% 循环多次，从每个城市作为起点运行最近邻算法，以找到更好的解
min_total_distance = inf;
best_path_indices = [];

for start_city_idx = 1:N
    current_path = zeros(1, N + 1); % 路径：N个城市 + 回到起点
    visited = false(1, N);         % 记录城市是否被访问过
    
    current_city = start_city_idx;
    current_path(1) = current_city;
    visited(current_city) = true;
    current_distance = 0;
    
    for i = 2:N
        % 寻找距离当前城市最近且未访问的城市
        min_dist_to_next = inf;
        next_city = -1;
        
        for j = 1:N
            if ~visited(j) % 如果城市j未被访问
                if D6(current_city, j) < min_dist_to_next
                    min_dist_to_next = D6(current_city, j);
                    next_city = j;
                end
            end
        end
        
        if next_city ~= -1
            current_path(i) = next_city;
            visited(next_city) = true;
            current_distance = current_distance + min_dist_to_next;
            current_city = next_city;
        else
            break; 
        end
    end
    
    % 从最后一个城市回到起点
    current_distance = current_distance + D6(current_city, start_city_idx);
    current_path(N+1) = start_city_idx;
    
    % 更新最佳路径和距离
    if current_distance < min_total_distance
        min_total_distance = current_distance;
        best_path_indices = current_path;
    end
end

% 3. 结果输出
fprintf('--- 6个城市TSP问题 (使用最近邻算法) ---\n');
fprintf('最近邻算法求解结果：\n');
fprintf('最短总距离: %.2f km\n', min_total_distance);

% 显示路径名称
if ~isempty(best_path_indices)
    path_display_names = cities_names(best_path_indices(1:end-1)); % 移除重复的起点
    
    route_str = path_display_names{1};
    for k = 2:length(path_display_names)
        route_str = [route_str, ' -> ', path_display_names{k}];
    end
    route_str = [route_str, ' -> ', path_display_names{1}]; % 回到起始城市名称

    fprintf('近似最佳路线: %s\n', route_str);
    fprintf('注意：最近邻算法是启发式算法，不保证找到最优解，但通常能找到一个良好的近似解。\n');
    fprintf('\nPDF中给出的最优解距离为 4946 km。\n');
else
    fprintf('未能找到有效路径。\n');
end