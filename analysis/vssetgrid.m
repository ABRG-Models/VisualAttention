function [posx, posy] = vssetgrid (g)
    startx = 610; starty = 20;
    widx = 450; widy = 380;
    spacex = 20; spacey = 80;

    % Bottom row wants to be squat:
    if (g(2) == -1)
        widy = 190;
    end

    posx = startx + g(1)*(widx + spacex);
    posy = starty + g(2)*(widy + spacey);
    set(gcf, 'Position', [posx posy widx widy])
end
