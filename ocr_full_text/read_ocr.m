% Define the input and output file names
inputFile = 'output_text.txt';
outputFile = 'output.csv';

% Open the input file for reading
fid = fopen(inputFile, 'r');

% Initialize variables
data = {}; % Cell array to store the results
currentFamily = ''; % Variable to hold the current family name
indexCount = 0; % Index counter

% Read the file line by line
while ~feof(fid)
    line = strtrim(fgets(fid)); % Read a line and trim whitespace
    
    % Check if the line is a family name (all uppercase)
    if ~isempty(line) && all(isstrprop(line, 'upper')) && isletter(line(1))
        % Update the current family
        currentFamily = line;
    elseif ~isempty(line) && isletter(line(1))
        % It's a species name
        indexCount = indexCount + 1; % Increment index counter
        % Add the row to the data cell array
        data{end+1, 1} = line; % Species name
        data{end, 2} = currentFamily; % Family name
        data{end, 3} = indexCount; % Index count
    end
end

% Close the input file
fclose(fid);

% Write data to a CSV file
% Convert the cell array to a table for easy writing
dataTable = cell2table(data, 'VariableNames', {'SpeciesName', 'FamilyName', 'Index'});

% Write the table to a CSV file
writetable(dataTable, outputFile);

disp(['Data has been written to ', outputFile]);