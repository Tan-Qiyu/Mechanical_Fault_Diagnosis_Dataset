function cis = bearingAnalysis(v,zct)

cis = zeros(1,6);

sr = 97656;
faultRates = [0.42 2.87 9.25 6.72 1];%cage, ball, inner, outer, 1/rev
idx = find(zct>6,1); %only interested in first six seconds of data.
rate = mean(1./diff(zct(1:idx))/2); 
cis(6) = rate;
faultFreq = faultRates * rate;

 [env,dty] = envelope1(v,1/sr,128,8500,11500);
 
 [spec, freq] = psde(env, 4096,1/dty, 2048);
 
 plot(freq,spec);
 ax = axis();
 hold on
 for i = 1:5,
     f = faultFreq(i);
     plot([f f],ax(3:4),'LineWidth',2)
     cis(i) = BrngEng(spec,freq(2),f);
 end
 hold off
 legend('env','cage','ball','outer','inner','1/rev')
 xlabel('Hz')
 ylabel('Gs')
 axis([0 200 ax(3:4)])
 
 function e = BrngEng(P,dFrq,hz)

hLw = hz*.97;
hHi = hz*1.02;

bLw = floor(hLw/dFrq);
if bLw == 0, 
    bLw = 1;
end
bHi = ceil(hHi/dFrq);
rng = bLw:bHi;
[e,idx] = max(P(rng));

% n = length(P);
% freq = (0:(n-1))*dFrq;
% plot(freq,P,(rng(idx)-1)*dFrq,e,'x','LineWidth',2)
% xlabel('Frequency (Hz)')
% ylabel('Gs (Hz)')
% ax = axis;
% h = line([hz hz],ax(3:4)); 
% set(h,'LineWidth',2);
% set(h,'Color',[1 0 0]);
% axis([0 500 0 ax(4)])