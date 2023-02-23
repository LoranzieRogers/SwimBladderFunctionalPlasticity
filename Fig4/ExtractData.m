function [data,file_names] = ExtractData(FileLocation,FileName,NumFreq)

% FUNCTION %
%
% The function of this code is to extract relevant data from Strand7 modal
% analysis output files. The major utility of this code is that it extracts
% the correct node number from a string in column 1 of each file. The node
% number is important because it is associated with a discrete point that
% modal displacement measurements were made in Strand7. In addition, there
% is an option to exclude any nodes that might be necessary in the
% analysis. For my purpose here, we needed to exclude a few points.


% INPUTS %
%
% -- FileLocation
% This should be the current directory. However, you may keep the files in
% another location. If this is the case, input data path.
%
%
% -- FileName
% List of datafile names in the specified directory. Will be imported
% alphabetical/numerical order. If an order of input is important keep
% track of this.
%
%
% -- NumFreq
% Number of frequencies used in modal analysis
%


% Read in Data ...
files = dir(fullfile(FileLocation,FileName));
file_names = string(zeros(length(files),1));


for k = 1:length(files)

    opts = detectImportOptions(files(k,1).name);
    tmp = readtable(files(k,1).name,opts);

    dotLocations = find(files(k,1).name == '.');
    name = files(k,1).name(1:dotLocations(1)-1);
    file_names(k,1) = name;
    [tmp_length tmp_width] = size(tmp);

    %Node number
    for j = 1:tmp_length
        node_tmp =cell2mat(tmp.Var2(j));
        node_num(1,j) = str2num(node_tmp(1:end-1));
    end

    data.(name) = [];
    for i=1:53
        tmp2 = [node_num(NumFreq*(i-1)+1:(i)*NumFreq)' tmp.Var4(NumFreq*(i-1)+1:(i)*NumFreq) tmp.Var6(NumFreq*(i-1)+1:(i)*NumFreq) tmp.Var7(NumFreq*(i-1)+1:(i)*NumFreq) tmp.Var8(NumFreq*(i-1)+1:(i)*NumFreq)];

        data.(name) = [data.(name); tmp2];
    end

    % In our initial model analysis, we oversampled certain areas (i.e.,
    % included more nodes), so here we will delete row data from nodes
    % that will not be used in further analyses. Remove del_rows if there
    % is no data that needs to be removed.

    del_rows = data.(name(1,:))(:,1) == [12822 23437 14587 25768 85271 88726 92876];
    del_rows = logical(sum(del_rows,2));
    data.(name(1,:))(del_rows,:) = [];

end

end