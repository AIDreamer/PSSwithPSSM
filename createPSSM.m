function pssm = createPSSM(windows)
%% Create Position Specific Scoring Matrix from strings data
%  Return a matrix of dimensions (windowLength x 20) indicating the
%  relative frequency of each amino acid in the substring of this type

% Initialize windowLength and the pssm
windowLength = numel(windows{1});
pssm = zeros(20,windowLength);
datasize = 20 * windowLength;

% Create the AAframe from the AAbank
AAbank = ['A';'R';'N';'D';'C';'E';'Q';'G';'H';'I';'L';'K';'M';'F';'P';'S';'T';'W';'Y';'V'];
AAframe = repmat(AAbank,1,windowLength);
AAframe = AAframe(:); % Unroll the frame

% Create the unrolled frame for every window
frames = cellfun(@(x) repmat(x,20,1), windows, 'UniformOutput', false);
frames = cellfun(@(x) reshape(x,datasize,1), frames, 'UniformOutput', false);
frames = cell2mat(frames);
% Each frame will be compared with the AAframe to convert window data to
% binary form
frames = bsxfun(@eq, frames, AAframe);
% Sum them up to calculate the frequency that each AA appear in a specific
% position
pssm = sum(frames,2);

% reshape the pssm to (20 x windowLength) dimension and normalize it to
% from 0 to 1
pssm = reshape(pssm, 20, windowLength);
pssm = bsxfun(@rdivide, pssm, max(pssm,[],2));
end