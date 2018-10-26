classdef StructureTest < matlab.unittest.TestCase
    %STRUCTURETEST Learn MATLAB structure
    %
    %   https://www.mathworks.com/help/matlab/ref/struct.html
    %
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.StructureTest);
    %   result = run(suite)
    %   disp(result)
    
    properties
        Property1
    end
    
    methods (Test)
        function testStructWithOneField(me)
            field = 'f';
            value = {'some text';
                [10, 20, 30];
                13.4};
            s = struct(field,value);
            % s(1) = f:'some text'
            % s(2) = f:[10, 20, 30]
            % s(3) = f:13.4
            me.assertEqual(3, length(s))
            me.assertEqual(s(1).f, 'some text')
            me.assertEqual(3, length(s(2).f))
            me.assertEqual(s(3).f, 13.4)
            
        end
       
        function testStructWithMultipleFields(me)
            field1 = 'f1';  value1 = zeros(1,10);
            field2 = 'f2';  value2 = {'a', 'b'};
            field3 = 'f3';  value3 = {pi, pi.^2};
            field4 = 'f4';  value4 = {'fourth'};
            % s(1) = f1:[0,0...], f2:'a', f3:pi, f4:'fourth'
            % s(2) = f1:[0,0...], f2:'b', f3:pi.^2, f4:'fourth'
            s = struct(field1,value1,field2,value2,field3,value3,...
                field4,value4);
            % disp(s);
            %     1×2 struct array with fields:
            %
            %     f1
            %     f2
            %     f3
            %     f4
            
            % s(1), s(2)
            me.assertEqual(2, length(s));
            me.assertEqual(s(1).f1, zeros(1,10));
            me.assertEqual(s(1).f2, 'a');
            me.assertEqual(s(1).f3, pi);
            me.assertEqual(s(1).f4, 'fourth');
            
            me.assertEqual(s(2).f1, zeros(1,10));
            me.assertEqual(s(2).f2, 'b');
            me.assertEqual(s(2).f3, pi^2);
            me.assertEqual(s(2).f4, 'fourth');
        end
        function testStructureWithEmptyFields(me)
            s = struct('f1', 'a', 'f2', []);
            me.assertEqual(s.f1, 'a');
            me.assertEqual(s.f2, []);
            
            s.f3 = 'lalala';
            me.assertEqual(s.f3, 'lalala');
            
            % remove a filed
            s = rmfield(s, 'f3');
            me.assertFalse(isfield(s, 'f3'))
        end
        
        
        function testCopyByValue(me)
            s = struct;
            s.a.b = 5;
            s.c.d = 13;
            me.assertEqual(s.a.b, 5);
            
            % copy
            a = s.a;
            me.assertEqual(a.b, 5);
            
            % copy by value
            a.b = 17;
            me.assertEqual(a.b, 17);
            me.assertEqual(s.a.b, 5);
        end
        
        function testFunctionPass(me)
            x =[1, 2];
            %x(1) = 1;
            %x(2) = 2;
            %disp(x);
            %disp(class(x));
            me.assertEqual(x(1), 1);
            me.assertEqual(x(2), 2);
            y = me.modifyArray(x);
            % not changed
            me.assertEqual(x(1), 1);
            me.assertEqual(x(2), 2);
            % changed values from return
            me.assertEqual(y(1), 17);
            me.assertEqual(y(2), 19);
            
        end
    end
    
    methods
        function y = modifyArray(me, x)
            x(1) = 13.;
            x(2) = 17.;
            y = x;
            y(1) = 17.;
            y(2) = 19.;
        end
        
    end
end

