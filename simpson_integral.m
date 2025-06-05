clc;
clear;

% Datos
a = 0;
b = 1.5;
n = 6; % debe ser par
h = (b - a) / n;

% Función
f = @(x) exp(-x.^2);

% Puntos x y f(x)
x = a:h:b;
y = f(x);

% Aplicar regla de Simpson 1/3
I_simpson = y(1) + y(end);
for i = 2:n
    if mod(i,2) == 0
        I_simpson = I_simpson + 4*y(i);
    else
        I_simpson = I_simpson + 2*y(i);
    end
end
I_simpson = (h/3) * I_simpson;

fprintf('Integral aproximada con Simpson 1/3: %.6f\n', I_simpson);

% Valor medio estimado de la cuarta derivada de f(x) 
% f(x) = exp(-x^2)
% f''''(x) se deriva manualmente o con symbolic toolbox
syms xs;
f4 = diff(exp(-xs^2), xs, 4);
f4_func = matlabFunction(f4);

% Evaluamos f''''(x) en varios puntos del intervalo y hallamos el valor medio
x_vals = linspace(a, b, 100);
f4_vals = abs(f4_func(x_vals));
f4_mean = mean(f4_vals);

fprintf('Valor medio de la cuarta derivada en [%.1f, %.1f]: %.6f\n', a, b, f4_mean);

% Estimación del error de truncamiento de Simpson 1/3
% Error <= ((b - a)^5 / (180 * n^4)) * max|f''''(x)|

E = ((b - a)^5 / (180 * n^4)) * f4_mean;
fprintf('Error de truncamiento estimado: %.8f\n', E);

% Valor exacto dado
I_exacta = 1.085853;
error_real = abs(I_exacta - I_simpson);
fprintf('Error real (|exacta - aproximada|): %.8f\n', error_real);
