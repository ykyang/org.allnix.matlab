classdef CellTest < matlab.unittest.TestCase
    %Learn cell in MATLAB
    %   Detailed explanation goes here
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.CellTest);
    %   result = run(suite)
    %   disp(result)
    
    properties

    end
    
    methods (Test)
        function testBasicOperation(me)
            c ={1, 2, 3;'a', 'b', 'c'};
           
            disp(['class: ' , class(c), 1, 2, '34']);
           
        end
    end
end

