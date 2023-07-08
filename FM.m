clc; #... Clear command line
clear all; #... Clear variables
close all; #... Clear figures

msg_amplitude = 1; #... Amplitude of message signal
msg_frequency = 2; #... Frequency(Hz) of message signal
t = 0:0.001:3; #... Time samples
msg_signal = msg_amplitude*sin(2*pi*msg_frequency*t); #... Message signal
subplot(4,1,1);
plot(t, msg_signal);
title('Message Signal');

carrier_amplitude = 1; #... Amplitude of carrier signal
carrier_frequency = 30; #... Frequency(Hz) of carrier signal
carrier_signal = carrier_amplitude*sin(2*pi*carrier_frequency*t); #... Carrier signal
subplot(4,1,2);
plot(t, carrier_signal);
title('Message Signal');

#... Modulation
modulation_index = 10;
modulated_signal = carrier_amplitude*sin(2*pi*carrier_frequency*t+(modulation_index*sin(2*pi*msg_frequency*t)));
subplot(4,1,3);
plot(t, modulated_signal);
title('Modulated Signal');

#... Demodulation
x = abs(diff(modulated_signal));
#... To use butter function we need to run the following 2 commands
#... pkg install -forge signal
pkg load signal
[a,b] = butter(10, 0.03);
demodulated_signal = filter(a,b,x);
subplot(4,1,4);
plot(demodulated_signal);
title('Demodulated Signal');
