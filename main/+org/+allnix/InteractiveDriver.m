function exitValue = InteractiveDriver(varargin)
%INTERACTIVEDRIVER Line based interactive MATLAB engine
%   Each line is a command to run MATLAB
logger = org.allnix.getLogger('org.allnix.InteractiveDriver');

while(true)
    try
        logger.info('Waiting for input ...');
        line = input('', 's');
        
        logger.info('Input line: {}', line);
        if strcmp('13212127-d973-4098-9289-eb12f3eff962', line)
            logger.info('Received exit command');
            exitValue = 0;
            return;
        end
        
        switch line
            case 'compute'
                logger.info('Waiting for input to compute ...');
                file = input('', 's');
                exitvalue = org.allnix.BatchDriver('compute', file);
            otherwise
                exitvalue = org.allnix.BatchDriver(line);
        end
    catch ME
        logger.error('{}', getReport(ME, 'extended', 'hyperlinks', 'off'));
        exitvalue = 1;
    end
    
    % print exit value
    fprintf(1, '%i\n', exitvalue);
end
end

