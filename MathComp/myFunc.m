function y = myFunc(x)
% This function defines a piecewise function.
% y = x + 1, if x > 1
% y = 2 * x, if -1 <= x <= 1
% y = x - 1, if x < -1

    if x > 1
        y = x + 1;
    elseif x >= -1 && x <= 1
        y = 2 * x;
    else % x < -1
        y = x - 1;
    end
end
