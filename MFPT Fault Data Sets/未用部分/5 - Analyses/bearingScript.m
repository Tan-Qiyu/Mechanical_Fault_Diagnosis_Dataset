function bearingScript(bearing)
%runs a the beairng analysis. This is from the MFPT data set
if nargin == 0
    load InnerRaceFault_vload_7.mat
end


[rd,pd,ca,ne,side] = NiceBearing; %get the dimensions of the nice bearing
faultRates = ones(5,1); %[cage, ball, outer, inner, shaft];
for i = 1:4
    faultRates(i) = GetBearFreqRatio(rd,pd,ca,ne,i,side);%calculate the bearing fault rate
end
faultFreq = faultRates * bearing.rate;

% [env,dty] = envelope1(bearing.gs,1/bearing.sr,128,2000,4000);
[env,dty] = envelope2(bearing.gs,1/bearing.sr,2000,4000);

[spec, freq] = psde(env, 8192,1/dty, 4096);

plot(freq,spec);
ax = axis();
hold on
for i = 1:5
    f = faultFreq(i);
    plot([f f],ax(3:4),'LineWidth',2)
end
hold off
legend('env','cage','ball','outer','inner','1/rev')
xlabel('Hz')
ylabel('Gs')
axis([0 200 ax(3:4)])