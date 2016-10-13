datos = readtable('datos.csv');
t_data = table2array(datos);

for dis={'dist', 'linkdist', 'mandist', 'boxdist'}
    d = dis{1};
    for grd= {'gridtop', 'hextop', 'randtop'}
        g = grd{1};
        for neig=2:1:7
            for gridDim=7:1:10
                
                net = selforgmap([gridDim gridDim], 100, neig, g, d);
                net.trainParam.epochs = 500;
                net.trainParam.showWindow = false;
                net = configure(net, t_data);
                net = train(net, t_data);
                saveas(plotsomnd(net), strcat('dists-', d, '_' ,g, '_lado-',int2str(gridDim), '_vec-', int2str(neig),'.png'));
                saveas(plotsomhits(net, t_data), strcat('hits-', d, '_' ,g, '_lado-',int2str(gridDim), '_vec-', int2str(neig),'.png'));
                saveas(plotsompos(net, t_data), strcat('pos-', d, '_' ,g, '_lado-',int2str(gridDim), '_vec-', int2str(neig),'.png'));
               
            end
        end
    end
end