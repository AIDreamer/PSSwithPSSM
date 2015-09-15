function convertProtein()
%% Convert protein to suitable data type. Make sure to check if the
%  converted file is already there. (So that we don't generate the file
%  every single time.

% Scan the whole protein data
fileID = fopen('data/Proteins.fa');
proteins = textscan(fileID,'%s');
fclose(fileID);
proteins = proteins{1};

% Keep only protein data and transpose
% (Storing each data in a column is a standard practice)
proteins = proteins(2:2:end);
proteins = proteins';

% Scan the whole SS data
fileID = fopen('data/SSpro.dssp');
sslabels = textscan(fileID,'%s');
fclose(fileID);
sslabels = sslabels{1};
% Keep only ss data and transpose
% (Standard practice)
sslabels = sslabels(2:2:end);
sslabels = sslabels';

% Combine them into one data
proteinTable = [proteins;sslabels];

% Save the data into a file
save('proteindata.mat','proteinTable');

end