classdef Basic < handle
    %BASIC Summary of this class goes here
    %   Detailed explanation goes here
    properties
        Value
        Other
        plot
    end
    properties (Constant)
        logger = logging.getLogger('allnix')
    end
    methods
        function answer = roundOff(this)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            answer = round(this.Value,2);
        end
        function set.Other(me, value)
            me.logger.info('value = %f', value);
            disp(value);
            me.Other = value;
        end
    end
end

