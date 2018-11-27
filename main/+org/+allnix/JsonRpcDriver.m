function response = JsonRpcDriver(request)
%JSONRPCDRIVER Summary of this function goes here
%   Detailed explanation goes here





method = request.getMethod();

switch method
    case 'compute'
        params = request.getParams();
        file = params.file;
        % load Data from file
        % call compute(Data);
        
        response = org.allnix.JsonRpcResponse();
        % convert response into text
        
    otherwise
        ME = MException(org.allnix.Exception.UnsupportedOperation, 'Unknown method: %s', method);
        throw(ME);
end
end

