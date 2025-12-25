%% 
clc;
clear all;
close all;



load dataset_lab_276_dl.mat

csi_amplitude=abs(csid_lab);
csi_phase=angle(csid_lab)*180/pi;

[A,B,C,D]=size(csi_phase);

tot_sample=size(label_lab,1);



%% Amplitude Pre_processing using Moving Average Filter

filtered_amp=movmean(csi_amplitude,5,1);

%Here MAF used of 5 window


%% 

%% plotting the data
plot(filtered_amp(:,13,3,245));

hold on
plot(csi_amplitude(:,13,3,245));
legend('filtered','raw');



%% Phase Pre_processing
d=[1 2 3 1];
for i=1:3
   filtered_phase(:,:,d(i),:)=csi_phase(:,:,i,:)-csi_phase(:,:,d(i+1),:);
end



%% 



% %% plotting the data
% 
% plot(filtered_phase(:,13,3,245));
% 
% hold on
% plot(csi_phase(:,13,3,245));
% legend('filtered','raw');
%     
% %% 
% rng default
% as = rand(2,2,3);
% 
% ad = reshape(as,6,2);




%% Reshaping the data for python

ready_for_python_amp=reshape(filtered_amp,[],D);
ready_for_python_phase=reshape(filtered_phase,[],D);




%% importing the data in csv file

writematrix(ready_for_python_amp,'amp_lab_down.csv');
%% 
writematrix(ready_for_python_phase,'phase_lab_down.csv');
%% 