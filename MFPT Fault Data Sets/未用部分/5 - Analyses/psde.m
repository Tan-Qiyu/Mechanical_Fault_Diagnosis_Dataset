function [Spec, freq] = psde(x, winln,Fs, noverlap)
%[Spec, freq] = psde(x, winln,Fs, noverlap);
%Energy power spectrual density
%using Welch's method using Hann window
% x:        time domain data
% windln:   window length, e.g. 2048,
% Fs;       sampleing frequency
% noverlap: length of the overlp
n = winln;
m = n/2;
window = .5*(1 - cos(2*pi*(1:m)'/(n+1))); %Hann window
window = [window; window(end:-1:1)];
window = window(:);

nfft = length(window);

n = length(x);		    % Number of data points
nwind = length(window); % length of window
if n < nwind            % zero-pad x if it has length less than the window length
    x(n+1:nwind)=0;  
    n=nwind;
end
% Make sure x is a column vector; do this AFTER the zero-padding 
% in case x is a scalar.
x = x(:);		

k = fix((n-noverlap)/(nwind-noverlap));	% Number of windows
index = 1:nwind;

KMU = k*sum(window)^2;% alt. Normlzng scale factor ==> peaks are about right

Spec = zeros(nfft,1); 
for i=1:k
    xw = window.*detrend(x(index));
    index = index + (nwind - noverlap);
    xx = fft(xw,nfft);
    Xx = abs(xx).^2;
    Spec = Spec + Xx;
end

% Select first half
if ~any(any(imag(x)~=0)),   % if x is not complex
    if rem(nfft,2),    % nfft odd
        select = (1:(nfft+1)/2)';
    else
        select = (1:nfft/2)';
    end
    Spec = Spec(select);
else
    select = (1:nfft)';
end
freq = (select - 1)*Fs/nfft;


Spec = sqrt(Spec*(4/KMU));   % normalize

