classdef BatchTest < matlab.unittest.TestCase
    %Learn batch of Parallel Toolbox
    %   Learn basic stuff
    %
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.BatchTest);
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
        pool_ = gcp('nocreate');
        if ~isempty(pool_)
            delete(pool_);
        end
            
        %me.pool = parpool(me.cluster, me.cluster.NumWorkers);
%         if me.pool.NumWorkers < me.cluster.NumWorkers
%             delete(gcp('nocreate'));
%             me.pool = parpool(me.cluster, me.cluster.NumWorkers);
%         end
        end
        
    end
    
    methods (Test)
        
        
        function testMultipleParfeval(me)
                
        %cluster = parcluster;
        for i = 1:5
            f(i) = parfeval(me.pool, @allnix.BatchTest.compute, 1, 100);
        end
        
        for i = 1:5
            %sum = fetchOutputs(f);
            [idx, result] = fetchNext(f);
            me.logger.info('sum(%g) = %g', idx, result);
        end
        end
        
        
        function testParfor(me)
        % 70 seconds
        len = me.count;
        y = me.pmcompute(len,1);
        me.logger.info('max(y) = %g', max(y));
        end
        
        function testParfor4(me)
        % 18.5432 seconds
        len = me.count;
        y = me.pmcompute(len,4);
        me.logger.info('max(y) = %g', max(y));
        end
        
        function testParfor8(me)
        % 9.1968 seconds
        len = me.count;
        y = me.pmcompute(len,8);
        me.logger.info('max(y) = %g', max(y));
        end
        
%         function testNested(me)
%         %Does not work
%         %
%         len = 1000;
%         f = parfeval(pool, @allnix.BatchTest.pcompute, 1, len, 4);
%         y = fetchOutputs(f);
%         disp('nested');
%         disp(y(len));
%         end
        
        function testBatch(me)
        %Learn simple batch
        %   There is an overhead associated with batch jobs
        %   runtime = 7.3832 seconds 
        start_tic = tic;
        j = batch(me.cluster, @allnix.BatchTest.compute, 1, {100});
        wait(j);
        end_tic = toc(start_tic);
        
        me.logger.info('class(j): %s', class(j));
        me.logger.info('\n%s', allnix.obj2str(j));
        r = fetchOutputs(j);
        me.logger.info('batch compute: %g', r{1,1});
        me.logger.info('Runtime: %g seconds', end_tic);
        me.logger.info('Compute Time: %s', j.FinishDateTime - j.StartDateTime);
        disp(j.FinishDateTime - j.StartDateTime);
        
        end
        
        function testParforBatch(me)
        j = batch(@allnix.BatchTest.pcompute, 1, {me.count}, 'Pool', 1);
        wait(j);
        cellArray = fetchOutputs(j);
        y = cellArray{1,1};
        me.logger.info('testParforBatch: max(y) = %g', max(y));
        end
        
        
        
        function testParforBatch4(me)
        % 29.6861 ~ 70/4 + 12 seconds
        j = batch(me.cluster, @allnix.BatchTest.pcompute, 1, {me.count}, 'Pool', 4);
        wait(j);
        cellArray = fetchOutputs(j);
        y = cellArray{1,1};
        me.logger.info('testParforBatch: max(y) = %g', max(y));
        end
        
        
        function testParforBatch8(me)
        % 21.7165 ~ 70/8 + 12 seconds
        j = batch(me.cluster, @allnix.BatchTest.pcompute, 1, {me.count}, 'Pool', 8);
        wait(j);
        cellArray = fetchOutputs(j);
        y = cellArray{1,1};
        me.logger.info('testParforBatch8: max(y) = %g', max(y));
        end
        
        function testParforBatch12(me)
        % count = 500
        % Runtime: 17.841 ~ 70/12 + 12 seconds
        % Compute Time: 11 seconds
        %
        % count = 1000
        % Runtime: 24.0462 seconds
        % Compute Time: 17 seconds
        %
        % count = 2000
        % Runtime: 36.2574 seconds
        % Compute Time: 29 second
        start_tic = tic;
        
        j = batch(me.cluster, @allnix.BatchTest.pcompute, 1, {me.count}, 'Pool', 12);
        wait(j);
        
        end_tic = toc(start_tic);
                
        cellArray = fetchOutputs(j);
        y = cellArray{1,1};
        me.logger.info('testParforBatch12: max(y) = %g', max(y));
        me.logger.info('Runtime: %g seconds', end_tic);
        me.logger.info('Compute Time: %s', j.FinishDateTime - j.StartDateTime);
        end
        
        function testParforBatch24(me)
        % 17.2614 > 70/24 + 12 seconds
        j = batch(me.cluster, @allnix.BatchTest.pcompute, 1, {me.count}, 'Pool', 24);
        wait(j);
        cellArray = fetchOutputs(j);
        y = cellArray{1,1};
        me.logger.info('testParforBatch24: max(y) = %g', max(y));
        end
        
        function testNestedBatch(me)
        % 1 core: 24.5964
        % 2 core: 18.5469
        % 4 core: 14.55
        
        j = batch(me.cluster, @allnix.BatchTest.pcompute, 1, {1000}, 'Pool', 10);
        wait(j);
        
        cellArray = fetchOutputs(j);
        y = cellArray{1,1};
        me.logger.info('max(y) = %g', max(y));
        %me.logger.info('length(r{1})'
        %disp('nested batch');
        %disp(r{1});
        end
    end
    
    
    methods (Static)
        function sum= compute(n)
        sum = 0;
        for i = 1:n
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

