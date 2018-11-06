classdef List
    %List models after Java List interface
    %   Uses a Java List implementation as backend
    %   Unlike Java List, this stores immutable objects
    %   This cannot do List of List
    
    properties
        java;
    end
    
    methods
        function me = List(javaBackend)
        %LIST Construct an instance of this class
        %   Detailed explanation goes here
        me.java = javaBackend;
        end
        
        function bool = add(me, e)
        bool = me.java.add(allnix.toInt8Array(e));
        end
        
        function e = get(me, index)
        e = allnix.toMatlab(me.java.get(index));
        end
    end
end

