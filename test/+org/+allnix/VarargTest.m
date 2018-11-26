classdef VarargTest < matlab.unittest.TestCase
    %VARARGTEST Summary of this class goes here
    %   Detailed explanation goes here
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.VarargTest);
    %   result = run(suite)
    %   disp(result)
    %   
    %   s = selectIf(suite,'ProcedureName', 'testBatch')
    
    properties
        logger = logging.getLogger('org.allnix');
        
    end
    methods (Test)
        function doVarargin(me)
        vars_1 = [13, 14, 17];
        me.takeVarargin(vars_1);
        
        vars_2 = {13, 14, 17};
        me.takeVarargin(vars_2);
        
        
        me.takeVarargin(vars_1, vars_2);
        end
        function testVarargout(me)
        
        [a,b,c] = me.writeVarargout();
        %disp(varargout);
        me.assertEqual(a, 13);
%         me.assertEqual(size(varargout,1), 1);
%         me.assertEqual(size(varargout,2), 1);
        end
    end
    
    methods
      
        function takeVarargin(me,varargin)
        me.logger.info('class: %s', class(varargin));
        me.logger.info('size(1) = %g', size(varargin,1));
        me.logger.info('size(2) = %g', size(varargin,2));
        me.logger.info('%s', allnix.obj2str(varargin));
        end
        
        function varargout = writeVarargout(me)
        varargout{1} = 13;
        varargout{2} = 17;
        varargout{3} = 19;
        end
    end
end

