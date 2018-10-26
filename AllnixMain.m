import java.util.HashMap
import java.io.File
import com.fasterxml.jackson.databind.ObjectMapper

file = fullfile('/home/ykyang/tmp/instruction.json');
file = File(file);
mapper = ObjectMapper;

jsonNode = mapper.readTree(file);

node = jsonNode.get('LogData');
disp(node.asText());