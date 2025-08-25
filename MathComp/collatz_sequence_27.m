function collatz_sequence_27()

    n = 27; 
    fprintf('开始计算 n = %d 的柯拉兹序列：\n', n);
    fprintf('%d', n); 
    
    steps = 0; 
    
    while n ~= 1
        if mod(n, 2) == 0 
            n = n / 2;
        else 
            n = n * 3 + 1;
        end
        fprintf(' -> %d', n); 
        steps = steps + 1; 
    end
    
    fprintf('\n运算结束。总步数：%d\n', steps);

end