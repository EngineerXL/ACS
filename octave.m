% Вывод пяти знаков
format short g;

[x, y, z] = ndgrid(-10.0 : 0.1 : 10.0, -10.0 : 0.1 : 10.0, -10.0 : 0.1 : 10.0);

u = 11 * x.^2 - 2 * x.*y - 2 * x.*z + 2 * y.*z + 9 * z.^2 - 4 * x + y + z;

a11 = 11;
a22 = 0;
a33 = 9;

a12 = -2 / 2;
a13 = -2 / 2;
a23 = 2 / 2;

a0 = 0;
a1 = -4 / 2;
a2 = 1 / 2;
a3 = 1 / 2;

A = [
    [a11, a12, a13];
    [a12, a22, a23];
    [a13, a23, a33]
];

a = transpose([a1, a2, a3]);

% Получение характеристического многочлена
charPoly = poly(A);
disp("Характеристический многочлен:");
polyout(charPoly, 'l');

% Вычисление собственных значений
eigenvalues = sort(roots(charPoly));
disp("Собственные значения:");
disp(eigenvalues)

[eigenvectors, val] = eig(A);

v1 = eigenvectors(:,1);
v2 = eigenvectors(:,2);
v3 = eigenvectors(:,3);

% Нормировка векторов
nv1 = v1 / dot(v1, v1);
nv2 = v2 / dot(v2, v2);
nv3 = v3 / dot(v3, v3);
S = [nv1, nv2, nv3];
disp("Матрица перехода:")
disp(S)

% Проверка, что матрица получилась диагональная
nA = transpose(S)*A*S;
disp("Полученная диагональная матрица:")
disp(nA)

% Новые коэффициенты
na = transpose(S)*a;

v = eigenvalues(1) * x.^2 + eigenvalues(2) * y.^2 + eigenvalues(3) * z.^2 + na(1) * x + na(2) * y + na(3) * z;

isosurface(u, 0);
figure;
isosurface(v, 0);