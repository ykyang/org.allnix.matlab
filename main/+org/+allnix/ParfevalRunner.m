classdef ParfevalRunner
    %PARFEVALRUNNER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        pool
    end
    
    methods
        function future = run(me, func, noout, ins)
        future = parfeval(me.pool, func, noout, ins);
        end
        
        function varargout = fetchOutputs(me, future)
        varargout = fetchOutputs(future);
        end
           
        
    end
end

