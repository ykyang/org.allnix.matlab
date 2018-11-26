classdef List
    %List container with Java backend
    %   Uses a Java List implementation as backend
    %   Unlike Java List, this stores immutable objects
    %   This cannot do List of List
    
    properties (Access = private)
        java; % java.util.List;
    end
    
    methods
        function me = List(javaBackend)
        %LIST Construct an instance of this class
        %   Detailed explanation goes here
        me.java = javaBackend;
        end
        
        function bool = add(me, e)
        %Add a copy of the element to the end of list
        %
        bool = me.java.add(allnix.toInt8Array(e));
        end
        
        function e = get(me, index)
        %Get a copy of the element
        %   Unlike Java, a copy is returned not a reference
        e = allnix.toMatlab(me.java.get(index));
        end
        
        function answer = size(me)
        answer = me.java.size();
        end
    end
end

