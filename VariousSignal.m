clc; #... Clear command line
clear all; #... Clear variables
close all; #... Clear figures

#... Analog signal
frequency = 5; #... Frequency(Hz)
amplitude = 12; #... Amplidude
time = 0:0.01:2; #... Analog time samples
analog_signal = amplitude*sin(2*pi*frequency*time);
subplot(3, 1, 1);
plot(time, analog_signal);
title("Analog Signal");

#... Digital signal
sampling_frequency = 100; #... Sampling frequency(Hz)
n = 0:1/sampling_frequency:2; #... Samples
digital_signal = amplitude*sin(2*pi*frequency*n);
subplot(3, 1, 2);
stem(n, digital_signal, ".");
title("Digital Signal");

#... Composite signal
t = 0:0.01:2;
x = 5*sin(2*pi*7*t)+7*cos(2*pi*4*t);
subplot(3, 1, 3);
plot(t, x);
title("Composite Signal");
