% Script que entrena una red neuronal variando el número de neuronas de  la
% capa oculta y el algoritmo de entrenamiento. Además, con cada
% configuración el entrenamiento se repite n veces para disminuir la
% varianza y aleatoriedad.

[ inputs, targets ] = thyroid_dataset;
n=10; % Nº de reentrenos

avg_c = 0; % Valor de confusión medio (% de muestras clasificadas mal)
avg_cm=[0 0 0; 0 0 0; 0 0 0]; % Matriz de confusión media

for train_f={'trainscg', 'traincgp'}
    train_func = train_f{1};
    for n_neurons=5:5:30
        for reduce_variance=1:1:n
            net = autoTrain(n_neurons, inputs, targets, train_func);
            [C,CM,IND,PER] = confusion(targets, net(inputs));
            avg_c  = avg_c  + C ;
            avg_cm = avg_cm + CM;
            %plotconfusion(targets , net(inputs))
        end
        avg_c = avg_c/n;
        avg_cm = avg_cm./n;
        disp(strcat('Para ''',int2str(n_neurons),''' neuronas entrenadas con ''', ...
        train_func, ''' el error medio es: ''', num2str(avg_c),''''));
        disp(strcat('La matriz de confusion media es: '));
        disp(avg_cm);
        %waitforbuttonpress
    end
end