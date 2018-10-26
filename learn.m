%import wdvgla
%b.addme

% I have to do this everytime???
% stupid matlab
addpath('main', 'test');
addpath('lib/logging4matlab-03b221f')

import matlab.unittest.TestSuite

logger = logging.getLogger('allnix');
tic
logger.info('My first log');
toc

suite = TestSuite.fromClass(?allnix.SimpleTest);
result = run(suite);
disp(result);

obj = allnix.Basic;
obj.Value = 13.318290;
x = obj.roundOff();
disp(x);
o2 = obj;
o2.Value = pi;
x = obj.roundOff();
disp(x);

o2.Other = 13.4;

%disp(addme(5))
%disp(wdvglab.addme(5))

n = 50;
r = rand(n,1);
%disp(class(r))
%fprintf(2, '%s\n',class(r));
%plot(r)


% t = timer('TimerFcn', {@kernel, "1"});
% startat(t, now+0.1/86400);
% disp('blocking?');
% t1 = timer('TimerFcn', {@kernel, "2"});
% startat(t1, now+0.1/86400);
%wait([t, t1])

t = timer;
t.TimerFcn = {@kernel, "2"};
t.ExecutionMode = 'fixedSpacing';
t.Name = 'T';

disp("timeer name: " + t.Name);
start(t);





function kernel(tim, evt, id)
a = 0;
b = 1.5;
c = 3.6;
tic
disp("start " + id);
%pause(5);
 for i = 1: 500000000
     a = a + i*b + c;
 end
disp("stop " + id);
toc
disp(a);
end