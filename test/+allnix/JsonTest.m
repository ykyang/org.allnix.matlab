classdef JsonTest < matlab.unittest.TestCase
    %Learn handling JSON in MATLAb
    %   Detailed explanation goes here
    %
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.JsonTest);
    %   result = run(suite)
    %   disp(result)
    properties
       logger = logging.getLogger('org.allnix')
    end
    
    methods (Test)
        function testJson(me)
        x = struct();
        x.well.name = "Well A";
        x.well.length = 9990.0;
        
        jsonString = jsonencode(x);
        me.logger.info("JSON: %s", jsonString);
        
        end
    end
end

