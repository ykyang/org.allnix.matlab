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
        me.cluster.NumWorkers = 48;
        
        pool_ = gcp('nocreate');
        if ~isempty(pool_)
            delete(pool_);
        end
        pool_ = parpool(me.cluster, 24);
        me.pool = pool_;
        pool_ = parpool(me.cluster, 12);
        end
    end
    methods (Test)
        function test(me)
        end
    end
    methods
       
    end
end

