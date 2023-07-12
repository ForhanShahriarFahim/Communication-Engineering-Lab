clear all;close all;clc;

bits = [1 0 0 0 1 0 0 0 0 0 1 1 0 0 0 0 0 1 0 0 0 0 0 0 0 0];
voltage = 3;

zero_cnt = 0;
one_cnt = 0;
prv_nonzero_voltage = -voltage;
for i = 1 : length(bits)
    if bits(i) == 0
        zero_cnt = zero_cnt + 1;
    else
        modulated(i) = -prv_nonzero_voltage;
        prv_nonzero_voltage = -prv_nonzero_voltage;
        one_cnt = one_cnt + 1;
        zero_cnt = 0;
    endif
    if zero_cnt == 4
        if mod(one_cnt, 2) == 1
              modulated(i) = prv_nonzero_voltage;
              one_cnt = one_cnt + 1;
        else
              modulated(i-3) = -prv_nonzero_voltage;
              modulated(i) = -prv_nonzero_voltage;
              prv_nonzero_voltage = -prv_nonzero_voltage;
              one_cnt = one_cnt + 2;
         endif
        zero_cnt = 0;
        elseif bits(i) == 0
          modulated(i) = 0;
    endif

endfor

bit_duration = 2;
fs = 100;
Total_time = length(bits) * bit_duration;   # time needed to send whole data
time = 0: 1/fs: Total_time;

idx = 1;
for i = 1 : length(time)
    signal(i) = modulated(idx);
    if time(i) / bit_duration >= idx
        idx = idx + 1;
    endif
endfor

# ploting
plot(time, signal);
xticks([0: bit_duration: Total_time]);
yticks([-voltage-2: 2: voltage+2]);
ylim([-voltage-2, voltage+2]);
xlim([0, Total_time]);
grid on;
title("HDB3");
xlabel("Time");
ylabel("Amplitude");
line ([0, Total_time], [0 0], "linestyle", "--", "color", "r");




%Demodulation
idx = 1;
prv_nonzero_voltage = -voltage;
for i = 1 : length(time)
    if time(i)/bit_duration >= idx
        data = signal(i);

        if data == 0
            demodulated(idx) = 0;
        elseif (data == prv_nonzero_voltage)
            demodulated(idx-3) = 0;
            demodulated(idx-2) = 0;
            demodulated(idx-1) = 0;
            demodulated(idx) = 0;
        else
            demodulated(idx) = 1;
            prv_nonzero_voltage = -prv_nonzero_voltage;
        endif
        idx = idx + 1;
    endif
endfor

disp("Orginal bits:");
disp(bits);

disp("Demodulation:");
disp(demodulated);

