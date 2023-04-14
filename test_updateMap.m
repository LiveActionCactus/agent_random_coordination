posx = 10; %8.3;
posy = 7.14; %10;
env_lx = 8; %6;
env_ly = 5; %8;
env_ux = 10;
env_uy = 10;
s_dist = 2.0;
scale = 1.0;
map = zeros(11,11);

search_lx = floor( max((posx - s_dist)*scale, env_lx) );            
search_ly = floor( max((posy - s_dist)*scale, env_ly) );            
search_ux = ceil( min((posx + s_dist)*scale, (env_ux)) );         % Note: dealing with matlab idx @ 1
search_uy = ceil( min((posy + s_dist)*scale, (env_uy)) );

for x = search_lx:search_ux                                 
    for y = search_ly:search_uy
        fprintf("x: %d, y: %d", x, y);
        dist = sqrt( (x-posx)^2 + (y-posy)^2 )
        if dist <= (s_dist + eps)
            my = env_uy - y + 1
            mx = x + 1
            map(my,mx) = 1.0                    
            pause()                            
        end  
    end
end % end map search and update