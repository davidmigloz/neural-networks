n_algoritmos = 2;
n_neuronas = 150;

T = readtable('results150.csv');
for i=1:1:n_algoritmos
    % Valor de confusión
    disp(T{n_neuronas*(i-1)+1,1})
    for j=1:1:n_neuronas
        n_neurons = T{(n_neuronas*(i-1)) + j, 2};
        avg_c = T{(n_neuronas*(i-1)) + j, 3};
        fprintf('(%d,%f)',n_neurons,avg_c);
    end
    fprintf('\n');
    % Tiempo de entrenamiento
    for j=1:1:n_neuronas
        n_neurons = T{(n_neuronas*(i-1)) + j, 2};
        avg_t = T{(n_neuronas*(i-1)) + j, 13};
        fprintf('(%d,%f)',n_neurons,avg_t);
    end
    fprintf('\n----\n');
end