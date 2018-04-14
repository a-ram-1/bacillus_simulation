t = linspace(-20,20,2000); %t limits on the plot--change if you need 
a = 0.5.*randi(10); %each cell experiences stress differently and as a result ComK levels will rise more in some cells than others
x=@(t) a.*exp(-(t-3).^2)+(randn(1, 1)/4); %%%change this parameter with PIECEWISE OPERATORS! note: for y=n use y=n+0.*x
xx=@(t) a.*exp(-(t-3).^2);
%randn adds a noise component
%why a gaussian? basing it on suel "An excitable gene regulatory circuit induces transient cellular differentiation"

%plotting
set(gcf,'color','w');
fplot(x, 'r', 'LineWidth', 2);
title('$x(t) = a*e^{-(t-4)^2}$ with noise and a $\in [1, 10]$','interpreter','latex'); %%%%change to suit your needs!
xlabel('t');
ylabel('x');
xlim([-10 15])
ylim([-2 10])
hold on;

fplot(xx, 'b', 'LineWidth', 2); %overlay a gaussian without noise
%produce x and y axes
%from https://www.mathworks.com/matlabcentral/answers/97996-is-it-possible-to-add-x-and-y-axis-lines-to-a-plot-in-matlab

axh = gca; % use current axes
color = 'k'; % black, or [0 0 0]
linestyle = '-'; % lines
line(get(axh,'XLim'), [0 0], 'Color', color, 'LineStyle', linestyle);
line([0 0], get(axh,'YLim'), 'Color', color, 'LineStyle', linestyle);

%determine fixed points
syms t
eq= a.*exp(-(t-3)^2); %%%%%%%FIX AS YOU ARE FIXING YOUR EQUATION
solve(eq==0,t,'Real', true)

%now to determine the types of equilibria: 
%blue, not filled in: unstable
%blue, filled in: stable
%green: semistable

syms f(t)
f(t) = eq;
xdot = diff(f, t);


%circle code courtesy of https://www.mathworks.com/matlabcentral/answers/52895-how-to-draw-circle-in-an-image
%and https://www.mathworks.com/matlabcentral/answers/87111-how-can-i-draw-a-filled-circle

for i = 1:length(ans)
    deriv = xdot(ans(i));
    if double(deriv) > 0 %unstable eq
        th = 0:pi/50:2*pi;
        xunit = 0.15 * cos(th);
        yunit = 0.15 * sin(th);
        h = plot(xunit+ans(i), yunit, 'b', 'LineWidth', 2);
        axis equal;
    end
    if double(deriv) == 0 %semistable eq
        if xdot(ans(i) + 0.05) > 0 
            if xdot(ans(i) - 0.05) > 0 %% in this case we have an unstable eq
                th = 0:pi/50:2*pi;
                xunit = 0.15 * cos(th);
                yunit = 0.15 * sin(th);
                h = plot(xunit+ans(i), yunit, 'b', 'LineWidth', 2);
                axis equal; 
            end
        end
        if xdot(ans(i) + 0.05) < 0 
            if xdot(ans(i) - 0.05) < 0 
                plot(ans(i), 0, '.b', 'MarkerSize', 30) %% stable eq
            end
        end
        if xdot(ans(i) + 0.05) < 0 
            if xdot(ans(i) - 0.05) > 0 
                plot(ans(i), 0, '.g', 'MarkerSize', 30)
            end
        end
        if xdot(ans(i) + 0.05) > 0 
            if xdot(ans(i) - 0.05) < 0 
                plot(ans(i), 0, '.g', 'MarkerSize', 30)
            end
        end
    end
    if double(deriv) < 0 %stable eq
        plot(ans(i), 0, '.b', 'MarkerSize', 30)
    end
end

hold off;

