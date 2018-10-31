
button = handle(javax.swing.JButton);
button.setEnabled(false);

learn_timer_loop(button);

%learn_event_loop(button);

% t = timer;
% t.Period = 1;
% t.ExecutionMode = 'fixedSpacing';
% t.TimerFcn = @check;
% t.UserData = button;
% start(t);


function check(hTimer, event)
%disp("hTimer: " + class(hTimer));
%disp(hTimer);l
%disp("event: " + class(event));
%disp(event);
if hTimer.UserData.isEnabled()
    stop(hTimer);
    return;
end
disp(hTimer.Name);

end


function learn_timer_loop(button)
t1 = timer;
set(t1, 'Name', 'timer-1');
t1.Period = 1.3;
t1.ExecutionMode = 'fixedSpacing';
t1.TimerFcn = @check;
t1.UserData = button;

t2 = timer;
set(t1, 'Name', 'timer-2');
t2.Period = 1.7;
t2.ExecutionMode = 'fixedSpacing';
t2.TimerFcn = @check;
t2.UserData = button;

start(t1);
start(t2);

%waitfor(button, 'Enabled', true);
%wait([t1, t2]);

end

function learn_event_loop(button)
t = timer;
set(t, 'Period', 1);
set(t, 'ExecutionMode', 'fixedSpacing');
%set(t, 'TimerFcn', @(event, data) disp('Timer rollover!'));
t.TimerFcn = @check;
t.TasksToExecute = 2;

start(t);

while(1)
    %# do something interesting
    %drawnow;
    pause(0.1); % pause calls drawnow
    if button.isEnabled() 
        break;
    end
end
end