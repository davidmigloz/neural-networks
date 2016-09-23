function [ net ] = autoTrain(n_neurons, inputs, targets, train_function,...
    ratios)
%AUTOTRAIN Funcion de entrenamiento automatizado
%   Recibe como parametos: 
%   	  n_neurons        ->  Numero de neuronas
%   	  inputs           ->  Entradas del dataset
%         targets          ->  Objetivos del dataset
%   [opt] train_function   ->  Funcion de entrenamiento como string 
%   [opt] ratios[2]        ->  Ratios para la cantidad de informacion en
%                               cada set [train_ratio, validation_ratio]
%                               el valor de la suma de ellos debera ser 
%                               menor de 1
%   
%   Devuelve la red ya entrenada
%
%   Cabe considerar que la funcion abrira una ventana de como esta yendo el
%   aprendizaje.
%   Si no se introduce train_function se usa 'trainscg'
%   Si no se introducen los ratios se usan [0.70 , 0.15]
%   

    if ~exist('train_function', 'var') 
        net = patternnet(n_neurons);
    else
        net = patternnet(n_neurons,train_function);
    end
    if exist('ratios', 'var')
        net.divideParam.trainRatio = ratios(1);
        net.divideParam.valRatio = ratios(2);
        net.divideParam.testRatio = 1-ratios(1)-ratios(2);
    end
    net = train(net,inputs ,targets);
end