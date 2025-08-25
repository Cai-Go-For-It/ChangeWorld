function plot_3d_surface()

    x = -5:0.1:5;
    y = -5:0.1:5;

    [X, Y] = meshgrid(x, y);

    Z = X .* Y .* exp(-(X.^2 + Y.^2) / 4);

    figure;
    surf(X, Y, Z);
    
    title('空间曲面 z = xy e^{-(x^2+y^2)/4}');
    xlabel('x');
    ylabel('y');
    zlabel('z');
    colorbar;
    shading interp;
    light;
    lighting phong;

end