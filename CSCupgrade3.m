pt_num = length(logsout{1}.Values.NIHSS.Data)+length(logsout{2}.Values.NIHSS.Data)+length(logsout{3}.Values.NIHSS.Data);
%has not been updated to current data order
routes = {'Bypass', 'Nearest','UpgradeBypass','Upgrade_NC'};

AP = zeros(4, 1);
% ATf = zeros(4, 1);
ATr = zeros(4, 1);

BP = zeros(4, 1);
BTf = zeros(4, 1);
BTr = zeros(4, 1);

CP = zeros(4, 1);
CTf = zeros(4, 1);
CTr = zeros(4, 1);

for i=1:4
    %pts that presented
    Apts = logsout{3*i-2}.Values.firstHosp.Data;
    Bpts = logsout{3*i-1}.Values.firstHosp.Data;
    Cpts = logsout{3*i}.Values.firstHosp.Data;
    
    noTtransferB = 0;
    TtransferB = 0;
    noTtransferC = 0;
    TtransferC = 0;
    
    CSC_TEVT = 0;
    CSC_TnoEVT = 0;
    CSC_notEVT = 0;
    CSC_noTnoEVT = 0;
    CSC_transferInEVT = 0;
    
    %all Pts at the Hosp A
    allPts = logsout{3*i-2}.Values.tPA.Data;
    CSC_EVT = logsout{3*i-2}.Values.throm.Data;
    transferInfo = logsout{3*i-2}.Values.transfer.Data;
    
    for k=1:length(allPts)
        if allPts(k)==true
            %got tPA
            if transferInfo(k)==true
                %transferred from PSC
                if Apts(k)==2
                    TtransferB = TtransferB+1;
                elseif Apts(k)==3
                    TtransferC = TtransferC+1;
                end
                if CSC_EVT(k)==true
                    %got EVT
                    CSC_transferInEVT = CSC_transferInEVT+1;
                end
            else
                %presented to CSC
                if CSC_EVT(k)==true
                    %got EVT
                    CSC_TEVT = CSC_TEVT+1;
                else
                    %no EVT
                    CSC_TnoEVT = CSC_TnoEVT+1;
                end
            end
        else
            %didn't get tPA
            if transferInfo(k)==true
                %transferred from PSC
                if Apts(k)==2
                    noTtransferB = noTtransferB+1;
                elseif Apts(k)==3
                    noTtransferC = noTtransferC+1;
                end
                if CSC_EVT(k)==true
                    %got EVT
                    CSC_transferInEVT = CSC_transferInEVT+1;
                end
            else
                %presented to CSC
                if CSC_EVT(k)==true
                    %got EVT
                    CSC_notEVT = CSC_notEVT+1;
                else
                    %no EVT
                    CSC_noTnoEVT = CSC_noTnoEVT+1;
                end
            end
        end
    end
    
    if i==3 || i==4
        tEVT = 0;
        notEVT = 0;
        TnoEVT = 0;
        noTnoEVT = 0;
        TinEVT = 0;
        tPA = logsout{3*i}.Values.tPA.Data(:);
        EVT = logsout{3*i}.Values.throm.Data(:);
        transferC = logsout{3*i}.Values.transfer.Data;
        
        for m=1:length(tPA)
            if tPA(m)==true
                %got tPA
                if transferC(m)==true
                    %came from PSC
                    if Cpts(m)==2
                        TtransferB = TtransferB+1;
                    end
                    if EVT(m)==true
                        TinEVT = TinEVT+1;
                    end
                else
                    %presented to CSC
                    if EVT(m)==true
                        %got EVT
                        tEVT = tEVT+1;
                    else
                        %no EVT
                        TnoEVT = TnoEVT+1;
                    end
                end 
            else
                %no tPA
                if transferC(m)==true
                    %came from PSC
                    if Cpts(m)==2
                        noTtransferB = noTtransferB+1;
                    end
                    if EVT(m)==true
                        TinEVT = TinEVT+1;
                    end
                else
                    %presented to CSC
                    if EVT(m)==true
                        %got EVT
                        notEVT = notEVT+1;
                    else
                        %no EVT
                        noTnoEVT = noTnoEVT+1;
                    end
                end
            end
        end
    end
    
%     fprintf('%s\n', char(routes(i)));
%     fprintf('Percent Presenting to Hospital A: %4.2f\n', ((sum(Apts(:)==1)+sum(Bpts(:)==1)+sum(Cpts(:)==1))/pt_num)*100);
% %     fprintf('Percent tPA then transfer: 0\n');
% %     fprintf('Percent no tPA then transfer: 0\n');
% %     fprintf('Percent tPA, no transfer, EVT: %4.2f\n', (CSC_TEVT/pt_num)*100);
% %     fprintf('Percent no tPA, no transfer, EVT: %4.2f\n', (CSC_notEVT/pt_num)*100);
% %     fprintf('Percent tPA, no transfer, no EVT: %4.2f\n', (CSC_TnoEVT/pt_num)*100);
% %     fprintf('Percent no tPA, no transfer, no EVT: %4.2f\n\n', (CSC_noTnoEVT/pt_num)*100);
%     fprintf('Percent transferring out: 0\n');
%     fprintf('Percent treated at A: %4.2f\n\n', ((CSC_TEVT+CSC_notEVT+CSC_TnoEVT+CSC_transferInEVT)/pt_num)*100);
% %     fprintf('Double check: %4.2f\n\n', ((sum(CSC_EVT(:)==true)+CSC_TnoEVT)/pt_num)*100);

    AP(i) = (sum(Apts(:)==1)+sum(Bpts(:)==1)+sum(Cpts(:)==1))/pt_num;
    % ATf = zeros(4, 1);
    ATr(i) = (CSC_TEVT+CSC_notEVT+CSC_TnoEVT+CSC_transferInEVT)/pt_num;
    
