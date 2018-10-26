classdef JsonTest < matlab.unittest.TestCase
    %Learn handling JSON in MATLAb
    %   Detailed explanation goes here
    %
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.JsonTest);
    %   result = run(suite)
    %   disp(result)
    properties
       logger = logging.getLogger('org.allnix')
       dataDir @ char = 'data'
       instruction @ struct;
    end
    
    methods (Test)
        function testJson(me)
        x = struct();
        x.well.name = "Well A";
        x.well.length = 9990.0;
        
        jsonString = jsonencode(x);
        me.logger.info("JSON: %s", jsonString);
        
        end
        
        function testReadJson(me)
            filePath = fullfile(me.dataDir, 'instruction.json');
            instructionText = fileread(filePath);
            me.instruction = jsondecode(instructionText);
            me.assertEqual(me.instruction.NofCores, 1);
            me.assertEqual(me.instruction.LogData, 'LogData.csv');
            me.assertEqual(getfield(me.instruction, 'LogData'), 'LogData.csv');
            
            % a field that does not exist
            me.assertFalse(isfield(me.instruction, 'NotHere'));
        end
        
        function testJavaJson(me)
            import java.util.HashMap
            import java.io.File
            import com.fasterxml.jackson.databind.ObjectMapper
            
            file = fullfile(pwd, 'data/instruction.json');
            file = File(file);
            mapper = ObjectMapper;
            
            jsonNode = mapper.readTree(file);
            
            node = jsonNode.get('LogData');
            disp(node.asText());
            %disp(class(jsonNode));
        end
    end
end

