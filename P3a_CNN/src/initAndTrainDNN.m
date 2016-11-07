function [ net, trainTime ] = initAndTrainDNN(dataset, momentum, inLearningRate,...
    learnRateDropFactor, learnRateDropPeriod, maxEpochs )
%INITDNN Summary of this function goes here
%   Detailed explanation goes here

% Definicion de las capas que conforman la red (13 ocultas)
    convol1 = convolution2dLayer(5,32,'Padding',2,                      ...
                         'BiasLearnRateFactor',2);
    convol1.Weights = gpuArray(single(randn([5 5 3 32])*0.0001));
    convol2 = convolution2dLayer(5,32,'Padding',2,'BiasLearnRateFactor',2);
    convol3 = convolution2dLayer(5,64,'Padding',2,'BiasLearnRateFactor',2);

    pooling1 = maxPooling2dLayer(3,'Stride',2);
    pooling2 = averagePooling2dLayer(3,'Stride',2);
    pooling3 = averagePooling2dLayer(3,'Stride',2);

    fullyconn1 = fullyConnectedLayer(64,'BiasLearnRateFactor',2);
    fullyconn1.Weights = gpuArray(single(randn([64 576])*0.1));
    fullyconn2 = fullyConnectedLayer(10,'BiasLearnRateFactor',2);
    fullyconn2.Weights = gpuArray(single(randn([10 64])*0.1));


    layers = [                                                          ...
        imageInputLayer([32 32 3]); % 32x32x3 es el tama?o de las imagenes
        convol1;
        pooling1;
        reluLayer();
        convol2;
        reluLayer();
        pooling2;
        convol3;
        reluLayer();
        pooling3;
        fullyconn1;
        reluLayer();
        fullyconn2;
        softmaxLayer()
        classificationLayer()];
    
    % Establecimiento de la opciones de entrenamiento
    opts = trainingOptions('sgdm',                                      ...
        'Momentum', momentum,                                           ...0.5
        'InitialLearnRate', inLearningRate,                             ...0.01
        'LearnRateDropFactor', learnRateDropFactor,                     ...0.1
        'LearnRateDropPeriod', learnRateDropPeriod,                     ...5
        'MaxEpochs', maxEpochs,                                         ...10
        'LearnRateSchedule', 'piecewise',                               ...
        'L2Regularization', 0.004,                                      ...
        'MiniBatchSize', 100,                                           ...
        'Verbose', true);
    % Definicion de los datos de entrenamiento
    
    tInicio = tic;
    [net, ~] = trainNetwork(dataset, layers, opts);
    trainTime =  toc(tInicio);

end

