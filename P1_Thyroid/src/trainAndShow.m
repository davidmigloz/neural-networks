% Script que entrena una red neuronal variando el n�mero de neuronas de  la
% capa oculta y el algoritmo de entrenamiento. Adem�s, con cada
% configuraci�n el entrenamiento se repite n veces para disminuir la
% varianza y aleatoriedad.

[ inputs, targets ] = thyroid_dataset;
n=10; % N� de reentrenos

avg_c = 0; % Valor de confusi�n medio (% de muestras clasificadas mal)
avg_cm=[0 0 0; 0 0 0; 0 0 0]; % Matriz de confusi�n media

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