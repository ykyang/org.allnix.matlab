f = figure;
panel = uipanel('Parent', f);

parent = panel;
plot = axes(parent);




surf(plot, peaks);

% must be after surf()
plot.CameraViewAngleMode = 'manual';
plot.Projection = 'perspective';
