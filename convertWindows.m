function data = convertWindows(windows)
%% Convert windows to binary form to match it with PSSM
%  Each window will be an unrolled (20 x windowLength) binary vector
%  Data becomes (20 x windowLength) x numProteins

% Initialize windowLength and the pssm
windowLength = numel(windows{1});
datasize = 20 * windowLength;

% Create AA frame from AAbank
AAbank = ['A';'R';'N';'D';'C';'E';'Q';'G';'H';'I';'L';'K';'M';'F';'P';'S';'T';'W';'Y';'V'];
AAframe = repmat(AAbank,1,windowLength);
AAframe = AAframe(:); % Unroll the frame

% Create the unrolled frame for every window
data = cellfun(@(x) repmat(x,20,1), windows, 'UniformOutput', false);
data = cellfun(@(x) reshape(x,datasize,1), data, 'UniformOutput', false);
data = cell2mat(data);
% Each frame will be compared with the AAframe to convert window data to
% binary form
data = bsxfun(@eq, data, AAframe);
