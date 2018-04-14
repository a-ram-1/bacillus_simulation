%%%%%%ONLY FOR SITUATIONS WHERE THERE IS A COMPETENCE WINDOW--ELSE JUST USE
%%%%%%A LINE TO DENOTE THE INTERSECTION

%%%%%IF YOU SEE A "Index exceeds matrix dimensions." ERROR IT IS BECAUSE
%%%%%THAT CELL DOES NOT CROSS THE COMPETENCE THRESH AT MORE THAN ONE
%%%%%LOCATION

x = linspace(-5, 5); %x limits on the plot--change if you need 
a = 0.5.*randi(10);


%%%change this depending on what x(t) equals if x!=n
y = @(x) a.*exp(-(x-3).^2)+(randn(1, 1)/4); %%%%%change depending on what the ComK model [x(t)] is!!!
yy = @(x) a.*exp(-(x-3).^2); %the function without noise
%plotting
grid on;
set(gcf,'color','w');
hold on;

%plot x(t)
fplot(y, 'Color',[0.4940, 0.1840, 0.5560], 'LineWidth', 2); %for x!=n
fplot(yy, 'Color','r', 'LineWidth', 2); %this lets you differentiate between signal and noise
ylabel('t');

%plot competence thresh 
xL = @(x) 0.*x+4.5;
fplot(xL,'Color','m', 'LineWidth', 2);

%determine fixed points
syms t
eq= -(t-4.5)^2; %%%%%%%FIX AS YOU ARE FIXING YOUR EQUATION
solve(eq==0,t,'Real', true);

%now to determine the types of equilibria: 
%blue, not filled in: unstable
%blue, filled in: stable
%green: semistable

syms f(t)
f(t) = eq;
xdoubledot = diff(f, t);

syms t
eq= a*exp(-(t-3)^2)+(randn(1, 1)/4); %%%%%%%FIX AS YOU ARE FIXING YOUR EQUATION
solve(eq==4.5,t,'Real', true) %%%%ALSO FIX--this is the "do the ComK levels ever exceed the threshold?" question

%plot lines corresponding to intersections with x(t) and thresh and fill in
%the intersecting region

for i=1:length(ans)
    if ans(i)>0
    xdot= 0.*x+ans(i);
    yL = get(gca,'YLim');
    line([ans(i) ans(i)], [-2 16], yL,'Color','y', 'LineWidth', 2)
    end
    if mod(i, 2)==0
        area([ans(i-1) ans(i)], [16 16]);
        alpha(.5);
    end
end
set(gca,'children',flipud(get(gca,'children')))

%create x and y axes
axh = gca; % use current axes
color = 'k'; % black, or [0 0 0]
linestyle = '-'; % lines
line(get(axh,'XLim'), [0 0], 'Color', color, 'LineStyle', linestyle);
line([0 0], get(axh,'YLim'), 'Color', color, 'LineStyle', linestyle);

%flip order of plotted things--this just makes everything look nicer
c=get(gca,'Children'); %Get the handles for the child objects from the current axes
set(gca,'Children',flipud(c)) %Invert the order of the objects


hold off;