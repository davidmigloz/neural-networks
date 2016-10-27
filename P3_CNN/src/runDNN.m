


imdsTrain = imageDatastore(fullfile(pwd,'cifar10Train'),            ...
    'IncludeSubfolders',true,'LabelSource','foldernames');

imdsTest = imageDatastore(fullfile(pwd, 'cifar10Test'),             ...
        'IncludeSubfolders',true,'LabelSource','foldernames');


for momentum=0.3:0.1:0.7
    for inLearningRate=0.01:0.02:0.09
        for learnRateDropFactor=0.08:0.01:0.12
            for learnRateDropPeriod=8:1:12
                for maxEpochs=10:10:50
                    for redVar=1:1:10
                        
                        [net,time] = initAndTrainDNN(imdsTrain, momentum,...
                            inLearningRate, learnRateDropFactor,        ...
                            learnRateDropPeriod, maxEpochs);
                        
                        [confusionValue , confusionMatrix, ~, ~] = confusion(targets, net(inputs));
                        
                        arrayForTable = { momentum, inLearningRate,     ...
                            learnRateDropFactor, learnRateDropPeriod,   ...
                            maxEpochs, confusionValue,                  ...
                            flatten(confusionMatrix)};
                        
                        toBeWritten = array2table(arrayForFutureTable);
                        toBeWritten.Properties.VariableNames = {'Momentum','Initial Learning Rate','Learn Rate Drop Factor','Learn Rate Drop Period','Max Epochs','Confusion Value', 'Confusion Matrix(Flattened)'};
                        writetable(toBeWritten, strcat(num2str(momentum),...
                            num2str(inLearningRate), num2str(learnRateDropFactor),...
                            num2str(learnRateDropPeriod), num2str(maxEpochs)));
                        
                    end
                end
            end
        end
    end
end
