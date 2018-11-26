classdef InputParserTest < matlab.unittest.TestCase
    %INPUTPARSERTEST Summary of this class goes here
    %   Detailed explanation goes here
    %
    %   suite = matlab.unittest.TestSuite.fromClass(?org.allnix.InputParserTest);
    %   result = run(suite)
    %   disp(result)
    
    properties (Constant)
        logger = org.allnix.getLogger('org.allnix.InputParserTest');
    end
    
    properties
        Property1
    end
    
    methods (Test)
        function test(me)
        me.readVarargin(2.0, 3.0, 'c', 5, 'd', 7);
        end
    end
    
    methods
        function readVarargin(me, varargin)
        p = inputParser();
        p.CaseSensitive = true;
        p.PartialMatching = false;
        
        p.addRequired('a');
        p.addOptional('b', 13.0);
        p.addParameter('c', 17.0);
        p.addParameter('d', 19.0);
        
        p.parse(varargin{:});
        r = p.Results;
        
        me.assertEqual(r.a, 2);
        me.assertEqual(r.c, 5);
        
        
        
        end
        
    end
end

