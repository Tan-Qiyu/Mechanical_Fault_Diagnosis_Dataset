function [env,dty] = envelope2(data,dt,lowf,highf)
% [env,dty] = envelope1(data,dt,nfilt,lowf,highf);
%Inputs:
% data      :data vector, time domain
% dt        :sampling time interval
% lowf      :low frequency limit of bandpass filter
% highf     :high frequency limit of bandpass filter
%Outputs:
% env       :Envelope of data
% dty       :decimated sample rate
 
n = length(data);
dfq = 1/dt/n;
idxLow = floor(lowf/dfq);
idxHi = ceil(highf/dfq);
D = fft(data);
idx = idxHi-idxLow + 1;
 
D(1:idx) = D(idxLow:idxHi);
D(idx+1:end) = 0;
data = abs(ifft(D));
bw = highf - lowf;
r = fix(1/(bw*2*dt));
env =  data(1:r:n);   % crop first nfilt elements
 
dty = dt*r;

