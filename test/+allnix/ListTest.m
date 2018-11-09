classdef ListTest < matlab.unittest.TestCase
    %LISTTEST Summary of this class goes here
    %   Detailed explanation goes here
    %
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.ListTest);
    %   result = run(suite)
    %   disp(result)
    
    %   s = selectIf(suite,'ProcedureName', 'testBatch')
    
    properties
        logger = logging.getLogger('org.allnix')
    end
    
    methods (Test)
        function testPrimitive(me)
        list = java.util.ArrayList();
        
        list.add(15);
        me.assertEqual(list.size(), 1);

        v = list.get(0);
        me.assertEqual(v, 15);
        end
        
        function testStruct(me)
        list = java.util.ArrayList();
        
        data = struct;
        data.Log = struct;
        data.Log.values = [13, 17];
        
        % this is not going to work
        me.assertError(@() list.add(data), 'MATLAB:UndefinedFunction');
        
        % need to turn things into byte array
        bytes = allnix.toInt8Array(data);
                
        % add data to list
        list.add(bytes);
        me.assertEqual(list.size(), 1);
        
        % get data from list
        bytes = list.get(0);
        data_new = allnix.toMatlab(bytes);
        me.assertEqual(data_new, data);
        me.assertEqual(data_new.Log.values, data.Log.values);
        
        
        end
        
        function testList(me)
        %Test Java List wrapper
        list = allnix.List(java.util.ArrayList);
        
        data = struct;
        data.Log = struct;
        data.Log.values = [13, 17];
        
        v = list.add(data);
        me.assertTrue(v);
        me.assertEqual(list.size(), 1);
        
        data_new = list.get(0);
        me.assertEqual(data_new, data);
        end
    end
    
    methods
        
    end
end

