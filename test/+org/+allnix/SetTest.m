classdef SetTest < matlab.unittest.TestCase
    %Learn sets in MATLAB
    %
    %   https://www.cs.ubc.ca/~murphyk/Software/matlabTutorial/html/dataStructures.html#52
    %   https://www.mathworks.com/help/matlab/set-operations.html
    %
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.SetTest);
    %   result = run(suite)
    %   disp(result)
    
    properties
        logger = logging.getLogger('org.allnix');
    end
    
    methods (Test)
        function testMatlabCell(me)
        %Try to use MATLAB cell array to simulate Set
        %   and it sucks.
        
        
        s1 = {'a', 'b', 'c'};
        [~,col] = size(s1);
        me.assertEqual(col, 3);
        
        s1{end+1} = 'd';
        [~,col] = size(s1);
        me.assertEqual(col, 4);
        
        % OK, matlab is stupid
        
        me.logger.info('%s', class(s1));
        
        end
        
        
        %>
        %> Java Set
        %>
        function testJavaSet(me)
        %Learn using Java Set in MATLAB
        
        import java.util.HashSet
        import java.util.Arrays
        
        s = HashSet;
        
        % initialize one-by-one
        s.add("a");
        s.add("b");
        s.add("c");
        me.assertEqual(s.size(), 3);
        
        s.remove("b");
        me.assertEqual(s.size(), 2);
        me.assertFalse(s.contains("b"));
        
        s.clear();
        me.assertTrue(s.isEmpty());
        
        % initialize with an array
        l = Arrays.asList(["a", "b", "c"]);
        s.addAll(l);
        me.assertEqual(s.size(), 3);
        
        s.remove("b");
        me.assertEqual(s.size(), 2);
        me.assertFalse(s.contains("b"));
        
        s.clear();
        me.assertTrue(s.isEmpty());
        
        me.logger.info(class(s));
        end
    end
end

