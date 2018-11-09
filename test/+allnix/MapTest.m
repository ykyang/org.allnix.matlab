classdef MapTest < matlab.unittest.TestCase
    % Summary of this class goes here
    %   Detailed explanation goes here
    %
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.MapTest);
    %   result = run(suite)
    %   disp(result)
    %
    %   s = selectIf(suite,'ProcedureName', 'testMap')
    %   
    %   Double check the object coming out of map.
    %   Put java.lang.String in but get 'char' out
    
    properties
        logger = logging.getLogger('org.allnix')
    end
    
    methods (Test)
        function testCreateMapObject(me)
        % Learn creating Map
        % https://www.mathworks.com/help/matlab/matlab_prog/creating-a-map-object.html
        %
        
        %import allnix.obj2str
        
        map = containers.Map();
        %me.logger.info('%s', obj2str(map));
        me.assertTrue(map.Count == 0);
        me.assertEqual(map.Count, uint64(0));
        end
        
        function testReadWrite(me)
        map = containers.Map('KeyType', 'char', 'ValueType', 'int64');
        
        %map(5) = 'five';
        map('five') = 5;
        me.assertEqual(map('five'), int64(5));
        
        map = containers.Map('KeyType', 'int64', 'ValueType', 'char');
        map(5) = 'five';
        me.assertEqual(map(5), 'five')
        end
        
        function testMap(me)
        map = allnix.Map(java.util.HashMap());
        
        data = struct;
        data.Log = struct;
        data.Log.values = [13, 17];
        
        v = map.put('st', data);
        me.assertTrue(isempty(v));
        me.assertEqual(map.size(), 1);
        
        
        
        end
        
        function testJavaMap(me)
        %Learn using Java Map in MATLAB
        
        %import java.util.HashMap
        
        x = java.util.HashMap(); % no import necessary
        
        x.put("five", 5);
        v = x.get("five");
        me.assertEqual(x.size(), 1);
        me.assertEqual(v, 5);
        
        x.put("pi", 3.1415926);
        v = x.get("pi");
        me.assertEqual(x.size(), 2);
        me.assertEqual(v, 3.1415926);
        
        %> string in char back
        v = "pi";
        me.assertTrue(isa(v, 'string'));
        x.put(3.1415926, v);
        v = x.get(3.1415926); % return char
        me.assertTrue(isa(v, 'char'));
        v = string(v);
        me.assertEqual(x.size(), 3);
        me.assertEqual(v, "pi");

        %> String in char back
        v = java.lang.String("planck");
        x.put(6.626070, v);
        v = x.get(6.626070); % return char
        me.assertTrue(isa(v, 'char'));
        v = string(v);
        me.assertEqual(x.size(), 4);
        me.assertEqual(v, "planck");
        
        %> List in List out???  YES
        v = java.util.ArrayList();
        x.put("list", v);
        v = x.get("list");
        me.assertEqual(class(v), 'java.util.ArrayList');
        
        end
    end
end

