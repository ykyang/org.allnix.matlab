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
        function testReadBigFile(me)
        dq = parallel.pool.DataQueue;
        % future @ FevalFuture
        me.logger.info('TimeStamp');
        future = parfeval(me.pool, @me.simReadBigFile, 1, 'filename', dq); 
        me.logger.info('TimeStamp');
        % The memory is doubled at this point
        value = fetchOutputs(future);
        me.logger.info('TimeStamp');
        me.assertEqual(size(value,1),1e8); 
        end
        
        
        function testParfeval(me)
        len = 10000;
        answer = (1+len)*len/2;
        freq = 1000;
        % f FevalFuture
        dq = parallel.pool.DataQueue;
        
        f = parfeval(me.pool, @allnix.ParfevalTest.compute, 1, len, freq, dq);
        ol = dq.afterEach(@me.mydisp);
        
        me.logger.info('class: %s', class(ol));
        me.logger.info('objectListener: %s', allnix.obj2str(ol));
        
        value = fetchOutputs(f);
        me.assertEqual(value, answer);
        end
        
    end
    methods
        function mydisp(me, value)
        me.logger.info('%g', value);
        end
        
        function answer = simReadBigFile(me, filename, dq)
        answer = ones(1e8, 1);
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

