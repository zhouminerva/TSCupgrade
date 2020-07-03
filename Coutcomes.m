pt_num = length(logsout{1}.Values.NIHSS.Data)+length(logsout{2}.Values.NIHSS.Data)+length(logsout{3}.Values.NIHSS.Data);

routes = {'Bypass', 'Nearest','UpgradeBypass','Upgrade_NC'};
Cnum = zeros(4, 1);
allC = sum(logsout{1}.Values.cPop.Data(:)==true)+sum(logsout{2}.Values.cPop.Data(:)==true)+sum(logsout{3}.Values.cPop.Data(:)==true);

for i=1:4
    Cindex = 0;
    CoutcomeNum = zeros(1, allC);
    %hospital C
    CHosp = logsout{3*i}.Values.cPop.Data;
    for j=1:length(CHosp)
        if CHosp(j)==true
            Cindex = Cindex+1;
            CoutcomeNum(Cindex)=logsout{3*i}.Values.outcome.Data(j);
        end
    end
    %hospital B
    BHosp = logsout{3*i-1}.Values.cPop.Data;
    for p=1:length(BHosp)
        if BHosp(p)==true
            Cindex = Cindex+1;
            CoutcomeNum(Cindex)=logsout{3*i-1}.Values.outcome.Data(p);
        end
    end
    %hospital A
    AHosp = logsout{3*i-2}.Values.cPop.Data;
    for n=1:length(AHosp)
        if AHosp(n)==true
            Cindex = Cindex+1;
            CoutcomeNum(Cindex)=logsout{3*i-2}.Values.outcome.Data(n);
        end
    end
    
    Cnum(i) = (sum(CoutcomeNum(:)<=2)/pt_num)
end