function answer = obj2str(obj)
%OBJ2STR Use disp() to get the string representation of an object
%   string = obj2str(obj) return string representation fo the object
%  
answer = evalc('disp(obj)');
end

