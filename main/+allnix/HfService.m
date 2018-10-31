classdef HfService < handle
    %HFSERVICE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       
        jsvc = org.allnix.hf.DefaultHfService();
    end
    
    methods (Access = public)
        function job = loadData(me, uri)
        % I/O heavy stuff
        job = me.jsvc.loadData(uri);
        end
        
        function bool = deleteJob(me, job)
        %Remove a job from the service's DB
        bool = me.jsvc.delete(job);
        end
                
        function bool = hasJob(me, job)
        bool = me.jsvc.hasJob(job);
        end
        
        function bool = isDone(me, job)
        %Check if a job is done
        %   return true if the job is done
        bool = me.jsvc.isDone(job);
        end
        
        function htimer = createTimer(me, job)
        %Convenient method to create a timer for caller to track the job
        %   
        %   The timer is created this way:
        %
        %   htimer = timer;
        %   htimer.TimerFcn = {@me.checkJob, job};
        %   htimer.ExecutionMode = 'fixedSpacing';
        %   htimer.Period = 0.5;
        %   htimer.TasksToExecute = intmax('int64') - 1e3
        %   
        %   It is the caller's responsibility to delete the timer.
        
        htimer = timer;
        htimer.TimerFcn = {@me.checkJob, job};
        htimer.ExecutionMode = 'fixedSpacing';
        htimer.Period = 0.5;
        htimer.TasksToExecute = intmax('int64') - 1e3; % stupid matlab
        end
        
        function checkJob(me, htimer, ~, job)
        %Convenient method to stop the timer if the job is done
        %
        %   The missing argument is event
        
        if me.jsvc.isDone(job)
            stop(htimer);
        end
        end
    end
   
end

