
datos = nngenc([0 5;0 5;0 5], 7, 200, 0.30);
figure
plot3(datos(1,:),datos(2,:),datos(3,:), '.g');
grid on
writetable(table(datos), 'datos.csv');