%% 
clc;
clear all;
close all;



load dataset_lab_150.mat
%% 


%% 
% 1st person
csi_amplitude1=abs(csi1);
csi_phase1=angle(csi1)*180/pi;

[A,B,C,D]=size(csi_phase1);

tot_sample=size(label,1);

%% 
% 2nd person
csi_amplitude2=abs(csi2);
csi_phase2=angle(csi2)*180/pi;
%% 

subplot(2,1,1);
plot(csi_amplitude1(:,15,1,21));
hold on
plot(csi_amplitude2(:,15,1,521));

legend('Subject-1','Subject-2');
ylabel('Amplitude');
xlabel('Sample Point');
title('Amplitude variation with Subject for the Sign word "COW"');
subplot(2,1,2);
plot(csi_phase1(:,15,1,21));
hold on
plot(csi_phase2(:,15,1,521));
legend('Subject-1','Subject2');
ylabel('Phase');
xlabel('Sample Point');
title('Phase variation with Subject for the Sign word "COW"');
%%
%3rd person
csi_amplitude3=abs(csi3);
csi_phase3=angle(csi3)*180/pi;

%4th person
csi_amplitude4=abs(csi4);
csi_phase4=angle(csi4)*180/pi;

%5th person
csi_amplitude5=abs(csi5);
csi_phase5=angle(csi5)*180/pi;





%% Amplitude Pre_processing using Moving Average Filter

filtered_amp1=movmean(csi_amplitude1,5,1);

filtered_amp2=movmean(csi_amplitude2,5,1);

filtered_amp3=movmean(csi_amplitude3,5,1);

filtered_amp4=movmean(csi_amplitude4,5,1);

filtered_amp5=movmean(csi_amplitude5,5,1);

%Here MAF used of 5 window


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
   filtered_phase1(:,:,d(i),:)=csi_phase1(:,:,i,:)-csi_phase1(:,:,d(i+1),:);
   
   filtered_phase2(:,:,d(i),:)=csi_phase2(:,:,i,:)-csi_phase2(:,:,d(i+1),:);

   filtered_phase3(:,:,d(i),:)=csi_phase3(:,:,i,:)-csi_phase3(:,:,d(i+1),:);

   filtered_phase4(:,:,d(i),:)=csi_phase4(:,:,i,:)-csi_phase4(:,:,d(i+1),:);

   filtered_phase5(:,:,d(i),:)=csi_phase5(:,:,i,:)-csi_phase5(:,:,d(i+1),:);

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

ready_for_python_amp1=reshape(filtered_amp1,[],D);
ready_for_python_amp2=reshape(filtered_amp2,[],D);
ready_for_python_amp3=reshape(filtered_amp3,[],D);
ready_for_python_amp4=reshape(filtered_amp4,[],D);
ready_for_python_amp5=reshape(filtered_amp5,[],D);
%%

ready_for_python_phase1=reshape(filtered_phase1,[],D);
ready_for_python_phase2=reshape(filtered_phase2,[],D);
ready_for_python_phase3=reshape(filtered_phase3,[],D);
ready_for_python_phase4=reshape(filtered_phase4,[],D);
ready_for_python_phase5=reshape(filtered_phase5,[],D);
%% adding 5 csi together


ready_for_python_phase=[ready_for_python_phase1 ready_for_python_phase2 ready_for_python_phase3 ready_for_python_phase4 ready_for_python_phase5];
ready_for_python_amp=[ready_for_python_amp1 ready_for_python_amp2 ready_for_python_amp3 ready_for_python_amp4 ready_for_python_amp5];

%% importing the data in csv file

writematrix(ready_for_python_amp,'amp_lab150_dl.csv');
%%
writematrix(ready_for_python_phase,'phase_lab150_dl.csv');
%% 

%writematrix(label,'corresponding_label_for_lab150dl.csv')