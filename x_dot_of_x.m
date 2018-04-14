x = linspace(-20,20,2000); %x limits on the plot--change if you need 
xdot=@(x) 3*(x-2)-(x-2).^3-2; %%%change this parameter with PIECEWISE OPERATORS! note: for y=n use y=n+0.*x

%plotting
set(gcf,'color','w');
fplot(xdot, 'r', 'LineWidth', 2);
title('$\dot{x} = 3(x-2)-(x-2)^3-2$','interpreter','latex'); %%%%change to suit your needs!
xlabel('x');
ylabel('$\dot{x}$','interpreter','latex');
ylim([-10 10])
xlim([-5 5])
hold on;

%produce x and y axes
%from https://www.mathworks.com/matlabcentral/answers/97996-is-it-possible-to-add-x-and-y-axis-lines-to-a-plot-in-matlab

axh = gca; % use current axes
color = 'k'; % black, or [0 0 0]
linestyle = '-'; % lines
line(get(axh,'XLim'), [0 0], 'Color', color, 'LineStyle', linestyle);
line([0 0], get(axh,'YLim'), 'Color', color, 'LineStyle', linestyle);

%determine fixed points
syms x
eq= 3*(x-2)-(x-2).^3-2; %%%%%%%FIX AS YOU ARE FIXING YOUR EQUATION
solve(eq==0,x,'Real', true)

%now to determine the types of equilibria: 
%blue, not filled in: unstable
%blue, filled in: stable
%green: semistable

syms f(x)
f(x) = eq;
xdoubledot = diff(f, x);


%circle code courtesy of https://www.mathworks.com/matlabcentral/answers/52895-how-to-draw-circle-in-an-image
%and https://www.mathworks.com/matlabcentral/answers/87111-how-can-i-draw-a-filled-circle

for i = 1:length(ans)
    deriv = xdoubledot(ans(i));
    if double(deriv) > 0 %unstable eq
        th = 0:pi/50:2*pi;
        xunit = 0.15 * cos(th);
        yunit = 0.15 * sin(th);
        h = plot(xunit+ans(i), yunit, 'b', 'LineWidth', 2);
        axis equal;
    end
    if double(deriv) == 0 %semistable eq
        if xdoubledot(ans(i) + 0.05) > 0 
            if xdoubledot(ans(i) - 0.05) > 0 %% in this case we have an unstable eq
                th = 0:pi/50:2*pi;
                xunit = 0.15 * cos(th);
                yunit = 0.15 * sin(th);
                h = plot(xunit+ans(i), yunit, 'b', 'LineWidth', 2);
                axis equal; 
            end
        end
        if xdoubledot(ans(i) + 0.05) < 0 
            if xdoubledot(ans(i) - 0.05) < 0 
                plot(ans(i), 0, '.b', 'MarkerSize', 30) %% stable eq
            end
        end
        if xdoubledot(ans(i) + 0.05) < 0 
            if xdoubledot(ans(i) - 0.05) > 0 
                plot(ans(i), 0, '.g', 'MarkerSize', 30)
            end
        end
        if xdoubledot(ans(i) + 0.05) > 0 
            if xdoubledot(ans(i) - 0.05) < 0 
                plot(ans(i), 0, '.g', 'MarkerSize', 30)
            end
        end
    end
    if double(deriv) < 0 %stable eq
        plot(ans(i), 0, '.b', 'MarkerSize', 30)
    end
end

hold off;

