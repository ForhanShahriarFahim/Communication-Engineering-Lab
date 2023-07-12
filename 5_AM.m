clc; #... Clear command line
clear all; #... Clear variables
close all; #... Clear figures

msg_amplitude = 1; #... Amplitude of message signal
msg_frequency = 2; #... Frequency(Hz) of message signal
time = 0:0.001:3; #... Time samples
message_signal = msg_amplitude*sin(2*pi*msg_frequency*time); #... Message signal
subplot(4,1,1);
plot(time, message_signal);
title('Message Signal');

carrier_amplitude = 1; #... Amplitude of carrier signal
carrier_frequency = 30; #... Frequency(Hz) of carrier signal
carrier_signal = carrier_amplitude*sin(2*pi*carrier_frequency*time); #... Carrier signal
subplot(4,1,2);
plot(time, carrier_signal);
title('Carrier Signal');

#... Modulation
modulated_signal = (carrier_amplitude+message_signal).*sin(2*pi*carrier_frequency*time);
subplot(4,1,3);
plot(time, modulated_signal);
title('Modulated Signal');

#... Demodulation
demodulated_signal = (modulated_signal./carrier_signal)-carrier_amplitude;
subplot(4,1,4);
plot(time, demodulated_signal);
title('Demodulated Signal');