%     fprintf('Percent Presenting to Hospital B: %4.2f\n', ((sum(Apts(:)==2)+sum(Bpts(:)==2)+sum(Cpts(:)==2))/pt_num)*100);
% %     fprintf('Percent tPA then transfer: %4.2f\n', (TtransferB/pt_num)*100);
% %     fprintf('Percent no tPA then transfer: %4.2f\n', (noTtransferB/pt_num)*100);
% %     fprintf('Percent tPA, no transfer, EVT: 0\n');
% %     fprintf('Percent no tPA, no transfer, EVT: 0\n');
    tPAnum = sum(logsout{3*i-1}.Values.tPA.Data(:)==true);
% %     fprintf('Percent tPA, no transfer, no EVT: %4.2f\n', (tPAnum/pt_num)*100);
% %     fprintf('Percent no tPA, no transfer, no EVT: %4.2f\n\n', ((length(Bpts)-tPAnum)/pt_num)*100);
%     fprintf('Percent transferring out: %4.2f\n', ((TtransferB+noTtransferB)/pt_num)*100);
%     fprintf('Percent treated at B: %4.2f\n\n', ((tPAnum+TtransferB)/pt_num)*100);

    BP(i) = (sum(Apts(:)==2)+sum(Bpts(:)==2)+sum(Cpts(:)==2))/pt_num;
    BTf(i) = (TtransferB+noTtransferB)/pt_num;
    BTr(i) = (tPAnum+TtransferB)/pt_num;
    
%     fprintf('Percent Presenting to Hospital C: %4.2f\n', ((sum(Apts(:)==3)+sum(Bpts(:)==3)+sum(Cpts(:)==3))/pt_num)*100);
% %     fprintf('Percent tPA then transfer: %4.2f\n', (TtransferC/pt_num)*100);
% %     fprintf('Percent no tPA then transfer: %4.2f\n', (noTtransferC/pt_num)*100);
%     fprintf('Percent transferring out: %4.2f\n', ((TtransferC+noTtransferC)/pt_num)*100);
    
    CP(i) = (sum(Apts(:)==3)+sum(Bpts(:)==3)+sum(Cpts(:)==3))/pt_num;
    CTf(i) = (TtransferC+noTtransferC)/pt_num;
    
    if i==3 || i==4
% %         fprintf('Percent tPA, no transfer, EVT: %4.2f\n', (tEVT/pt_num)*100);
% %         fprintf('Percent no tPA, no transfer, EVT: %4.2f\n', (notEVT/pt_num)*100);
% %         fprintf('Percent tPA, no transfer, no EVT: %4.2f\n', (TnoEVT/pt_num)*100);
% %         fprintf('Percent no tPA, no transfer, no EVT: %4.2f\n\n', (noTnoEVT/pt_num)*100);
%         fprintf('Percent treated at C: %4.2f\n\n', ((TtransferC+tEVT+notEVT+TnoEVT+TinEVT)/pt_num)*100);
% %         fprintf('Double check: %4.2f\n\n', ((sum(EVT(:)==true)+TnoEVT)/pt_num)*100);

        CTr(i) = (TtransferC+tEVT+notEVT+TnoEVT+TinEVT)/pt_num;
    else
% %         fprintf('Percent tPA, no transfer, EVT: 0\n');
% %         fprintf('Percent no tPA, no transfer, EVT: 0\n');
        tPAnum = sum(logsout{3*i}.Values.tPA.Data(:)==true);
% %         fprintf('Percent tPA, no transfer, no EVT: %4.2f\n', (tPAnum/pt_num)*100);
% %         fprintf('Percent no tPA, no transfer, no EVT: %4.2f\n\n', ((length(Cpts)-tPAnum)/pt_num)*100);
%         fprintf('Percent treated at C: %4.2f\n\n', ((tPAnum+TtransferC)/pt_num)*100);
        
        CTr(i) = (tPAnum+TtransferC)/pt_num;
    end
    
    
%     outputs(i, 8, q)=((pt_num-PSCpts-transfers)/pt_num);
%     outputs(i, 9, q)=0;
%     outputs(i, 10, q)=0;
%     outputs(i, 11, q)=(CSC_TEVT/pt_num);
%     outputs(i, 12, q)=(CSC_notEVT/pt_num);
%     outputs(i, 13, q)=(CSC_TnoEVT/pt_num);
%     outputs(i, 14, q)=(CSC_noTnoEVT/pt_num);
end