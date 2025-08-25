
X = [0.6, 0.7, 0.1;  
     0.3, 0.9, 1  ;  
     0.5, 1  , 0.4;  
     0.8, 0.6, 0.9];  
W = [0.3, 0.5, 0.2]; 
[n, m] = size(X);     
X_norm = X ./ sqrt(sum(X.^2, 1));  
X_weight = X_norm .* W; 
Z_pos = max(X_weight);  
Z_neg = min(X_weight);  
D_pos = sqrt(sum((X_weight - Z_pos).^2, 2)); 
D_neg = sqrt(sum((X_weight - Z_neg).^2, 2));  

C = D_neg ./ (D_pos + D_neg);  
[~, rank_idx] = sort(C, 'descend');  

%% 7. 结果输出
disp('原始决策矩阵（修正笔误后）：'); disp(X);
disp('加权标准化矩阵：'); disp(X_weight);
disp('正理想解（各指标最优值）：'); disp(Z_pos);
disp('负理想解（各指标最劣值）：'); disp(Z_neg);
disp('各对象贴近度（越接近1越优）：'); disp(C);
disp('评价对象排名（第1名为最优）：'); disp(rank_idx);