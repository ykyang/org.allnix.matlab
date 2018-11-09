classdef TableTest < matlab.unittest.TestCase
    %Learn MATLAB table class
    %   
    %   suite = matlab.unittest.TestSuite.fromClass(?allnix.TableTest);
    %   result = run(suite)
    %   disp(result)
    %
    %   s = selectIf(suite,'ProcedureName', 'testRowNames')
    
    properties
        logger = logging.getLogger('org.allnix');
    end
    
    methods (Test)
        
        function testRowNames(me)
        %
        %            Petrel 
        %            _______
        %
        %   Perm     'perm' 
        %   Tough    'tough'
        %

        rowNames = [{'Perm'}; {'Tough'}];
        col =[{'perm'}; {'tough'}];
        t = table(col, 'RowNames', rowNames, 'VariableNames', {'Petrel'});
        t.Properties.DimensionNames{1} = 'Abalone';
        %addvars(t, col, 'NewVariableNames', 'Petrel');
%        t.Properties.RowNames = rowNames;
        me.logger.info('\n%s', allnix.obj2str(t));
        
        % Get row names back
        rowNames = t.Properties.RowNames;
        me.assertEqual(class(rowNames{1}), 'char');
        me.assertTrue(strcmp(rowNames{1}, 'Perm'));
        me.assertEqual(rowNames{2}, 'Tough');
        
        % Get value based on row name
        value = t{'Perm', 'Petrel'};
        me.assertEqual(class(value), 'cell');
        me.assertTrue(strcmp(value, 'perm'));
       
        
        writetable(t, 'mytable.csv', 'WriteRowNames', true, 'WriteVariableNames', true);
        tt = readtable('mytable.csv', 'ReadRowNames', true, 'ReadVariableNames', true);
        me.assertEqual(tt, t);
        
        end
        function testReadTable(me)
        % Learn readtable
        %
        %   https://www.mathworks.com/help/matlab/ref/readtable.html
        
        import allnix.obj2str;
        
        me.logger.info('%s', matlabroot);
        
        filePath = fullfile(matlabroot,'examples','matlab','myCsvTable.dat');
        x = readtable(filePath);
        me.logger.info("\n%s", obj2str(x));
        me.assertEqual(x{1,6}, 1);
        me.assertEqual(x{1,2}, {'M'});
        
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

