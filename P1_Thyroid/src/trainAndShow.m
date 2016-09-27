% Script que entrena una red neuronal variando el número de neuronas de  la
% capa oculta y el algoritmo de entrenamiento. Además, con cada
% configuración el entrenamiento se repite n veces para disminuir la
% varianza y aleatoriedad.
% Salida: trainAlg \n (numNeuronas, valConfusion)...
% Salida: results.txt 

[ inputs, targets ] = thyroid_dataset;
n=10; % Nº de reentrenos

avg_c = 0; % Valor de confusión medio (% de muestras clasificadas mal)
avg_cm=zeros(3); % Matriz de confusión media

avg_time=0; 

% Nombres que va a tener la futura tabla por columnas
arrayForFutureTable = cell(7);

iter = 1;%En que fila del array se debe escribir

%Funciones de entrenamiento posibles
train_functions = { 'trainbfg', 'trainrp', 'trainscg', 'traincgb',...
    'traincgf', 'traincgp', 'trainoss',  'traingdx'
};

for train_f=train_functions
    train_func = train_f{1};
    disp(train_func);
    for n_neurons=1:1:100
        %Reset values
        avg_time = 0;
        avg_c = 0;
        avg_cm = zeros(3);
        
        for reduce_variance=1:1:n
            initial_time = cputime;
            net = autoTrain(n_neurons, inputs, targets, train_func);
            time = cputime - initial_time;
            [C,CM,IND,PER] = confusion(targets, net(inputs));
            avg_c  = avg_c  + C ;
            avg_cm = avg_cm + CM;
            avg_time = avg_time + time;
            %plotconfusion(targets , net(inputs))
        end
        avg_time = avg_time/n;
        avg_c = avg_c/n;
        avg_cm = avg_cm./n;
        
        % Human readable
        %fprintf('Para %d neuronas entrenadas con %s el error medio es: %f\n',n_neurons,train_func,avg_c);
        %disp('La matriz de confusion media es:');
        %disp(avg_cm);
        
        % pgfplots format
        fprintf('(%d,%f)',n_neurons,avg_c);
        % Save to an array to save in the future
        arrayForFutureTable(iter, :) = {train_f, n_neurons, avg_c,...
            avg_cm(1,:), avg_cm(2,:), avg_cm(3,:), avg_time}; 
        iter=iter+1;
    end
    fprintf('\n');
end
% Write table to file
toBeWritten = array2table(arrayForFutureTable);
toBeWritten.Properties.VariableNames = {'funcion_entrenamiento','n_neurons','avg_c','C1','C2','C3', 'tiempo_entrenamiento'};
writetable(toBeWritten, 'results');