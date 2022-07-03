% Errorplot

% % 1D
% Nrm_Err_FOU = [0.3448 0.3364 0.3325];
% Nrm_Err_SOU = [0.3688 0.3513 0.3427];
% Nrm_Err_QUICK = [0.3245 0.3214 0.3174];

% 2D
Nrm_Err_FOU = [0.5710 0.5263 0.4339];
Nrm_Err_SOU = [ 0.6237 0.5877 0.5139];
Nrm_Err_QUICK = [0.6144 0.5713 0.4917];

cell_size = [10.53 5.13 2.53];

figure(6)
 
loglog(cell_size , Nrm_Err_FOU ,'-b*', 'linewidth' , 3)
hold on
loglog(cell_size , Nrm_Err_SOU ,'-gs', 'linewidth' , 3)
hold on
loglog(cell_size , Nrm_Err_QUICK ,'-r^', 'linewidth' , 3)
legend('FOU Method','SOU Method','QUICK Method')
xlabel('Cell Size')
ylabel('Error Norm')
title('Error Norm vs Cell Sizes')
set(gca,'FontName','Times New Roman','FontSize',10,'fontWeight','bold');
grid on