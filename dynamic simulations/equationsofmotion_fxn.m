%%% R. St.Pierre - 12/29/2022
%%% Equations of motion - fxn

function [TO_vel, theta, dtheta] = equationsofmotion_fxn(k,V,alpha)

%system parameters

m = 100e-6; %kg - mass of robot legs
m_rob=300e-6; %kg - mas sof robot
%k = k; %N-m - linear spring constant of rubberband (can also be nonlinear)
lambda = 12.5e-3/2; %'arm' length
%alpha=alpha;
l0 = alpha*lambda; %undeformed length of spring
theta0 = acos((l0/2)/lambda); %undeformed angle
g = 9.81; %m/s^2
mu = 0.4;
ri = 0.25e-3; %m inner radius of pin

%actuation parameters
%V=V; %V
Torque=0.01382*V/1000; %N-m

%simulation parameters
dt = 1e-6;
t_end = .1;
t = transpose(0:dt:t_end);


J = m*lambda^2; %mass moment of inertia of link with legs


theta(1,1)=-1*theta0;
dtheta(1,1)=0;
index0=[];

boolflag=0;


for index=1:length(t)

    tau_a(index,1)=Torque*cos(theta(index,1));
    tau_s(index,1)=k*lambda^2*(2*cos(theta(index,1))-alpha)*sin(theta(index,1));
    tau_f(index,1)=mu*ri*k*lambda*(2*cos(theta(index,1))-alpha)*cos(theta(index,1));

    tau_net(index,1)=tau_a(index,1)+tau_s(index,1)-tau_f(index,1)*sign(dtheta(index,1));

    ddtheta(index,1)=tau_net(index,1)/J;
    dtheta(index+1,1)=dtheta(index,1)+ddtheta(index,1)*dt;
    theta(index+1,1)=theta(index,1)+dtheta(index,1)*dt;

    if theta(index,1)>=0 && boolflag==0 && t(index,1)>0
        boolflag=1;
        index0=index;
    end

    if theta(index,1)>=theta0
        theta_TO=dtheta(index,1);
        TO_vel=lambda/2*dtheta(index,1)*cos(theta(index,1));
        break
    end

    if index==length(t)

        if isempty(index0)
            theta_TO=NaN;
            TO_vel=NaN;
        else
            theta_TO=dtheta(index,1);
            TO_vel=lambda/2*dtheta(index,1)*cos(theta(index,1));
            TO_vel=NaN;
        end
    end

end

end
