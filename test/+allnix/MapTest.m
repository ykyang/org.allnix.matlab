classdef MapTest < matlab.unittest.TestCase
    % Summary of this class goes here
    %   Detailed explanation goes here
    %
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.MapTest);
    %   result = run(suite)
    %   disp(result)
    
    properties
        logger = logging.getLogger('org.allnix')
    end
    
    methods (Test)
        function testCreateMapObject(me)
            % Learn creating Map
            % https://www.mathworks.com/help/matlab/matlab_prog/creating-a-map-object.html
            % 
            
            %import allnix.obj2str
            
            map = containers.Map();
            %me.logger.info('%s', obj2str(map));
            me.assertTrue(map.Count == 0);
            me.assertEqual(map.Count, uint64(0));
        end
        function testReadWrite(me)
            map = containers.Map('KeyType', 'char', 'ValueType', 'int64');
            
            %map(5) = 'five';
            map('five') = 5;
            me.assertEqual(map('five'), int64(5));
            
            map = containers.Map('KeyType', 'int64', 'ValueType', 'char');
            map(5) = 'five';
            me.assertEqual(map(5), 'five')
        end
    end
end

