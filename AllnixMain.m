%Learn to use external Java libraries
%     
%   1. Use gradle to package all Java libraries
%   2. cp to lib/
%   3. use add_javapath to load dynamically
%   4. test in AllnixMain
%   5. package up with compiler, add main/ and lib/ to
%      included list


import java.util.HashMap
import java.io.File
import com.fasterxml.jackson.databind.ObjectMapper

file = fullfile('/home/ykyang/tmp/instruction.json');
file = File(file);
mapper = ObjectMapper;

jsonNode = mapper.readTree(file);

node = jsonNode.get('LogData');
disp(node.asText());