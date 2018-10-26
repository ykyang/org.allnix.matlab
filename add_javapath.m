list = dir('lib/*.jar');

fcn = @(x) javaaddpath(fullfile(x.folder, x.name));

arrayfun(fcn, list);