function f = rastrigin2(x1,x2)
    [X1,X2] = meshgrid(x1, x2);
    % [X1,X2] = meshgrid(x1*sin(t), x2*sin(t));
    
    f = 20 + (X1^2 - 10*cos(2*pi*X1)) + (X2^2 - 10*cos(2*pi*X2));

end