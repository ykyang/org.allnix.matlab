classdef JsonRpcRequest < matlab.mixin.SetGetExactNames
    %JSONRPCREQUEST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        jsonrpc struct;
    end
    
    methods
        function loadFromFile(me, filename)
        text = fileread(filename);
        me.jsonrpc = jsondecode(text);
        end
        
        function load(me, text)
        me.jsonrpc = jsondecode(text);
        end
        
        function answer = getVersion(me)
        answer = me.jsonrpc.jsonrpc;
        end
        
        function answer = getMethod(me)
        answer = me.jsonrpc.method;
        end
        
        function answer = getId(me)
        answer = me.jsonrpc.id;
        end
        
        function answer = getParams(me)
        answer = me.jsonrpc.params;
        end

    end
end

