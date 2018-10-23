classdef TableTest < matlab.unittest.TestCase
    %Learn MATLAB table class
    %   
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.TableTest);
    %   result = run(suite)
    %   disp(result)
    
    properties
        logger = logging.getLogger('org.allnix');
    end
    
    methods (Test)
        function testReadTable(me)
        % Learn readtable
        %
        %   https://www.mathworks.com/help/matlab/ref/readtable.html
        
        import allnix.obj2str;
        
        me.logger.info('%s', matlabroot);
        
        filePath = fullfile(matlabroot,'examples','matlab','myCsvTable.dat');
        x = readtable(filePath);
        me.logger.info("\n%s", obj2str(x));
        
        end
        
        
        
        function testPatients(me)
        % toolbox/matlab/demos/patients.dat
        %filePath = fullfile(matlabroot, 'toolbox', 'matlab', 'demos', 'patients.dat');
        %x = readtable(filePath);
        
        import allnix.obj2str;
        
        x = readtable('patients.dat');
        me.logger.info("\n%s", obj2str(head(x)));
        %disp(class(x));
        header = x.Properties.VariableNames;
        %me.logger.info('Header: %s', obj2str(header));
        me.assertEqual(class(header), 'cell');
        
        % head has 'LastName'
        v = ismember('LastName', header);
        me.assertTrue(v);
        
        %disp(x{'Weight'});
        
        end
        
        function testAccessData(me)
        %Learn how to access data in MATLAB table
        % https://www.mathworks.com/help/matlab/matlab_prog/access-data-in-a-table.html
        
        import allnix.obj2str;
        
        x = readtable('patients.dat');
        [rowCount, colCount] = size(x);
        me.assertEqual(colCount, 10);
        me.assertEqual(rowCount, 100);
        
        c = x{:,'Weight'};
        %me.logger.info('Type: %s', class(c));
        me.assertEqual(class(c), 'double');
        me.assertEqual(size(c,1), rowCount);
        me.assertEqual(c(1), 176);
        me.assertEqual(c(2), 163);
        end
    end
end

