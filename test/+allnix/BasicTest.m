classdef BasicTest < matlab.unittest.TestCase
    %BASICTEST Summary of this class goes here
    %   Detailed explanation goes here
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.BasicTest);
    %   result = run(suite)
    %   disp(result)    
    
    properties
        logger = logging.getLogger('org.allnix')
    end
    
    methods (Test)
        function testString(me)
            % horizontal array concatenation, [s1, s2, ..., sN]
            % preserves tailing white spaces
            s = ['a ', 'b ', 'c'];
            me.assertEqual(s, 'a b c');
            
            % strcat removes tailing white spaces
            s = strcat(' a ', ' b ', ' c ');
            me.assertEqual(s, ' a b c');
        end
    end
end

