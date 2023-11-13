%% Function runTwoParallelLinkSim()
% Parameters
%  K - the number of packets in the application message
%  p - the probability of failure 
%  N - the number of simulations to run
%
%% Task # 3
% written by Garrett Adelmann

% prepare the command window
clc;
clear all;
close all;

% define Variables
K = [1 5 15 50 100];
N = 1000;
p = 0:.01:0.99;

% run for each value of K
for i = 1:length(K) 
    %Initialize results array ( later will be filled) 
     resultSim = ones(1,100);
     g = 0;% index variable g tells me where I need to store my simulation result value at each probability
     calculatedResult = K(i)./(1-(p.^2));% calculated result
        for p1 = 0:0.01:0.99
            g = g+1;
            resultSim(1,g) = runTwoParallelLinkSim2(K(i),p1,N);% find the simulated results
        end      
    figure(i);
    hold on;
    % plot results simulated
    plot(p,resultSim,'o');
    plot(p,calculatedResult);
    set(gca, 'YScale', 'log');% may y axis log scale for readability
   
    % Make graph look nice
        xlim([0 1]);
        title('Two Parallel Link Network');xlabel('Probability');ylabel('# of transmissions');
end
hold off
% generate the graph with all results on it on one figure
 figure(6);
for i = 1:length(K) 
    % initialize results sim and index
     resultSim = ones(1,100);
     g = 0;% index variable g tells me where I need to store my simulation result value at each probability
     calculatedResult = K(i)./(1-(p.^2));% calculated result
     % run through each probabilty and find the two parallel link
     % simulation values for failed transmissions to compare with the
     % calculated results
        for p1 = 0:0.01:0.99
            g = g+1;
            resultSim(1,g) = runTwoParallelLinkSim2(K(i),p1,N);% find the simulated results

        end   
    hold on;
    % plot simulation vs the calculated
    plot(p,resultSim,'o');
    plot(p,calculatedResult);
    set(gca, 'YScale', 'log');
   
    % Make graph look nice
        xlim([0 1]);
        title('Calc vs Sim (all)');xlabel('Probability');ylabel('# of transmissions');

end
hold off;


function result = runTwoParallelLinkSim2(K,p,N)

    simResults = ones(1,N); % a place to store the result of each simulation
    
    for i=1:N
        txAttemptCount = 0; % transmission count
        pktSuccessCount = 0; % number of packets that have made it across
    
        while pktSuccessCount < K
            
            r = rand; % generate random number to determine if packet is successful (r > p)
            txAttemptCount = txAttemptCount + 1; % count 1st attempt
        
            % while packet transmissions is not successful (r < p)
            while r < p
                r = rand; % transmit again, generate new success check value r
                txAttemptCount = txAttemptCount + 1; % count additional attempt
            end
        
            pktSuccessCount = pktSuccessCount + 1; % increase success count after success (r > p)
        end
    
        simResults(i) = txAttemptCount; % record total number of attempted transmissions before entire application message (K successful packets) transmitted
    end

    result = mean(simResults);
end

