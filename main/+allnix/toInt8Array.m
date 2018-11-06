function  int8Array = toInt8Array(matlabObj)
%Convert MATLAB object to int8 array (byte array)
%   Convert any MATLAB object into byte array
%   However, Java does not have 'uint8' type so
%   we must convert it into 'int8' type.

bin = getByteStreamFromArray(matlabObj);
int8Array = typecast(bin, 'int8');
end

