


% folder path
list = [];
list = [list; dir('lib/test/resources')];

fcn = @(x) javaaddpath(fullfile(x.folder));
arrayfun(fcn, list);
