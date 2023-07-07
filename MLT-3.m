clc; #... Clear command line
clear all; #... Clear variables
close all; #... Clear figures

bits = [1 0 1 1 0 0 1];

#... Modulation
bitrate = 1;
voltage = 5;

sampling_rate = 1000;
sampling_time = 1/sampling_rate;

end_time = length(bits)/bitrate;
time = 0:sampling_time:end_time;

index = 1;
#... Assume that last state was positive
sign = 1; #... Indicates inversion
last = 1;
if bits(1) == 1
    sign = 0;
endif

for i = 1:length(time)
    modulation(i) = sign*voltage;
    if time(i)*bitrate >= index
        if sign != 0
            last = sign;
        endif
        index = index+1;
        if index <= length(bits) && bits(index) == 1
            if sign == 0
                sign = -last;
            else
                sign = 0;
            endif
        endif
    endif
endfor

plot(time, modulation);
axis([0 end_time -voltage-5 voltage+5]);
line([0 end_time], [0,0]);
grid on;

#... Demodulation
index = 1;
last = voltage;

for i = 1:length(modulation)
    if modulation(i) == last
        demodultaion(index) = 0;
    else
        demodultaion(index) = 1;
    endif
    if time(i)*bitrate >= index
        index = index+1;
        last = modulation(i);
    endif
endfor

disp(demodultaion);
