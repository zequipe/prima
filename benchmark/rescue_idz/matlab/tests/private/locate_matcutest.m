function cmpaths = locate_matcutest(directory)
%This function finds where MatCUTEst (https://github.com/matcutest/matcutest) is installed, adds the
% paths needed for using MatCUTEst, and returns these paths in a cell array.
% We search at most 10 levels below the given directory, whose default value is the home directory.
% N.B.: As of 202301, MatCUTEst supports only Linux.

if nargin < 1
    directory = homedir();
end

% In the following line, the "*/" before "matcutest" cannot be removed.
[~, cmtools] = system(['find ', directory, ' -maxdepth 13 -wholename "*/matcutest/mtools/src" -type d -print -quit']);

if isempty(cmtools)
    error('locate_matcutest:MatCUTEstNotFound', 'MatCUTEst is not found under %s.', directory);
end

cmtools = strtrim(cmtools);  % Remove the leading and trailing white-space characters, including '\n'.

cmpaths = {cmtools};  % There may be other paths to include in the future.

for ip = 1 : length(cmpaths)
    addpath(cmpaths{ip});
end
