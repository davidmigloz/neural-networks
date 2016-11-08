% Script que entrena una red neuronal variando el número de neuronas de  la
% capa oculta y el algoritmo de entrenamiento. Además, con cada
% configuración el entrenamiento se repite n veces para disminuir la
% varianza y aleatoriedad.
% Salida: trainAlg \n (numNeuronas, valConfusion)...
% Salida: results.txt 

[ inputs, targets ] = thyroid_dataset;
n=20; % Nº de reentrenos

avg_c = 0; % Valor de confusión medio (% de muestras clasificadas mal)
avg_cm=zeros(3); % Matriz de confusión media

avg_time=0;

% Nombres que va a tener la futura tabla por columnas
arrayForFutureTable = cell(7);

iter = 1;%En que fila del array se debe escribir
for tF = {'traincgf', 'traincgb'}
    trainF = tF{1};
    disp(trainF)
    for max_fail = 10:10:100
        disp(max_fail)
        for alpha = 0.001:0.001:0.004
            disp(alpha)
            for beta = 0.1:0.2:0.8
                disp(beta)
                %Reset values
                avg_time = 0;
                avg_c = 0;
                avg_cm = zeros(3);

                for reduce_variance=1:1:n
                    net = patternnet(20, trainF);
                    net.trainParam.alpha = alpha;
                    net.trainParam.beta = beta;
                    net.trainParam.max_fail = max_fail;
                    net.trainParam.showWindow = false;
                    initial_time = cputime;
                    [net, tr] = train(net, inputs ,targets);
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
                %fprintf('(%d,%f)',n_neurons,avg_c);
                % Save data in a cell 
                arrayForFutureTable = {trainF, avg_c,       ...
                    avg_cm(1,:), avg_cm(2,:), avg_cm(3,:), avg_time, max_fail, alpha, beta}; 
                
                % Write table to file
                toBeWritten = array2table(arrayForFutureTable);
                toBeWritten.Properties.VariableNames = {'funcion_entrenamiento','avg_c','C1','C2','C3', 'tiempo_entrenamiento', 'max_fail','alpha', 'beta'};
                writetable(toBeWritten, strcat(trainF, num2str(max_fail), num2str(alpha), num2str(beta), '.csv'));
                saveas(plotperform(tr), strcat(trainF, num2str(max_fail), num2str(alpha), num2str(beta), '.png'));
                
            end
            %fprintf('\n');
        end
    end
end