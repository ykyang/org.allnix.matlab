classdef ParforTest < matlab.unittest.TestCase
    %PARFORTEST Summary of this class goes here
    %   Detailed explanation goes here
    %
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.ParforTest);
    %   result = run(suite)
    %   disp(result)
    %   
    %   s = selectIf(suite,'ProcedureName', 'testBatch')
    
    properties (Access = private)
        logger = logging.getLogger('org.allnix');
        
        cluster parallel.Cluster;
        pool parallel.Pool;
        count = 500;
    end

     methods (TestMethodSetup)
        function setup(me)
        me.cluster = parcluster;
        me.cluster.NumWorkers = 48;
        me.cluster.NumThreads = 1;
        
        % delete default pool
%         pool_ = gcp('nocreate');
%         if ~isempty(pool_)
%             delete(pool_);
%             pool_ = parpool(me.cluster);
%         end
%         me.pool = pool_;
        end
        
    end
    
    methods (Test)
        function testParfor(me)
        %Learn parfor
        % count = 500
        % 6.4435 seconds
        %
        % count = 1000
        % 19.1578 seconds
        %
        % count = 2000
        % 31.1955 seconds
        len = me.count;
        start_tic = tic;
        y = me.pmcompute(len,12);
        end_tic = toc(start_tic);
        me.logger.info('max(y) = %g', max(y));
        me.logger.info('Runtime: %g seconds', end_tic);
        end
        
    end
    
    
    methods (Static)
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

