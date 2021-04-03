% motor parameters
P = 6; % number of poles
lambda_m = 0.1062;  %flux constant V-s/rad
rs = 0.01;  % stator resistance in ohms
Ld = 0.3e-3; %d-axis inductance in H
Lq = 0.3e-3; %q-axis inductance in H

% Filter parameters
L = 5e-6; % inductance in H
R = 0.01; % resistance in ohms
C = 1e-3; % capacitance in F

V_batt = 350;  % battery voltage

% define electrical rotor speed
omega_r = 3000*2*pi/60 * P/2; % rad/s


% set q-axis current
I_qs_star = 209.25;  %replace

%set d-axis current to zero
I_ds_star = 0;


% Current Control gains
Kq = 0.5;
Kd = 0.5;

figure(1)
plot(out.tout, out.Te)
title('Response Plot of Torque')
xlabel('Response Time (seconds)')
ylabel('Torque (N-m)')

figure(2)
plot(out.tout, out.Vas)
title('Response Plot of Stator Voltage in a-Axis coil winding')
xlabel('Response Time (seconds)')
ylabel('Voltage (V)')

figure(3)
plot(out.tout, out.ias)
title('Response Plot of Stator Current in the a-Axis coil winding')
xlabel('Response Time (seconds)')
ylabel('Current (A)')

figure(4)
plot(out.tout, out.Vdc)
title('Response Plot of DC Voltage')
xlabel('Response Time (seconds)')
ylabel('DC Voltage (V)')

figure(5)
plot(out.tout, out.idc)
title('Response Plot of DC Current')
xlabel('Response Time (seconds)')
ylabel('DC Current (A)')

figure(6)
plot(out.tout, out.ibatt)
title('Response Plot of Battery Current')
xlabel('Response Time (seconds)')
ylabel('Battery Current (A)')