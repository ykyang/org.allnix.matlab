classdef HfServiceTest < matlab.unittest.TestCase
    %HFSERVICETEST Summary of this class goes here
    %   Detailed explanation goes here
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.HfServiceTest);
    %   result = run(suite)
    %   disp(result)
    properties (Access = private)
        logger = logging.getLogger('org.allnix');
        hfSvc allnix.HfService;
    end
    properties
        
        
    end
    methods (TestMethodSetup)
        function init(me)
        me.hfSvc = allnix.HfService();
        end
    end
    
    methods (Test)
        function testTimer(me)
        %Test timer created by the service
        job = me.hfSvc.loadData('not important');
        htimer = me.hfSvc.createTimer(job);
        
        % caller has a chance to set StopFcn here

        htimer.start()
        
        % caller goes into event loop
        % call pause() or drawnow from time to time to allow timer 
        % to check for job status
        
        % finally wait for the job to finish
        htimer.wait();
        
        delete(htimer);
        
        % check job status
        me.assertTrue(me.hfSvc.isDone(job));
        % remove job
        me.hfSvc.deleteJob(job);
        % job is no longer in Service DB
        me.assertFalse(me.hfSvc.hasJob(job));
        end
        
        
    end
    methods
        function checkJob(me, hTimer, event, job)
        fprintf(1, 'Checking Job: %s\n', job.getId());
        if me.hfSvc.isDone(job)
            stop(hTimer);
        end
        end
        
        
        function testLoadData(me)
        %Deprecated
        %
        % block with while loop
        %
        job = me.hfSvc.loadData('test');
        
        chk = timer;
        chk.TimerFcn = {@me.checkJob, job};
        chk.ExecutionMode = 'fixedSpacing';
        chk.Period = 0.5;
        
        start(chk);
        
        while (1)
            if strcmp(chk.Running,'off')
                break;
            end
            % Update progress bar etc
            pause(0.1);
        end
        delete(chk); % absolutly necessary
        v = me.hfSvc.deleteJob(job);
        %clear job;
        me.assertTrue(v);
        
        
        
        %
        % block with wait()
        %
        job = me.hfSvc.loadData('test');
        
        chk = timer;
        chk.TimerFcn = {@me.checkJob, job};
        chk.ExecutionMode = 'fixedSpacing';
        chk.Period = 0.5;
        chk.TasksToExecute = intmax('int64') - 1e3; % stupid matlab
                
        start(chk);
        % batch mode waiting to exit
        wait(chk);
        delete(chk); % absolutly necessary
        v = me.hfSvc.deleteJob(job);
        %clear job;
        me.assertTrue(v);
        
        
        
        end % function
    end
end





