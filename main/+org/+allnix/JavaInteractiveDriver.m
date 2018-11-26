function exitValue = JavaInteractiveDriver(varargin)
%JAVAINTERACTIVEDRIVER Summary of this function goes here
%   Detailed explanation goes here

% Does NOT work

logger = org.allnix.getLogger('org.allnix.JavaInteractiveDriver');

exitValue = 0;
reader = java.io.BufferedReader(java.io.InputStreamReader(java.lang.System.in));
line = reader.readLine();
%scanner = java.util.Scanner(java.lang.System.in);

%line = scanner.nextLine();
logger.info(line);
end

