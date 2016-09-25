n=10;
[ inputs, targets ] = thyroid_dataset;
avg_c = 0;
avg_cm=[0 0 0; 0 0 0; 0 0 0];
for train_f={'trainscg', 'traincgp'}
    train_func = train_f{1};
    for n_neurons=10:10:30
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
        train_func, ''' el error medio es: ''', num2str(C),''''));
        disp(strcat('La matriz de confusion media es: '))
        avg_cm
        %waitforbuttonpress
    end
    
end