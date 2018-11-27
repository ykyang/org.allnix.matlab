function exitValue = BatchJsonRpcDriver(varargin)
%BATCHJSONRPCDRIVER Summary of this function goes here
%   Detailed explanation goes here

exitValue = 0;

parser = inputParser();
parser.CaseSensitive = true;
parser.PartialMatching = false;
parser.StructExpand = true;

parser.addParameter('input', 'file');
parser.addParameter('inaddr', 'request.json');
parser.addParameter('output', 'file');
parser.addParameter('outaddr', 'respons.json');

parser.parse(varargin{:});
params = parser.Results;

text = [];
switch params.input
    case 'file'
        address = params.inaddr;
        text = fileread(address);
        request = org.allnix.JsonRpcRequest();
        request.loadFromFile(address);
    case 'embedded'
        text = params.inaddr;
        request = org.allnix.JsonRpcRequest();
        request.load(text);
    otherwise
        ME = MException(org.allnix.Exception.UnsupportedOperation, 'Unknown input option: %s', params.input);
        throw(ME);
end

response = JsonRpcDriver(request);

switch params.output
    case 'file'
        text = response.getResponse();
        fid = fopen(params.outaddr, 'w');
        fprintf(fid, '%s', text);
        fclose(fid);
    case 'embedded'
        exitValue = response.getResponse();
    otherwise
        ME = MException(org.allnix.Exception.UnsupportedOperation, 'Unknown output option: %s', params.output);
        throw(ME);
end

