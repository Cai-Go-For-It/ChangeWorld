function display_random_name()
    my_name = 'cai';
    figure; 
    axis equal; 
    xlim([0 1]);
    ylim([0 1]); 
    box on; 
    hold on; 
    font_size = randi([20, 60]); 
    font_color = rand(1, 3);
    rotation_angle = rand() * 360; 
    text_x = rand() * 0.8 + 0.1; 
    text_y = rand() * 0.8 + 0.1; 
    text(text_x, text_y, my_name, ...
         'FontSize', font_size, ...
         'Color', font_color, ...
         'Rotation', rotation_angle, ...
         'HorizontalAlignment', 'center', ... 
         'VerticalAlignment', 'middle'); 

    title('显示姓名'); 
    
    hold off;  

end