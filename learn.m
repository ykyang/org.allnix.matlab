%import wdvgla
b.addme
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