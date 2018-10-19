classdef SetTest < matlab.unittest.TestCase
    %Learn sets in MATLAB
    %   
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.SetTest);
    %   result = run(suite)
    %   disp(result)
    properties
        logger = logging.getLogger('org.allnix')
    end
    
    methods (Test)
        function testBasicOperation(me)
            
            s1 = {'a', 'b', 'c'};
            me.logger.info('%s', class(s1));
            
        end
    end
end

