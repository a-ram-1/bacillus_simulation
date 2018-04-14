x = linspace(-20,20,2000); %x limits on the plot--change if you need 
v=@(x) -(-0.25.*x.^4+2.*x.^3-4.5.*x.^2); %%%change this parameter with PIECEWISE OPERATORS! note: for y=n use y=n+0.*x

%plotting
set(gcf,'color','w');
fplot(v, 'r', 'LineWidth', 2);
title('$V(x) =\frac{1}{3}x^3, \dot{x} = -(x)^2$','interpreter','latex'); %%%%change to suit your needs!
xlabel('x');
ylabel('V');
ylim([-5 20])
xlim([-5 5])
hold on;

axh = gca; % use current axes
color = 'k'; % black, or [0 0 0]
linestyle = '-'; % lines
line(get(axh,'XLim'), [0 0], 'Color', color, 'LineStyle', linestyle);
line([0 0], get(axh,'YLim'), 'Color', color, 'LineStyle', linestyle);


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
                plot(ans(i), 6.75, '.g', 'MarkerSize', 30)
            end
        end
        if xdoubledot(ans(i) + 0.05) > 0 
            if xdoubledot(ans(i) - 0.05) < 0 
                plot(ans(i), 6.75, '.g', 'MarkerSize', 30)
            end
        end
    end
    if double(deriv) < 0 %stable eq
        plot(ans(i), 0, '.b', 'MarkerSize', 30)
    end
end

hold off;
