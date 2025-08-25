function threeStageRocketSimulation()
    % 定义常数
    g0 = 9.81; % 海平面重力加速度 (m/s^2)
    R_earth = 6.371e6; % 地球半径 (m)
    
    % 火箭参数 (示例值，需要根据实际火箭进行调整)
    % 第1级
    m1_initial = 100000; % 初始质量 (kg)
    m1_dry = 20000;    % 干质量 (kg)
    F_T1 = 1.5e6;      % 推力 (N)
    burn_time1 = 120;  % 燃烧时间 (s)
    
    % 第2级
    m2_initial = 30000;  % 初始质量 (kg)
    m2_dry = 5000;     % 干质量 (kg)
    F_T2 = 5e5;        % 推力 (N)
    burn_time2 = 150;  % 燃烧时间 (s)
    
    % 第3级
    m3_initial = 10000;  % 初始质量 (kg)
    m3_dry = 1000;     % 干质量 (kg)
    F_T3 = 1e5;        % 推力 (N)
    burn_time3 = 200;  % 燃烧时间 (s)
    
    % 火箭通用参数
    Cd = 0.5; % 阻力系数
    A = 10;   % 参考面积 (m^2)
    
    % 空气密度模型 (简化的指数模型)
    rho0 = 1.225; % 海平面空气密度 (kg/m^3)
    H_scale = 8500; % 标高 (m)
    
    rho_func = @(h) rho0 * exp(-h / H_scale);
    
    % 燃料消耗率
    mdot1 = (m1_initial - m1_dry) / burn_time1;
    mdot2 = (m2_initial - m2_dry) / burn_time2;
    mdot3 = (m3_initial - m3_dry) / burn_time3;

    % 初始状态 [高度, 速度, 质量]
    initial_state_stage1 = [0; 0; m1_initial];
    
    % --- 第一级飞行 ---
    fprintf('--- 第一级飞行开始 ---\n');
    t_start_stage1 = 0; % 第一级起始时间
    tspan1 = [t_start_stage1 burn_time1];
    [T1, Y1] = ode45(@(t, y) rocketDynamics(t, y, F_T1, mdot1, Cd, A, rho_func, g0, R_earth, t_start_stage1), tspan1, initial_state_stage1);
    
    % 第一级分离后的状态
    % 质量变为第一级干质量 + 第二级初始质量
    initial_state_stage2 = [Y1(end, 1); Y1(end, 2); m1_dry + m2_initial]; 
    
    % --- 第二级飞行 ---
    fprintf('--- 第二级飞行开始 ---\n');
    t_start_stage2 = T1(end); % 第二级起始时间
    tspan2 = [t_start_stage2 t_start_stage2 + burn_time2];
    [T2, Y2] = ode45(@(t, y) rocketDynamics(t, y, F_T2, mdot2, Cd, A, rho_func, g0, R_earth, t_start_stage2), tspan2, initial_state_stage2);
    
    % 第二级分离后的状态
    initial_state_stage3 = [Y2(end, 1); Y2(end, 2); m2_dry + m3_initial]; 
    
    % --- 第三级飞行 ---
    fprintf('--- 第三级飞行开始 ---\n');
    t_start_stage3 = T2(end); % 第三级起始时间
    tspan3 = [t_start_stage3 t_start_stage3 + burn_time3];
    [T3, Y3] = ode45(@(t, y) rocketDynamics(t, y, F_T3, mdot3, Cd, A, rho_func, g0, R_earth, t_start_stage3), tspan3, initial_state_stage3);

    % 联合结果
    T = [T1; T2; T3];
    Y = [Y1; Y2; Y3];
    
    % 绘制结果
    figure;
    subplot(3,1,1);
    plot(T, Y(:,1)/1000); % 高度 (km)
    title('火箭高度 vs. 时间');
    xlabel('时间 (s)');
    ylabel('高度 (km)');
    grid on;
    
    subplot(3,1,2);
    plot(T, Y(:,2)/1000); % 速度 (km/s)
    title('火箭速度 vs. 时间');
    xlabel('时间 (s)');
    ylabel('速度 (km/s)');
    grid on;
    
    subplot(3,1,3);
    plot(T, Y(:,3)); % 质量 (kg)
    title('火箭质量 vs. 时间');
    xlabel('时间 (s)');
    ylabel('质量 (kg)');
    grid on;
end

function dydt = rocketDynamics(t, y, F_T, mdot, Cd, A, rho_func, g0, R_earth, t_start_stage)
    % y(1) = h (高度)
    % y(2) = v (速度)
    % y(3) = m (质量)
    
    h = y(1);
    v = y(2);
    m = y(3);
    
    % 当前时间相对于当前阶段起始时间
    t_relative = t - t_start_stage;

    % 燃料消耗率和推力控制
    current_mdot = mdot;
    current_F_T = F_T;

    % 如果燃料已经耗尽（通过相对时间判断），则推力和燃料消耗率为0
    % 注意：这里的逻辑是简化的，更精确的应该是基于燃料总量的判断
    if t_relative < 0 % 如果时间回退了，这不应该发生，但作为安全检查
        current_mdot = 0;
        current_F_T = 0;
    end
    % 这里需要根据每个阶段的 burn_time 来控制推力和质量变化。
    % 但 ode45 是在给定的 tspan 内运行，所以 mdot 和 F_T 应该在 tspan 内是恒定的。
    % 真正停止燃烧并更新质量的逻辑在主函数中，通过 stage_initial_mass 和 stage_dry_mass 来实现。
    % 因此，rocketDynamics 内部不应直接判断 burn_time。
    % 而是假设在 ode45 的 tspan 范围内，推力和燃料消耗率是有效的。
    % 质量的变化由 -mdot 驱动，当积分到 tspan 结束时，质量自然会接近干质量。
    
    % 重力随高度变化
    g = g0 * (R_earth / (R_earth + h))^2;
    
    % 空气密度
    rho = rho_func(h);
    if h < 0 % 防止高度为负时密度异常，并假设地面以上才有空气阻力
        rho = 0;
    end
    
    % 阻力
    F_D = 0.5 * rho * v^2 * Cd * A;
    
    % 微分方程组
    dydt = zeros(3,1);
    dydt(1) = v;                     % dh/dt = v
    dydt(2) = (current_F_T - F_D - m * g) / m; % dv/dt
    dydt(3) = -current_mdot;         % dm/dt
    
    % 落地条件：如果高度为0且速度为负，停止运动
    if h <= 0 && v < 0
        dydt(1) = 0;
        dydt(2) = 0;
        dydt(3) = 0; % 落地后不消耗燃料
    end
    
    % 确保质量不会变成负值
    if m <= 0 && dydt(3) < 0
        dydt(3) = 0;
    end
end