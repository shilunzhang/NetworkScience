function plotDegree(nodeArray, varargin)

nVar = length(varargin);
nodeArray = tabulate(nodeArray(:));
deg = tabulate(nodeArray(:, 2));
if nVar == 3
    loglog(deg(:,1), deg(:, 3)/100, varargin{1}, ...
        'MarkerSize', varargin{2}, 'MarkerFaceColor', varargin{3},'MarkerEdgeColor', varargin{3});
elseif nVar == 1
    loglog(deg(:,1), deg(:, 3)/100, varargin{1}, ...
        'MarkerSize', 2, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k');
else
    fprintf('Arguments: nodeArray, Marker, MarkerSize, MarkerFaceColor\n');
    return;
end
title('Degree distribution');
xlabel('log(k)'); ylabel('Log(P(k))');
set(gca, 'xtick', [1 10 100 1000 10000 100000]);