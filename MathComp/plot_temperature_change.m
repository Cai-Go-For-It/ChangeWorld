function plot_temperature_change()

    time_h = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, ...
              12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]; % 时刻 (h)

    temperature_c = [15, 14, 14, 14, 14, 15, 16, 18, 20, 22, 23, 25, ...
                     28, 31, 32, 31, 29, 27, 25, 24, 22, 20, 18, 17]; % 温度 (°C)

    figure;
    plot(time_h, temperature_c, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'MarkerFaceColor', 'b');
    
    title('某天气温变化规律');
    xlabel('时刻 (h)');
    ylabel('温度 (°C)');
    grid on;
    
    xticks(0:2:23);
    ylim([min(temperature_c)-2, max(temperature_c)+2]);

end