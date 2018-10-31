hSemaphore = handle(javax.swing.JButton);  % waitfor() expects a handle() object, not a "naked" Java reference

run = timer;
run.TimerFcn = {@(hTimer, event, h) h.setEnabled(true), hSemaphore };
run.StartDelay = 1;

start(run);

isDone = waitForDone(hSemaphore, 60);

disp(isDone);
disp(hSemaphore.isEnabled());

% Wait for data updates to complete (isDone = false if timeout, true if event has arrived)
function isDone = waitForDone(hSemaphore, timeout)
    % Initialize: timeout flag = false
    hSemaphore.setEnabled(false);
 
    % Create and start the separate timeout timer thread
    hTimer = timer('TimerFcn',@(h,e)hSemaphore.setEnabled(true), 'StartDelay',timeout);
    start(hTimer);
 
    % Wait for the object property to change or for timeout, whichever comes first
    waitfor(hSemaphore,'Enabled');
 
    % waitfor is over - either because of timeout or because the data changed
    % To determine which, check whether the timer callback was activated
    isDone = isvalid(hTimer) && hTimer.TasksExecuted == 0;
 
    % Delete the timer object
    try stop(hTimer);   catch, end
    try delete(hTimer); catch, end
 
    % Return the flag indicating whether or not timeout was reached
end  % waitForDone