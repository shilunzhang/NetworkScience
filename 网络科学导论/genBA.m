function netEdge = genBA(N, m0, m)
% Generate BA scale free network, the m=a case in price model. 
% m0: Start with m0 strongly connected nodes
% N, m:To get a network with N nodes,we add N-m0 new nodes(N-m0 loops),
%      each new node connected to m randomly selected previous nodes;
% netEdge: Return edge of generated BA network;
% Author: Zhang Shilun  Email: shilunzh@gmail.com

tic % timing

N = N-m0;
InArray = zeros(m0+N*m, 1); % strongly connected 5 nodes, InArray % add N nodes
InArray(1:m0, 1) = (1:m0)';
p = 0.5; % m = a in price model
netEdge = (1:m0)'; netEdge = [netEdge, netEdge([2:end, 1])];
netEdge = [netEdge; zeros(N*m, 2)];

for i = 1:N % generate network
    NewEdge = zeros(m, 1); % for each newly added node, select m edges.
    for j = 1:m % find m node to get m edges
        rNum = rand();
        if rNum < p % find a new node, then add it to NewEdge
            while 1
                indexx = ceil(length(InArray)*rand()); % indexx is the index of selected node in InArray.
                if ~any(NewEdge == InArray(indexx))
                    NewEdge(j) = InArray(indexx);
                    break;
                end
            end
        else
            while 1
                indexx = ceil((i+m0-1)*rand(1)); % indexx is the selected node.
                if ~any(NewEdge == indexx)
                    NewEdge(j) = indexx;
                    break;
                end
            end
        end
    end
    InArray(m0+m*(i-1)+1:m0+m*i) = NewEdge;  % update
    netEdge(m0+m*(i-1)+1:m0+m*i, :) = [(m0+i)*ones(m,1), NewEdge]; % update network.
end

toc
% save( 'C:\Users\shilun\Desktop\simudata\network.mat', 'netEdge', 'N', 'm', 'm0');