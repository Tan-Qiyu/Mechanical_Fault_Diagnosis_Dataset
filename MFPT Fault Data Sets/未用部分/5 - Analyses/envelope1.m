function [env,dty] = envelope1(data,dt,nfilt,lowf,highf)
% [env,dty] = envelope1(data,dt,nfilt,lowf,highf);
%Inputs:
% data      :data vector, time domain
% dt        :sampling time interval
% nfilt     :size of filter for low pass filtering
% lowf      :low frequency limit of bandpass filter
% highf     :high frequency limit of bandpass filter
%Outputs:
% env       :Envelope of data
% dty       :decimated sample rate
 
c = (highf + lowf)/2;
if 1/dt/2 < c
    y = [];
    dt = [];
else
    
    ndata = length(data);
    z = data(:) .*exp(-2 * pi * 1i * c * dt * (0:ndata-1)');
    bw = highf - lowf;
    b = fir1(nfilt,bw*dt);
    x = filter(b,1,z);
    r = fix(1/(bw*2*dt));
    env = abs( x(nfilt+1:r:ndata) );      % crop first nfilt elements
    
    dty = dt*r;
end
