function exitValue = BatchDriver(functionName,varargin)
%BATCHDRIVER Summary of this function goes here
%   Detailed explanation goes here
logger = org.allnix.getLogger('org.allnix.BatchDriver');

exitValue = 0;

logger.info('Function Name: {}', functionName);

switch functionName
    case 'compute'
        file = varargin{2};
        logger.info('Compute on file: {}', file);
    case 'disp'
        disp('Hello world');
    case 'logging'
        logger.info('Hello world');
    otherwise
        exitValue = 1;
        logger.error('Unsupported function: "{}"', functionName);
end
end

