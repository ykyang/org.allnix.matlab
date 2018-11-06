function matlabObj = toMatlab(int8Array)
%Convert int8 array (byte array) into MATLAB object
%
bin = typecast(int8Array, 'uint8');
matlabObj = getArrayFromByteStream(bin);
end

