classdef Map
    %Map container with Java backend
    %   Detailed explanation goes here
    
    properties
        java; % java.util.Map;
    end
    
    methods
        function me = Map(javaBackend)
        % Assigne the desired Java backend container
        me.java = javaBackend;
        end
        
        function v = put(me, key, value)
        v = me.java.put(key,allnix.toInt8Array(value));
        if ~isempty(v)
            v = allnix.toMatlab(v);
        end
        end
        
        function v = get(me, key)
        v = allnix.toMatlab(me.java.get(key));
        end
        
        function answer = size(me)
        answer = me.java.size();
        end
        
    end
end

