clear all

syms X

% motor parameters
P = 6; % number of poles
lambda_m = 0.1062;  %flux constant V-s/rad
r_s = 0.01;  % stator resistance in ohms
L_d = 0.3e-3; %d-axis inductance in H
L_q = 0.3e-3; %q-axis inductance in H

% Filter parameters
L = 5e-6; % inductance in H
R = 0.01; % resistance in ohms
C = 1e-3; % capacitance in F

V_batt = 350;  % battery voltage

% define electrical rotor speed
omega_r = 3000*2*pi/60 * P/2; % rad/s


% set q-axis current
I_qs_star = 0;  %replace

%set d-axis current to zero
I_ds_star = 0;


% Current Control gains
Kq = 0.5;
Kd = 0.5;

N_w = 2;
N_i = 1000;
I_max = 250; % maximum current in A
V_max = (V_batt)/sqrt(3); % maximum voltage in V

N_w = 5000;
w_r = linspace(0,N_w,N_w); %linspace(0, 5000, N_w); % electrical rotor speed in radians per second
% I_ds = linspace(0,I_max,1000); %linspace(0, I_max, N_i); % in Amps
I_ds = zeros(1,N_w);  

for i = 1:N_w
    I_qs(i) = sqrt(I_max^2 - I_ds(i)^2);
    V_qs(i) = r_s*I_qs(i) + w_r(i)*L_d*I_ds(i) + w_r(i)*lambda_m;
    V_ds(i) = r_s*I_ds(i) - w_r(i)*L_q*I_qs(i);
    V_p(i) = sqrt(V_qs(i)^2 + V_ds(i)^2);
    if V_p(i) < V_batt/sqrt(3)
        Te(i) = (3/2)*(P/2)*(lambda_m*I_qs(i) + (L_d - L_q)*I_qs(i)*I_ds(i));
    else
        N_i = 1000;
        I_ds_temp = linspace(-I_max,0,N_i);
        Te_temp = zeros(1,N_i);
        for j = 1:N_i
            I_qs_temp(j) = sqrt(I_max^2 - I_ds_temp(j)^2);
            V_qs_temp(j) = r_s*I_qs_temp(j) + w_r(i)*L_d*I_ds_temp(j) + w_r(i)*lambda_m;
            V_ds_temp(j) = r_s*I_ds_temp(j) - w_r(i)*L_q*I_qs_temp(j);
            V_p_temp(j) = sqrt(V_qs_temp(j)^2 + V_ds_temp(j)^2);
            if V_p_temp(j) < V_batt/sqrt(3)
                Te_temp(j) = (3/2)*(P/2)*(lambda_m*I_qs_temp(j) + (L_d - L_q)*I_qs_temp(j)*I_ds_temp(j));
            end
        end
        idx = Te_temp==max(Te_temp);
        Te(i) = Te_temp(idx);
        I_qs(i) = I_qs_temp(idx);
        I_ds(i) = I_ds_temp(idx);
        V_qs(i) = V_qs_temp(idx);
        V_ds(i) = V_ds_temp(idx);
        V_p(i) = V_p_temp(idx);
    end
end
figure(1)
plot(w_r, Te)
ylim([0,130])
figure(2)
plot(w_r, V_p)
figure(3)
plot(w_r, I_ds)
hold on
plot(w_r, I_qs)
figure(4)
plot(w_r, I_qs)