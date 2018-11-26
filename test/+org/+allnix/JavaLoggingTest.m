classdef JavaLoggingTest < matlab.unittest.TestCase
    %JAVALOGGINGTEST Summary of this class goes here
    %   Detailed explanation goes here
    %
    %   suite = matlab.unittest.TestSuite.fromClass(?org.allnix.JavaLoggingTest);
    %   result = run(suite)
    %   disp(result)
    
    properties (Constant)
        logger = org.slf4j.LoggerFactory.getLogger('org.allnix.JavaLoggingTest');
    end
    
    properties
        
    end
    
    methods (Test)
        function test(me)
        me.logger.info('My first Java logging in MATLAB');
        me.logger.warn('My first warn');
        me.logger.error('My first error');
        
        i = 10;
        me.logger.info('Message: i = {}', i);
        s = 'test message';
        me.logger.info('Message: {}', s);
        end
        
    end
end

