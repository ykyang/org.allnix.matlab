classdef SimpleTest < matlab.unittest.TestCase
    %SIMPLETEST Learn MATLAB testing
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    methods (TestClassSetup)
        function setup(me)
            import allnix.obj2str
            
            fprintf(1, 'setup: %s\n', obj2str(me))
        end
        
    end
    methods (Test)
        function testAssertion(me)
            me.verifyEqual(1,1)
        end
        
    end
    
    methods
        
    end
end

