function exitValue = Driver(driverType, varargin)

switch driverType
    case 'InteractiveDriver'
        exitValue = org.allnix.InteractiveDriver(varargin{:});
    case 'BacthDriver'
        exitValue = org.allnix.BatchDriver(varargin{1}, varargin{2:end});
    case 'JsonRpcDriver'
        e = MException(...
            org.allnix.Exception.UnsupportedOperation, ...
            'JsonRpcDriver has not been implemented');
        throw(e);
    otherwise
        e = MException(org.allnix.Exception.UnsupportedOperation, ...
            'Unknown driver type %s', driverType);
        throw(e);
end

end