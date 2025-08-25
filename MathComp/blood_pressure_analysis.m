% Part (1)
data = [
    144, 39, 24.2, 0;
    215, 47, 31.1, 1;
    138, 45, 22.6, 0;
    145, 47, 24, 1;
    162, 65, 25.9, 1;
    142, 46, 25.1, 0;
    170, 67, 29.5, 1;
    124, 42, 19.7, 0;
    158, 67, 27.2, 1;
    154, 56, 19.3, 0;
    162, 64, 28, 1;
    150, 56, 25.8, 1;
    140, 59, 27.3, 0;
    110, 34, 20.1, 0;
    128, 42, 21.7, 0;
    130, 48, 22.2, 1;
    135, 45, 27.4, 0;
    114, 18, 18.8, 0;
    116, 20, 22.6, 0;
    124, 19, 21.5, 0;
    136, 36, 25, 0;
    142, 50, 26.2, 1;
    120, 39, 23.5, 0;
    120, 21, 20.3, 0;
    160, 44, 27.1, 1;
    158, 53, 28.6, 1;
    144, 63, 28.3, 0;
    130, 29, 22, 1;
    125, 25, 25.3, 0;
    175, 69, 27.4, 1
];

y = data(:, 1); % 血压
x1 = data(:, 2); % 年龄

X1 = [ones(size(x1)), x1];
b1 = X1 \ y;

age_range = [50, 60];
pred_bp_50 = b1(1) + b1(2) * age_range(1);
pred_bp_60 = b1(1) + b1(2) * age_range(2);

fprintf('Part (1):\n');
fprintf('Estimated average blood pressure for 50 years old: %.2f\n', pred_bp_50);
fprintf('Estimated average blood pressure for 60 years old: %.2f\n', pred_bp_60);

% Part (2)
x2 = data(:, 3); % 体重指数
x3 = data(:, 4); % 吸烟习惯

X2 = [ones(size(x1)), x1, x2, x3];
b2 = X2 \ y;

age_pred = 50;
bmi_pred = 25;
smoking_pred = 1; % 1 for smoker

pred_bp_new = b2(1) + b2(2) * age_pred + b2(3) * bmi_pred + b2(4) * smoking_pred;

fprintf('\nPart (2):\n');
fprintf('Predicted blood pressure for a 50-year-old smoker with BMI 25: %.2f\n', pred_bp_new);