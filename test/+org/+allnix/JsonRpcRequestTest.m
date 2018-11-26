classdef JsonRpcRequestTest < matlab.unittest.TestCase
    %JSONRPCREQUESTTEST Summary of this class goes here
    %   Detailed explanation goes here
    %   suite = matlab.unittest.TestSuite.fromClass(?org.allnix.JsonRpcRequestTest);
    %   result = run(suite)
    %   disp(result)
    
    properties (Constant)
        logger = org.allnix.getLogger('org.allnix.JsonRpcRequestTest');
    end
    properties (Access = private)
        dataDir = fullfile(pwd, 'data');
    end
    methods (Test)
        function test(me)
        file = fullfile(me.dataDir, 'jsonrpc.json');
        
        req = org.allnix.JsonRpcRequest();
        req.loadFromFile(file);
       
        me.assertEqual(req.getVersion(), '2.0');
        me.assertEqual(req.getMethod(), 'subtract');
        me.assertEqual(req.getId(), 3);
        params = req.getParams();
        me.assertEqual(params.subtrahend, 23);
        me.assertEqual(params.minuend, 42);
        end
    end
    methods
       
    end
end

