classdef JsonRpcResponse < matlab.mixin.SetGetExactNames
    %JSONRPCRESPONSE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        jsonrpc struct;
    end
    
    methods
        
        function me = JsonRpcResponse()
        %JSONRPCRESPONSE Construct an instance of this class
        %   Detailed explanation goes here
        x = struct;
        x.jsonrpc = '2.0';
        
        me.jsonrpc = x;
        end
        
        function text = getResponse(me)
        % getResponse Get the JSON text of the response
        %   Use this function to convert struct to JSON
        %   to send it back to client.
        text = jsonencode(me.jsonrpc);
        end
        
        function setId(me, id)
        me.jsonrpc.id = id;
        end
        
        function setResult(me, result)
        me.jsonrpc.result = result;
        end
        
        function setError(me, err)
        me.jsonrpc.error = err;
        end
        
        function setErrorCode(me, code)
        if ~isfield(me.jsonrpc, 'error')
            me.jsonrpc.error = struct;
        end
        me.jsonrpc.error.code = code
        end
        
        function setErrorMessage(me, message)
        if ~isfield(me.jsonrpc, 'error')
            me.jsonrpc.error = struct;
        end
        me.jsonrpc.error.message = message;
        end
        
        function outputArg = method1(obj,inputArg)
        %METHOD1 Summary of this method goes here
        %   Detailed explanation goes here
        outputArg = obj.Property1 + inputArg;
        end
    end
end

