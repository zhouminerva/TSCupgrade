%generate random values

%ICH rate
ICH = randraw('tri', [.03, .06, .09], 1);
%tPA contraindications
tpaCI = randraw('tri', [.0610, .101, .141], 1);
%EVT contraindications
evtCI = randraw('tri', [.087, .112, .137], 1);
%LVO recanalization with tPA
LVOrecanal = randraw('tri', [.14, .18, .22], 1);
%rate of reperfusion
reperf = randraw('tri', [.65, .8, .95], 1);

%DEFUSE eligibility
DefE = randraw('tri', [.2641, .4361, .5221], 1);
%DAWN eligibility
DawE = randraw('tri', [.1443, .2903, .3633], 1);


%CTA time
CTAtime = randraw('tri', [10, 15, 30], 1);
%PSC_DTN
pscDTN = randraw('tri', [50, 60, 100], 1);
%CSC_DTN
cscDTN = randraw('tri', [30, 40, 60], 1);
%CSC_NTP
cscNTP = randraw('tri', [30, 60, 90], 1);
%transfer lag in addition to travel
transfer = randraw('tri', [30, 50, 70], 1);
