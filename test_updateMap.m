posx = 3.58;
posy = 11;
env_lx = 1;
env_ly = 9;
env_ux = 6;
env_uy = 11;
s_dist = 2.0;
scale = 1.0;

search_lx = floor( max((posx - s_dist)*scale, env_lx) );            
search_ly = floor( max((posy - s_dist)*scale, env_ly) );            
search_ux = ceil( min((posx + s_dist)*scale, (env_ux)) );         % Note: dealing with matlab idx @ 1
search_uy = ceil( min((posy + s_dist)*scale, (env_uy)) );

x = search_lx;
y = search_ly;
dist = sqrt( (x-posx)^2 + (y-posy)^2);
