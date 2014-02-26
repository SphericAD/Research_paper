function optimumCost = DynamicTimeWarping(vargin)
%%The DTW algorithm using a symmetric weighting function t ensure
%%D(A,B)=D(B,A)

if length(vargin)<2
    error('input:arg','The DTW arguments needs to be two patterns')
end

%%window parameter locality constaint
windowSize =0;
if length(vargin)==3
    windowSize =vargin(3);
end

%% input patterns
patternA =vargin(1)
patternB = vargin(2);
window = max(ceil(windowSize*(max(length(patternA),length(patternB)))),abs(length(patternA)-length(patternB)));

%% initializing the DTW cost matrix
DTW = zeros(length(patternA)+1,length(patternB)+1);
for i=2:length(patternA)
   DTW(i,1)=Inf;
end
for j=2:length(patternB)
    DTW(1,j)=Inf;
end

%% augmenting patterns with a vector of zeros
patternA = [zeros(length(patternA(:,1)),1) patternA];
patternB = [zeros(length(patternA(:,1)),1) patternB];

for i=2:length(pattenA)
    for j=max(2,i-window):min(length(patternB),i+window)
        cost = sum((patternA(:,i) -patternB(:,j)).^2);
        DTW(i,j)  = min([(DTW(i,j-1)+cost) (DTW(i-1,j-1)+2*cost) (DTW(i-1,j)+cost)]);
    end
end
optimumCost = DTW(length(patternA),length(patternB))/(length(patternA)+length(patternB)-2);








end