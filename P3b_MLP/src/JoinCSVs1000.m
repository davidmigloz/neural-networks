format long

lineas=1;
for tF = {'traincgb','traincgf'}
    trainF = tF{1};
    disp(trainF)
    for alpha = 0.001:0.001:0.004
        disp(alpha)
        for beta = 0.1:0.2:0.8
            T = readtable(strcat(trainF, '60', num2str(alpha), num2str(beta), '.csv'));
            for linea=1:1:20
                for i=1:1:15
                    futureTable{lineas,i}= T{linea,i};
                end
            end
            lineas = lineas + 1;
        end
    end
end

toBeWritten = cell2table(futureTable);
toBeWritten.Properties.VariableNames = {'funcion_entrenamiento','C','CM1_1','CM1_2','CM1_3','CM2_1','CM2_2','CM2_3','CM3_1','CM3_2','CM3_3', 'tiempo_entrenamiento', 'max_fail','alpha', 'beta'};
writetable(toBeWritten, 'results.csv');