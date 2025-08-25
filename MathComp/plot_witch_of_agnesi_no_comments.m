function plot_witch_of_agnesi_no_comments()

    a = 2;

    figure;

    subplot(1, 3, 1);
    x_plot = -10:0.01:10;
    y_plot = (8 * a^3) ./ (x_plot.^2 + 4 * a^2);
    plot(x_plot, y_plot, 'r-.');
    title('Plot 方法');
    xlabel('x');
    ylabel('y');
    grid on;
    
    subplot(1, 3, 2);
    func_fplot = @(x) (8 * a^3) ./ (x.^2 + 4 * a^2);
    fplot(func_fplot, [-10, 10], 'r-.');
    title('Fplot 方法');
    xlabel('x');
    ylabel('y');
    grid on;

    subplot(1, 3, 3);
    fplot(func_fplot, [-10, 10], 'r-.');
    title('Ezplot 方法' );
    xlabel('x');
    ylabel('y');
    grid on;

    sgtitle('箕舌线 y = 8a^3 / (x^2 + 4a^2) (a=2) 的三种绘制方法');

end