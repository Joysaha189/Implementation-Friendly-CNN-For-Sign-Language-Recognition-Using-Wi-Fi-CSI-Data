%% 
clc;
clear all;
close all;

load dataset_home_276.mat

csi_amplitude=abs(csid_home);
csi_phase=angle(csid_home)*180/pi;

[A,B,C,D]=size(csi_phase);

tot_sample=size(label_home,1);
%%
%Plotting data

%set(gca,'fontweight','bold');
subplot(2,1,1);
plot(csi_amplitude(:,3,1,163));
set(gca,'fontweight','bold');
%legend('Sub-Carrier3','Sub-Carrier4');
ylabel('Amplitude','FontWeight','bold');
xlabel('Data Point','FontWeight','bold');
title('Amplitude for the Sign word "BICYCLE"');

subplot(2,1,2);
set(gca,'fontweight','bold');
plot(csi_phase(:,3,1,163));

%legend('Sub-Carrier3','Sub-Carrier4');
ylabel('Phase',FontWeight='bold');
xlabel('Data Point',FontWeight='bold');
title('Phase  for the Sign word "BICYCLE"');
%%
%%Correlation

co=corrcoef(csi_phase(:,:,1,67));
plot(co);
xlabel('Sub-carrier');
ylabel('Correlation Coefficient');
title('Correlation between the Sub-Carriers');


%%
%importing the correlation-coefficient
ca=corrcoef(csi_amplitude(:,:,2,47));
writematrix(ca,'home_corr_amp_raw.csv');
cp=corrcoef(csi_phase(:,:,2,47));
writematrix(cp,'home_corr_phase_raw.csv');
%% 
%plotting the data
subplot(2,1,1);
plot(csi_amplitude(:,3,1,24));
hold on
plot(csi_amplitude(:,3,2,24));
hold on
plot(csi_amplitude(:,3,3,24));
set(gca,'fontweight','bold');
legend('Antenna-1','Antenna-2','Antenna-3');
ylabel('Amplitude','FontWeight','bold');
xlabel('Data Point','FontWeight','bold');
title('Amplitude variation with Anetenna for the Sign word "GIRAFFE"');
subplot(2,1,2);
plot(csi_phase(:,3,1,24));
hold on
plot(csi_phase(:,3,2,24));
hold on
plot(csi_phase(:,3,3,24));
legend('Antenna-1','Antenna-2','Antenna-3');
ylabel('Phase');
xlabel('Data Point');
title('Phase variation with Anetnna for the Sign word "GIRRAFE"');
%% 
%correlation coefficient

co=corrcoef(csi_phase(:,:,1,67));
plot(co);
xlabel('Sub-carrier');
ylabel('Correlation Coefficient');
title('Correlation between the Sub-Carriers');
table=array2table(co);
%% 
%h=latex(sym(co));
%% Amplitude Pre_processing using Moving Average Filter

filtered_amp=movmean(csi_amplitude,5,1);
% filtered_amp5=movmean(csi_amplitude,5,1);
% filtered_amp7=movmean(csi_amplitude,7,1);
%%
cmaf=corrcoef(filtered_amp(:,:,2,47));
writematrix(cmaf,'home_corr_amp_maf3.csv');
%Here MAF used of 5 window
%%
corr=corrcoef(csi_amplitude(:,13,3,34),csi_amplitude(:,15,34));
%%
plot(csi_amplitude(:,20,3,14));
hold on

plot(filtered_amp3(:,20,3,14));

legend('RAW DATA','MAF window 3');
ylabel('Amplitude','FontWeight','bold');
xlabel('Data Point','FontWeight','bold');
title('Effect of MAF for the sign word "WITH"');

%% 
subplot(1,2,1);
plot(csi_amplitude(:,1,3,156));
xlabel('Amplitude');
ylabel('Sample points');
title('Before MAF');
subplot(1,2,2);
plot(filtered_amp(:,1,3,156));
xlabel('Amplitude');
ylabel('Sample points');
title('After MAF');



%% 

% %% plotting the data
% plot(filtered_amp(:,13,3,245));
% 
% hold on
% plot(csi_amplitude(:,13,3,245));
% legend('filtered','raw');



%% Phase Pre_processing
d=[1 2 3 1];
for i=1:3
   filtered_phase(:,:,d(i),:)=csi_phase(:,:,i,:)-csi_phase(:,:,d(i+1),:);
end

%%
cpc=corrcoef(csi_amplitude(:,:,2,47));
writematrix(cpc,'home_corr_phase_fil.csv');

%% 



% %% plotting the data
%
subplot(1,2,1);
plot(csi_phase(:,12,1,195));

ylabel('Phase');
xlabel('Data Point');
title('Before Phase Correction');
% 
subplot(1,2,2);
plot(filtered_phase(:,12,1,195));

title('After Phase Correction');
ylabel('Phase');
xlabel('Data Point');
% legend('filtered','raw');
%     
% %% 
% rng default
% as = rand(2,2,3);
% ad = reshape(as,6,2);




%% Reshaping the data for python

ready_for_python_amp=reshape(filtered_amp,[],D);
ready_for_python_phase=reshape(filtered_phase,[],D);




%% importing the data in csv file

writematrix(ready_for_python_amp,'amp_home_down.csv');
writematrix(ready_for_python_phase,'phase_home_down.csv');
%% 