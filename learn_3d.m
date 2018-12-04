f = figure;
plot = axes(f);
grid on;
hold on;



xlabel('x');
ylabel('y');
zlabel('z');

%pbaspect([1 1 10]);

axis([0 100 0 200 0 100]);
plot.CameraViewAngleMode = 'manual';
plot.Projection = 'perspective';
%plot.Clipping = 'off';
plot.Position = [0.22 0.22 0.56 0.56];


p1 = [0 0 0];
p2 = [20 50 20];
p3 = [30 80 80];
p4 = [90 180 90];



width = 2.0;
drawCylinder([p1 p2 width], 'FaceColor', 'g');
drawCylinder([p2 p3 width], 'FaceColor', 'r');
drawCylinder([p3 p4 width], 'FaceColor', 'y');

set(f, 'renderer', 'opengl');

%daspect([1 1 0.25]);



%axis equal;
%light;