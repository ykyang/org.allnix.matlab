classdef ParfevalRunnerTest < matlab.unittest.TestCase
    %PARFEVALRUNNERTEST Summary of this class goes here
    %   Detailed explanation goes here
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.ParfevalRunnerTest);
    %   result = run(suite)
    %   disp(result)
    %   
    %   s = selectIf(suite,'ProcedureName', 'testBatch')
    
    properties
        logger = logging.getLogger('org.allnix');
        
        cluster parallel.Cluster;
        pool parallel.Pool;
        runner allnix.ParfevalRunner;
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
        
        me.runner = allnix.ParfevalRunner;
        me.runner.pool = me.pool;
        end
    end
    
    
    methods (Test)
        function test1(me)
%         job = me.runner.run(@me.one, 1, 15);
%         ret = fetchOutputs(job);
%         me.assertEqual(class(ret), 'cell');
%         me.assertEqual(ret{1}, 15);
        end
        
        function testInCellOut2(me)
        %Learn
        %   In: 1 cell array
        %   Out: 2 values
        job = me.runner.run(@me.inCellOut2, 2, {13,17});
        [out1, out2] = fetchOutputs(job);
        %me.logger.info('class(ret): %s', class(ret));
        %me.logger.info('class(ret1): %s', class(ret1));
        %me.logger.info('size(ret): %s', allnix.obj2str(size(ret)));
        %me.assertEqual(class(ret), 'cell');
        
        
%        me.assertEqual(size(ret), [1,1]);
        
        me.assertEqual(out1, 13);
        me.assertEqual(out2, 17);
        end
        
        function testInCellOutCell(me)
        %Learn
        %   This is the easiest way.
        %   In: 1 cell array
        %   Out: 1 cell array
        
        job = me.runner.run(@me.inCellOutCell, 1, {5,7,11});
        out = fetchOutputs(job);
        
        me.assertEqual(size(out,2), 3);
        me.assertEqual(out{1}, 5);
        me.assertEqual(out{2}, 7);
        me.assertEqual(out{3}, 11);
        
        end
    
    end
    
    methods
        function ret1 = one(me, arg1)
        ret1 = arg1;
        end
        
        function [out1, out2] = inCellOut2(me, data)
        %
        %   data: cell array
        out1 = data{1};
        out2 = data{2};
        end
        
        function out = inCellOutCell(me, data)
        out = data;
        end
    end
end

