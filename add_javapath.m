list = [];
%list = [list; dir('lib/java/*.jar')];

dir_app = dir(...
    "/home/ykyang/work/org.allnix.java/hf/"...
    + "build/distributions/org.allnix.hf-0.0.1b1/lib/*.jar");
%disp(dir_app);
list = [list; dir_app];

fcn = @(x) javaaddpath(fullfile(x.folder, x.name));
arrayfun(fcn, list);