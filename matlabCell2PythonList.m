% FILEPATH: /d:/Xuehong/xuehong_python/Unfinished_code/fMRI_Gene/matlab2python.m
% translate matlab cell to python list
% Define a cell array in MATLAB
matlab_cell = {
    [8:15];
%    [8:15];
%    [8:15];
    [8:15];         
    [8:15];
    [8:15];
    [8:15];
    [8:15];
    [8:15];
    [8:15];
    [8:15];
    [8:12];
    [8:15];
    [8:15];
    [8:15];
    [8:15];
%    [8:15];
    [8:15];
     }; 
% Open a file for writing
fileID = fopen('python_cell.txt','w');
sz_cell = size(matlab_cell);
% Loop through each row of the MATLAB cell array
fprintf(fileID, '[ \n');
for i = 1:sz_cell(1)
    % Write the start of the Python list syntax
    if sz_cell(2) > 1
        fprintf(fileID, '[');
    end
    
    % Loop through each element in the current row of the MATLAB cell array
    for j = 1:size(matlab_cell, 2)
        % Get the current element
        element = matlab_cell{i,j};
        
        % Check the data type of the current element and write the appropriate Python syntax
        if ischar(element)
            fprintf(fileID, "'%s'", element);
        elseif isnumeric(element)
            % Check if the current element is an vector
            if numel(element) > 1
                % Write the start of the Python list syntax
                fprintf(fileID, '[');
                
                % Loop through each element in the current vector
                for k = 1:numel(element)
                    % Get the current element
                    vector_element = element(k);
                    
                    % Check the data type of the current element and write the appropriate Python syntax
                    if isnumeric(vector_element)
                        fprintf(fileID, '%d', vector_element);
                    else
                        error('Unsupported data type in MATLAB cell array');
                    end
                    
                    % Write a comma after the element unless it's the last element in the vector
                    if k < numel(element)
                        fprintf(fileID, ', ');
                    end
                end
                
                % Write the end of the Python list syntax
                fprintf(fileID, ']');
            else
                fprintf(fileID, '%d', element);
            end
        elseif islogical(element)
            if element
                fprintf(fileID, 'True');
            else
                fprintf(fileID, 'False');
            end
        else
            error('Unsupported data type in MATLAB cell array');
        end
        
        % Write a comma after the element unless it's the last element in the row
        if j < sz_cell(2)
            fprintf(fileID, ', ');
        end
    end
    
    % Write the end of the Python list syntax and a newline character
    if sz_cell(2) > 1
        fprintf(fileID, '],\n');
    else
        fprintf(fileID, ',\n');
    end
end
fprintf(fileID, ']');
% Close the file
fclose(fileID);
