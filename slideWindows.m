function [windows, labels] = slideWindows(proteinTable, windowLength)
%% Slide proteins into windows of smaller length
%  This function will slide windows into substrings of windowLength

% Initialize some useful variables
numProteins = size(proteinTable, 2);
addedAcids = repmat('O', 1, floor(windowLength / 2));

% Calculate total number of windows and initialize windows andlabels
count = length(strcat(proteinTable{1,:}));
windows = cell(1,count);
labels = zeros(1,count);

% Reset count
count = 0;

% Add data into windows and labels by parsing the protein table
for proteinNum = 1:numProteins
   % Get the protein data
   data = proteinTable{1,proteinNum};
   label = proteinTable{2,proteinNum};
   
   % Use the protein length to calculate the number of windows
   numWindows = numel(label);
   % Pad extra O at both end.
   data = strcat(addedAcids, data, addedAcids);
   
   % Extract windows and assign appropriate labels
   for i = 1:numWindows
       count = count + 1;
       windows{count} = data(i:i+windowLength-1);
       labels(count) = label(i);
   end
end