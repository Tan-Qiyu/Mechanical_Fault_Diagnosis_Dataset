function d = GetBearFreqRatio(rd,pd,ca,ne,type,side)
% Cage passing frequency:	 f/2 (1-d/e cos (?) )
% Inner race passing frequency	bf/2 (1 + d/e cos (?) )
% Outer race passing frequency	bf/2 (1 - d/e cos (?) )
% Ball passing frequency	ef/d (1-(d/e)2 cos2(?) )
% Where 
% f is the driving frequency 
% b is the number of rolling elements
% d is the ball bearing diameter 
% e is the bearing pitch diameter and
% ? is the bearing contact angle.

%Get the bearing Freq. ratio
%rd:    roller diameter
%pd:    pitch diameter
%ca:    contact angle in degrees
%ne:    number of elements
%type   enum[cage, roller, outer race, inner race]
%side: inner or outer race fixed.  inner = 1, outer = 2;
%Eric Bechhoefer, April 10, 2009 for PHM Conference
%Ref: Timken Bearings Catalog 2008
rdpd = rd/pd;
cs = cos(ca*pi/180);
pdrd = 1/rdpd;
if type == 1,       %cage freq ratio
    if side == 1,
        d = 0.5*(1-rdpd*cs);
    else
        d = 0.5*(1+rdpd*cs);
    end
elseif type == 2,   %roller freq ratio
    d = (1-(rdpd*cs)^2)*pdrd;
elseif type == 3,   %outer race freq ratio
    d = 0.5*(1-rdpd*cs)*ne;
else                %inner race freq 
    d = 0.5*(1+rdpd*cs)*ne;
end
