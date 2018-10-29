list = [];
%list = [list; dir('lib/java/*.jar')];

list = [list; dir(...
    "/home/ykyang/work/org.allnix.java/hf/"...
    + "build/distributions/hf-0.0.1b1/lib/*.jar")];

fcn = @(x) javaaddpath(fullfile(x.folder, x.name));
arrayfun(fcn, list);