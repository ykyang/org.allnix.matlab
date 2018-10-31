list = [];
%list = [list; dir('lib/java/*.jar')];

list = [list; dir(...
    "/home/ykyang/work/org.allnix.java/hf/"...
    + "build/distributions/org.allnix.hf-0.0.1b1/lib/*.jar")];

fcn = @(x) javarmpath(fullfile(x.folder, x.name));
arrayfun(fcn, list);