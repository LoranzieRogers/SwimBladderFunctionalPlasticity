function [data] = displacementRMS(data,file_names)

% FUNCTION %
% 
% For each row, compute rms of x, y, and z displacements measurments such
% that we are left with the magnitude of displacement for each node at all
% test frequencies. This will be added as a new column vector at the end of
% the input 'data' file. 

% INPUTS %
% 
% The inputs for this script should just be the two output variables
% received from the function 'ExtractData'.

% OUTPUTS %
% 
% Should give the same name as the input 'data' name. The only thing
% different is that a new column is added. 

% NOTE %
% 
% lol, this did not need to be a funciton but wanted to keep things clean 
% at this point of the analysis.


for i = 1:length(file_names)
    for j = 1:length(data.(file_names(i,:)))
        data.(file_names(i,:))(j,6) = rms(data.(file_names(i,:))(j,3:5));     % rms of displacement
    end
end

end