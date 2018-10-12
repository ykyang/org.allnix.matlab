classdef SimpleTest < matlab.unittest.TestCase
    %SIMPLETEST Learn MATLAB testing
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods (Test)
        function testAssertion(me)
            me.verifyEqual(1,1)
        end
        
    end
end

