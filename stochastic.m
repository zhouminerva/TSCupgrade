rng default
model = 'Upgrade3';
load_system(model)
trials = 1000;

tpaAll = zeros(4, trials);
thromAll = zeros(4, trials);
goodOutcome = zeros(4, trials);
goodOutcomeC = zeros(4, trials);

timeTPA = zeros(4, trials);
timeEVT = zeros(4, trials);

Apresent = zeros(4, trials);
% Atransfer = zeros(4, trials);
Atreat = zeros(4, trials);

Bpresent = zeros(4, trials);
Btransfer = zeros(4, trials);
Btreat = zeros(4, trials);

Cpresent = zeros(4, trials);
Ctransfer = zeros(4, trials);
Ctreat = zeros(4, trials);

params = get_param(model, 'modelworkspace');
params.assignin('hospital_dist',10);
params.assignin('radius',15);

for q=1:trials

randParam;
params.assignin('seed',q);
params.assignin('ICHrate', ICH);
params.assignin('tPA_CI', tpaCI);
params.assignin('throm_CI', evtCI);
params.assignin('tPAresp_LVO', LVOrecanal);
params.assignin('reperf_rate', reperf);
params.assignin('CTA_time', CTAtime);
params.assignin('CSC_DTN', cscDTN);
params.assignin('transfer_lag', transfer);
params.assignin('PSC_DTN', pscDTN);
params.assignin('CSC_NTP', cscNTP);

params.assignin('DEFUSEe',DefE);
params.assignin('DAWNe',DawE);

simOut = sim(model);

extractData3;
CSCupgrade3;
Coutcomes;

tpaAll(:,q) = tpaData;
thromAll(:,q) = thromData;
goodOutcome(:,q) = num;
goodOutcomeC(:,q) = Cnum;

timeTPA(:,q) = tpaTime;
timeEVT(:,q) = thromTime;

Apresent(:,q) = AP;
Atreat(:,q) = ATr;

Bpresent(:,q) = BP;
Btransfer(:,q) = BTf;
Btreat(:,q) = BTr;

Cpresent(:,q) = CP;
Ctransfer(:,q) = CTf;
Ctreat(:,q) = CTr;

end

%Print out distribution numbers
for n=1:length(routes)
fprintf('%s\n', char(routes(n)));

fprintf('Median Time to tPA: %4.2f', median(timeTPA(n,:)));
fprintf(' [%4.2f', quantile(timeTPA(n,:),0.25));
fprintf(', %4.2f]\n', quantile(timeTPA(n,:),0.75));

fprintf('Percent tPA: %4.2f', median(tpaAll(n,:))*100);
fprintf(' [%4.2f', quantile(tpaAll(n,:),0.25)*100);
fprintf(', %4.2f]\n', quantile(tpaAll(n,:),0.75)*100);

fprintf('Median Time to EVT: %4.2f', median(timeEVT(n,:)));
fprintf(' [%4.2f', quantile(timeEVT(n,:),0.25));
fprintf(', %4.2f]\n', quantile(timeEVT(n,:),0.75));

fprintf('Percent EVT: %4.2f', median(thromAll(n,:))*100);
fprintf(' [%4.2f', quantile(thromAll(n,:),0.25)*100);
fprintf(', %4.2f]\n', quantile(thromAll(n,:),0.75)*100);

fprintf('Percent Good Outcome: %4.2f', median(goodOutcome(n,:))*100);
fprintf(' [%4.2f', quantile(goodOutcome(n,:),0.25)*100);
fprintf(', %4.2f]\n', quantile(goodOutcome(n,:),0.75)*100);

fprintf('Percent Good Outcome in C: %4.2f', median(goodOutcomeC(n,:))*100);
fprintf(' [%4.2f', quantile(goodOutcomeC(n,:),0.25)*100);
fprintf(', %4.2f]\n', quantile(goodOutcomeC(n,:),0.75)*100);

fprintf('Presenting to A: %4.2f', median(Apresent(n,:))*100);
fprintf(' [%4.2f', quantile(Apresent(n,:),0.25)*100);
fprintf(', %4.2f]\n', quantile(Apresent(n,:),0.75)*100);

fprintf('Treated at A: %4.2f', median(Atreat(n,:))*100);
fprintf(' [%4.2f', quantile(Atreat(n,:),0.25)*100);
fprintf(', %4.2f]\n', quantile(Atreat(n,:),0.75)*100);

fprintf('Presenting to B: %4.2f', median(Bpresent(n,:))*100);
fprintf(' [%4.2f', quantile(Bpresent(n,:),0.25)*100);
fprintf(', %4.2f]\n', quantile(Bpresent(n,:),0.75)*100);

fprintf('Transfer out of B: %4.2f', median(Btransfer(n,:))*100);
fprintf(' [%4.2f', quantile(Btransfer(n,:),0.25)*100);
fprintf(', %4.2f]\n', quantile(Btransfer(n,:),0.75)*100);

fprintf('Treated at B: %4.2f', median(Btreat(n,:))*100);
fprintf(' [%4.2f', quantile(Btreat(n,:),0.25)*100);
fprintf(', %4.2f]\n', quantile(Btreat(n,:),0.75)*100);

fprintf('Presenting to C: %4.2f', median(Cpresent(n,:))*100);
fprintf(' [%4.2f', quantile(Cpresent(n,:),0.25)*100);
fprintf(', %4.2f]\n', quantile(Cpresent(n,:),0.75)*100);

fprintf('Transfer out of C: %4.2f', median(Ctransfer(n,:))*100);
fprintf(' [%4.2f', quantile(Ctransfer(n,:),0.25)*100);
fprintf(', %4.2f]\n', quantile(Ctransfer(n,:),0.75)*100);

fprintf('Treated at C: %4.2f', median(Ctreat(n,:))*100);
fprintf(' [%4.2f', quantile(Ctreat(n,:),0.25)*100);
fprintf(', %4.2f]\n\n', quantile(Ctreat(n,:),0.75)*100);
end
