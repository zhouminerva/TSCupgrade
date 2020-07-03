pt_num = length(logsout{1}.Values.NIHSS.Data)+length(logsout{2}.Values.NIHSS.Data)+length(logsout{3}.Values.NIHSS.Data);

routes = {'Bypass', 'Nearest','UpgradeBypass','Upgrade_NC'};
outcomes = zeros(1, 7);

tpaTime = zeros(4,1);
thromTime = zeros(4,1);
tpaData = zeros(4,1);
thromData = zeros(4,1);
num = zeros(4,1);

for i=1:4
    firstArrival = vertcat(logsout{3*i-2}.Values.firstArrival.Data(:), logsout{3*i-1}.Values.firstArrival.Data(:), logsout{3*i}.Values.firstArrival.Data(:));
    tPA = vertcat(logsout{3*i-2}.Values.tPAtime.Data(:), logsout{3*i-1}.Values.tPAtime.Data(:), logsout{3*i}.Values.tPAtime.Data(:));
    tPA = tPA(~tPA(:)==0);
    throm = vertcat(logsout{3*i-2}.Values.thromTime.Data(:), logsout{3*i-1}.Values.thromTime.Data(:), logsout{3*i}.Values.thromTime.Data(:));
    throm = throm(~throm(:)==0);
    
    tPAlogical = sum(logsout{3*i-2}.Values.tPA.Data(:)==true)+sum(logsout{3*i-1}.Values.tPA.Data(:)==true)+sum(logsout{3*i}.Values.tPA.Data(:)==true);
    totalPts = length(logsout{3*i-2}.Values.tPA.Data)+length(logsout{3*i-1}.Values.tPA.Data)+length(logsout{3*i}.Values.tPA.Data);
    thromLogical = sum(logsout{3*i-2}.Values.throm.Data(:)==true)+sum(logsout{3*i-1}.Values.throm.Data(:)==true)+sum(logsout{3*i}.Values.throm.Data(:)==true);
    data = vertcat(logsout{3*i-2}.Values.outcome.Data(:), logsout{3*i-1}.Values.outcome.Data(:), logsout{3*i}.Values.outcome.Data(:));
%     
%     fprintf('%s\n', char(routes(i)));
% %     fprintf('Time of First Arrival to Any Hospital: %5.2f', median(firstArrival));
% %     fprintf(' [%4.2f', quantile(firstArrival,0.25));
% %     fprintf(', %4.2f]\n', quantile(firstArrival,0.75));
%     fprintf('Time to tPA Tx at Any Hospital: %5.2f', median(tPA));
%     fprintf(' [%4.2f', quantile(tPA,0.25));
%     fprintf(', %4.2f]\n', quantile(tPA,0.75));
%     fprintf('Time to Thrombectomy: %5.2f', median(throm));
%     fprintf(' [%4.2f', quantile(throm,0.25));
%     fprintf(', %4.2f]\n', quantile(throm,0.75));
%     fprintf('Percent to get tPA: %4.2f\n', (tPAlogical/pt_num)*100);
%     fprintf('Percent to get Thrombectomy: %4.2f\n', (thromLogical/pt_num)*100);
%     fprintf('Percent Good Outcome: %4.2f\n\n', (sum(data(:)<=2)/pt_num)*100);    

    tpaTime(i) = median(tPA);
    thromTime(i) = median(throm);
    tpaData(i) = tPAlogical/pt_num;
    thromData(i) = (thromLogical/pt_num);
    num(i) = (sum(data(:)<=2)/pt_num);
    
end