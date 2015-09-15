%% Using PSSM to detect Protein secondary Structure
%  Independent study with professor Brian King
%  
%  Written by Son Pham

%% Part 0: Initialization
clear ; close all; clc;

%% Part 2: Load the protein file
%  Load the protein data

% Recreate the protein data if it doesn't exist yet
if ~exist('proteindata.mat','file')
    convertProtein();
end
load proteindata.mat;

%% Part 2: Create training and testing data
%  - Randomly sample some proteins as training data.
%  - Make sure to remove those protein from testing data.

numProteins = size(proteinTable,2);

% Randomly sample some proteins for train data
trainSize = 500;
sampleIndices = datasample(1:numProteins,trainSize,'Replace',false);
% From the sample indices, generate trainTable and testTable
trainTable = proteinTable(:,sampleIndices);
testTable = proteinTable;
testTable(:,sampleIndices) = [];

%% Part 3: Slide windows and create 3 PSSMs from trainData
%  - Slide windows length k
%  - Create 3 position specific scoring matrix

windowLength = 15;
dataSize = windowLength * 20;
[windows, labels] = slideWindows(trainTable, windowLength);

Cindices = (labels == 'C');
Eindices = (labels == 'E');
Hindices = (labels == 'H');

Cwindows = windows(Cindices);
Ewindows = windows(Eindices);
Hwindows = windows(Hindices);

Cpssm = createPSSM(Cwindows);
Epssm = createPSSM(Ewindows);
Hpssm = createPSSM(Hwindows);

%  Unroll all PSSMs for future use
Cpssm = Cpssm(:);
Epssm = Epssm(:);
Hpssm = Hpssm(:);

%% Part 4: Use 3 PSSMs to predict PSS
%  - Convert windows to binary format
%  - Match the windows with PSSM to calculate the score
binaryWindows = convertWindows(windows);
predLabels = predictLabel(binaryWindows, Cpssm, Epssm, Hpssm);

sum(predLabels == labels)/numel(labels)