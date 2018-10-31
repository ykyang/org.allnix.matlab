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
        pool = gcp();
    end
    
    methods (TestMethodSetup)
        
    end
    
    methods (Test)
        function testFirst(me)
                
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
        len = 100;
        y = me.pcompute(len);
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
        j = batch(@allnix.BatchTest.compute, 1, {100});
        wait(j);
        r = fetchOutputs(j);
        me.logger.info('batch compute: %g', r{1,1});
        end
        
        function testNestedBatch(me)
        j = batch(@allnix.BatchTest.pcompute, 1, {100}, 'Pool', 4);
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
    end
end

