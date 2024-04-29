clear all; close all; clc;

Voltage_vec=[3:1:10]';
%Alpha_vec=[0.01:0.025:1.99]';
%K_vec=[1 5 10]';
%K_vec=[1:0.05:10]';
Alpha_vec=[5/(12.5/2) 9/(12.5/2) 10/(12.5/2)]';
K_vec=[5]';

total=(length(Voltage_vec))*(length(Alpha_vec))*(length(K_vec));
loopnum=0;

for index_V=1:length(Voltage_vec)
    for index_A=1:length(Alpha_vec)
        for index_K=1:length(K_vec)

            [TO_vel,theta,dtheta] = equationsofmotion_fxn(K_vec(index_K,1)...
                ,Voltage_vec(index_V,1),Alpha_vec(index_A,1));

            TO_vel_mat(index_K,index_V,index_A)=TO_vel;
            state_space{index_K,index_A,index_V}=[theta,dtheta];
            loopnum=loopnum+1;
            progress = loopnum/total*100

        end
    end
end

save('edit_state_space_10032023.mat')