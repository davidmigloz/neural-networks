% Script basico para entrenar una red neuronal con el algorimo 'traincgb' y
% 20 neuronas ya que estos son los resultados mejores que hemos podido
% lograr con el Thyroid Dataset. 
% Como nota a parte cabe decir que se hace el entrenamiento en modo visual
% para mejorar la experiencia de los usuarios de el script.
%
[ inputs, targets ] = thyroid_dataset;
net = patternnet(20, 'traincgb');
net = train(net, inputs ,targets);
[totalError, confMatrix, ~, ~] =                                        ...
        confusion(targets, net(inputs*0.95));
    
disp(strcat('El error total (*0.95) es: ', num2str(totalError)))

[totalError, matrizConf, nonUsed1, nonUsed2] =                          ...
        confusion(targets, net(inputs*1.05));
    
disp(strcat('El error total (*1.05) es: ', num2str(totalError)))