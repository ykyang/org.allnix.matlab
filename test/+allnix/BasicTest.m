classdef BasicTest < matlab.unittest.TestCase
    %BASICTEST Summary of this class goes here
    %   Detailed explanation goes here
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.BasicTest);
    %   result = run(suite)
    %   disp(result)
    
    properties
        logger = logging.getLogger('org.allnix')
    end
    
    methods (Test)
        function testConcatenation(me)
        %Learn how to concatenate strings
        %   Use strcat, [], sprintf
        
        % horizontal array concatenation, [s1, s2, ..., sN]
        % preserves tailing white spaces
        s = ['a ', 'b ', 'c'];
        me.assertEqual(s, 'a b c');
        
        % strcat removes tailing white spaces
        s = strcat(' a ', ' b ', ' c ');
        me.assertEqual(s, ' a b c');
        
        s = " a " + " b " + " c ";
        me.assertEqual(s, " a  b  c ");
        
        % old, faithful sprintf
        s = sprintf("%s %s %s", "a", "b", "c");
        me.assertEqual(s, "a b c");
        
        s = sprintf("%s %i %g", "a", 2, 13.5);
        me.assertEqual(s, "a 2 13.5");
        
        s = sprintf("%s %i %g", "a", 2, 13.1415967);
        me.assertEqual(s, "a 2 13.1416");
        
        s = sprintf("%s %g %.16g", "a", 2, 13.1415967);
        %me.logger.info('s = %s', s);
        me.assertEqual(s, "a 2 13.1415967");
        
        s = sprintf("%s %g %.16G", "a", 2, 13.1415967);
        %me.logger.info("s = %s", s);
        me.assertEqual(s, "a 2 13.1415967");
        end
        
        function testJavaString(me)
        import java.lang.String
        
        % use String and compare string
        s1 = String("a");
        s2 = String("b");
        s = s1.concat(s2);
        me.assertEqual(string(s), "ab");
        
        % use StringBuilder and compare String
        sb = java.lang.StringBuilder
        sb.append("a").append("b");
        s = sb.toString();
        me.assertEqual(s, String("ab"));
        
        
        end
    end
end

