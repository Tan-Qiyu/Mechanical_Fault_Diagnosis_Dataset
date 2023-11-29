function [rd,pd,ca,ne,side] = NiceBearing

%rd:    roller diameter
%pd:    pitch diameter
%ca:    contact angle in degrees
%ne:    number of elements
%type   enum[cage, roller, outer race, inner race]
%side: inner or outer race fixed.  inner = 1, outer = 2;
%Eric Bechhoefer, April 10, 2009 for PHM Conference
rd = .235;
ca = 0;
ne = 8;
pd = 1.245;

side = 2;

