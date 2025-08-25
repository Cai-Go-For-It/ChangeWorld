% 1. 输入数据
data = [
    95.3, 29.4, 331.1, 47.2;
    96.3, 26.9, 332.9, 42.0;
    95.9, 24.7, 329.4, 50.6;
    97.3, 28.4, 356.6, 67.5;
    98.1, 28.8, 365.7, 40.9;
    97.0, 25.4, 332.4, 41.3;
    97.2, 25.5, 333.3, 42.1
];

% 指标类型：1代表正向指标（越大越好），-1代表负向指标（越小越好）
indicator_type = [1, 1, -1, -1]; 

% 2. 数据标准化 (Min-Max 标准化)
[num_years, num_indicators] = size(data);
standardized_data = zeros(num_years, num_indicators);

for j = 1:num_indicators
    if indicator_type(j) == 1 % 正向指标
        min_val = min(data(:, j));
        max_val = max(data(:, j));
        standardized_data(:, j) = (data(:, j) - min_val) / (max_val - min_val);
    else % 负向指标
        min_val = min(data(:, j));
        max_val = max(data(:, j));
        standardized_data(:, j) = (max_val - data(:, j)) / (max_val - min_val);
    end
end

disp('标准化后的数据:');
disp(standardized_data);

% 3. 计算客观权重 (熵值法)
% 避免log(0)的情况，给数据加上一个非常小的常数，或者在归一化时处理
epsilon = 1e-6; % 避免log(0)的微小常数

% 数据归一化 for entropy method (使其非负且每列和为1)
normalized_for_entropy = standardized_data + epsilon; % 确保所有值都大于0
col_sums = sum(normalized_for_entropy);
p_ij = normalized_for_entropy ./ col_sums;

% 计算熵值
e_j = zeros(1, num_indicators);
for j = 1:num_indicators
    temp = p_ij(:, j) .* log(p_ij(:, j));
    temp(isnan(temp)) = 0; % 处理 log(0) 导致的 NaN (如果原始数据中存在0)
    e_j(j) = -sum(temp) / log(num_years);
end

% 计算差异系数
d_j = 1 - e_j;

% 计算客观权重
objective_weights = d_j / sum(d_j);

disp('客观权重 (熵值法):');
disp(objective_weights);

% 4. 确定主观权重 (示例，你可以根据实际情况调整)
% 假设主观认为四个指标权重分别为：好转率30%，床位周转次数20%，平均病床工作日25%，平均费用值25%
subjective_weights = [0.30, 0.20, 0.25, 0.25]; 

% 检查主观权重和是否为1
if sum(subjective_weights) ~= 1
    warning('主观权重之和不为1，已自动归一化。');
    subjective_weights = subjective_weights / sum(subjective_weights);
end

disp('主观权重:');
disp(subjective_weights);

% 5. 计算综合集成权重
% w = 0.6w1 + 0.4w2
combined_weights = 0.6 * subjective_weights + 0.4 * objective_weights;

% 归一化最终权重，以防万一（虽然理论上应该已经归一化了）
combined_weights = combined_weights / sum(combined_weights);

disp('综合集成权重:');
disp(combined_weights);

% 6. 计算综合得分
composite_scores = standardized_data * combined_weights';

disp('各年份综合得分:');
for i = 1:num_years
    fprintf('第 %d 年: %.4f\n', i, composite_scores(i));
end

% 对得分进行排序和评价
[sorted_scores, sorted_indices] = sort(composite_scores, 'descend');

disp('------------------------------------------');
disp('医疗工作质量综合评价:');
for i = 1:num_years
    fprintf('第 %d 名: 第 %d 年, 得分 %.4f\n', i, sorted_indices(i), sorted_scores(i));
end

% 可视化结果
years = 1:num_years;
figure;
bar(years, composite_scores);
xlabel('年份');
ylabel('综合得分');
title('各年份医疗工作质量综合得分');
grid on;