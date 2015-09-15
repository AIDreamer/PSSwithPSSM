function predLabels = predictLabel(binaryWindows, Cpssm, Epssm, Hpssm)
%% Predict the label based on 3 PSSMs calculated

numWindows = size(binaryWindows,2);
pred = zeros(3, numWindows);

Cscores = bsxfun(@times, binaryWindows, Cpssm);
Escores = bsxfun(@times, binaryWindows, Epssm);
Hscores = bsxfun(@times, binaryWindows, Hpssm);

pred(1,:) = sum(Cscores);
pred(2,:) = sum(Escores);
pred(3,:) = sum(Hscores);

[~,predLabels] = max(pred,[],1);
predLabels

predLabels(predLabels == 1) = 'C';
predLabels(predLabels == 2) = 'E';
predLabels(predLabels == 3) = 'H';

end