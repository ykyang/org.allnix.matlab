% Create a Java button
f = figure;
jButton = javacomponent(javax.swing.JButton('click me'), [20,20,80,20], gcf);
disp('jButton');
disp(jButton);
% Assign a Matlab callback
%hButton = handle(jButton, 'CallbackProperties');
hButton = handle(jButton);
disp('hButton');
disp(hButton);
set(hButton, 'ActionPerformedCallback', @myCallback);
%jButton.ActionPerformedCallback = @myCallback;
 
%st = struct;
%sh = handle(st);

jb = javax.swing.JButton('click me');
jbh = handle(jb);
disp('jbh');
disp(jbh);

% Matlab callback function
function myCallback(hObject, hEventData)
    disp(hObject);
    disp(hEventData);
    % Insert your code here
    disp('Hello');
end