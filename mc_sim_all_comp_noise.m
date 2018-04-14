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
                                         
comk_t_array = [comk_t_array comk_t+randn(1)]; 

if comk_t >= comk_thresh
    comp_percent = comp_percent+1; 

elseif comk_t < comk_thresh                                          
num = rand; %random number picked from a uniform distribution

noise_gap = comk_thresh - comk_t; %how much noise is needed to get ComK conc to the threshold

prob_close_gap = normpdf(noise_gap); %the probability that there will be enough noise at time t to close this gap

    if num<prob_close_gap %this means that noise pushed you over the threshold
        if comk_tminusone < comk_thresh
            %fprintf(string('This cell became competent from a state of no competence'))
            comp_percent = comp_percent + 1;
        else
            %fprintf(string('This cell remained competent')) 
        end
    else %not enough noise to push you over the threshold 
        if comk_tminusone < comk_thresh
            %fprintf(string('This cell remained not competent'))
        else
            %fprintf(string('This cell became not competent from a state of competence'))
        end
    end
end
end
p = (comp_percent/100000)*100; %how many cells are competent at time t?

set(gcf,'color','w');
scatterhist(t, comk_t_array)
hold on; 
xL = @(t) 0.*t+3;
fplot(xL,'Color','m', 'LineWidth', 2);
ylabel(string('ComK concentration at time t+1 [a.u.]'))
xlabel(string('t+1 [a.u.]'))
title(['Noisy simulation of 100000 cells with ', num2str(p),'% competence'])


%%%%why does this allow us to generate multiple competence events in a
%%%%cell? because the gaussian representation of ComK allows the
%%%%concentration to be above the thresh at multiple times
%%%%even as the ComK concentration is diminishing, perhaps due to ComS activity, 
%%%%%noise can push that concentration above the thresh again where it will then
%%%%%generate another competence event

%%%%%noise: fluctuations in [ComK] due to ongoing translation/degradation
%%%%%occurring in the cell


%%%%%%how does this generalize to neuronal activity??? treat this as a
%%%%%%model of an end plate potential [remember 6.021??]--end plate
%%%%%%potentials can be modeled as Gaussians and, if they depolarize the
%%%%%%membrane sufficiently, can then cause an action potential! 
%%%%%%each neuron will generate multiple action potentials--the reason this
%%%%%%Gaussian representation works is as follows: 
%%%%%%say we have an EPP that doesn't quite get the neuron to
%%%%%%threshold--as that potential is decreasing it is possible for noise
%%%%%%from ion channel fluctuations to spontaneously depolarize the cell
%%%%%%enough such that it hits threshold--again the likelihood of this
%%%%%%occurring decreases as the membrane voltage strays further away from
%%%%%%threshold 






