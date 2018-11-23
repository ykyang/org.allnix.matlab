classdef ParfevalTest < matlab.unittest.TestCase
    %PARFEVALTEST Summary of this class goes here
    %   Detailed explanation goes here
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.ParfevalTest);
    %   result = run(suite)
    %   disp(result)
    %   
    %   s = selectIf(suite,'ProcedureName', 'testBatch')
    properties
        logger = logging.getLogger('org.allnix');
        
        cluster parallel.Cluster;
        pool parallel.Pool;
        count = 500;
    end
    
    methods (TestMethodSetup)
        function setup(me)
        me.cluster = parcluster;
        
        coreCount = feature('numcores');
        
        % workers = 2 * cores
        me.cluster.NumWorkers = min(512, coreCount * 2);
        me.pool = gcp('nocreate');
        if isempty(me.pool)
            me.pool = parpool(me.cluster, coreCount);
        end
        % pool size = cores
%         pool_ = gcp('nocreate');
%         if ~isempty(pool_)
%             delete(pool_);
%         end
%         pool_ = parpool(me.cluster, coreCount);
%         me.pool = pool_;
        end
    end
    methods (Test)
        function testException(me)
        %Test catching exception thrown in parallel language construct
        
        future = parfeval(me.pool, @me.throwError, 1, 'not important');
        
        out = [];
        try    
            % any exception occured on the worker node
            % happens during fetch
            out = fetchOutputs(future);
        catch ME
            switch ME.identifier
                case 'parallel:fevalqueue:ExecutionErrors'
                    % Expected exception
                    me.logger.info('worker exception: %s', allnix.obj2str(ME));
                    %me.logger.info('%s', getReport(ME));
                    me.logger.info('Cause: %s', allnix.obj2str(ME.cause{:}));
                otherwise
                    rethrow(ME)
            end
        end
        end
        
        function testReadBigFile(me)
        %Use parfeval as non-blocking I/O
        %   In addition to the actual I/O time
        %   400MB/second transfer rate on my laptop
        dq = parallel.pool.DataQueue;
        % future @ FevalFuture
        startTime = tic;
        me.logger.info('Start non-blocking I/O');
        future = parfeval(me.pool, @me.simReadBigFile, 1, 'filename', dq); 
        me.logger.info('After calling parfeval');
        % The memory is doubled at this point
        value = fetchOutputs(future);
        runtime = toc(startTime);
        me.logger.info('Runtime: %g seconds', runtime);
        me.logger.info('Transfered %g doubles', size(value,1)*size(value,2));
                
        me.assertEqual(size(value,1),1e8); 
        end
                
        function testParfeval(me)
        %Learn how to do basic parfeval call
        
        len = 10000;
        answer = (1+len)*len/2;
        freq = 1000;
        % f FevalFuture
        dq = parallel.pool.DataQueue;
        
        f = parfeval(me.pool, @allnix.ParfevalTest.compute, 1, len, freq, dq);
        %ol = afterEach(dq, @me.mydisp);
        ol = afterEach(dq, @(x) me.logger.info('received: %g', x));
        
        me.logger.info('class: %s', class(ol));
        me.logger.info('objectListener: %s', allnix.obj2str(ol));
        
        value = fetchOutputs(f);
        me.assertEqual(value, answer);
        end
        
    end
    methods
        
        function answer = simReadBigFile(me, filename, dq)
        %Simulate reading a big file of 800 MB
        %   Actual I/O time are not included
        %   Main purpose is to measure overhead in addition to
        %   I/O time.
        answer = ones(1e8, 1);
        end
    
        function out = throwError(me, in)
        throw(MException('org:allnix:UnsupportedOperation','Error'));
        end
    end
    
    
    methods (Static)
        function sum= compute(len, freq, dq)
        sum = 0;
        for i = 1:len
            if mod(i,freq) == 0
                dq.send(i);
            end
            sum = sum + i;
        end
        end
        
        function a = pcompute(len)
        n = len;
        A = 500;
        a = zeros(1,n);
        parfor i = 1:n
            a(i) = max(abs(eig(rand(A))));
        end
        end
        
        function a = pmcompute(len,m)
        n = len;
        A = 500;
        a = zeros(1,n);
        parfor (i = 1:n,m)
            a(i) = max(abs(eig(rand(A))));
        end
        end
    end
end

