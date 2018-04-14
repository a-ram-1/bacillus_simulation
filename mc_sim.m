%how do we figure this out? thresh value-x = the min amount of noise needed
%so, given a "next value," we use normpdf(threshvalue-x) as the probability
%of the cell becoming competent 

t = linspace(0,10,100000);
comk_t_array = [];
comp_percent = 0;

for i = 1:100000
comk_thresh = 3; %change to suit your needs--this gets us 10% competence in an "ideal" setting

tminusone = 6*rand; %timepoint representing "t-1"

a = (randi(10))/2; %random integer var representing how different cells are affected by stress
                   %there is a 10% chance that a will be >=4.5

comk_tminusone = a*exp(-(tminusone-3)^2); %ComK concentration at "t-1"

dxdt = -2*a*exp(-(tminusone-3)^2)*(tminusone-3); %derivative of the ComK concentration gaussian at t-1

timestep = 0.01; %the closer this is to 0 the more accurate our approximation will be here

comk_t = comk_tminusone + dxdt*timestep; %we discretize the ComK concentration gaussian 
                                         %to figure out what the ideal ComK
                                         %conc. would be at time t
                                         
comk_t_array = [comk_t_array comk_t]; %add every ComK value to this                                          
                                         

if comk_thresh <= comk_t %if the cell is competent at time t
    comp_percent = comp_percent+1; 
else
    comp_percent = comp_percent; 
end
                                        
end

p = ((comp_percent)/100000)*100; %what percent of cells are competent?

set(gcf,'color','w');
scatterhist(t, comk_t_array) %scatterhist is nice for visualization purposes 
hold on; 
xL = @(t) 0.*t+3;
fplot(xL,'Color','m', 'LineWidth', 2);
ylabel(string('ComK concentration at time t+1'))
title(['Simulation of 100000 cells with ', num2str(p),'% competence'])







