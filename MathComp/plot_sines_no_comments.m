function plot_sines_no_comments()
    x = -2*pi : 0.01 : 2*pi;

    y1 = sin(x);
    y2 = sin(2*x);
    y3 = sin(4*x);
    y4 = sin(8*x);

    figure;

    plot(x, y1, 'b-', 'DisplayName', 'y_1 = sin(x)');
    hold on;
    plot(x, y2, 'r--', 'DisplayName', 'y_2 = sin(2x)');
    plot(x, y3, 'g:', 'DisplayName', 'y_3 = sin(4x)');
    plot(x, y4, 'm-.', 'DisplayName', 'y_4 = sin(8x)');
    hold off;

    legend show;
    title('不同频率正弦函数的波形');
    xlabel('x');
    ylabel('y');
    grid on;

    xlim([-2*pi, 2*pi]);
    ylim([-1.2, 1.2]);
    
    xticks(-2*pi : pi/2 : 2*pi);
    xticklabels({'-2\pi', '-3\pi/2', '-\pi', '-\pi/2', '0', '\pi/2', '\pi', '3\pi/2', '2\pi'});
end