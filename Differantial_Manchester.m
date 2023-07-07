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
if bits(index) == 0
    sign = -1*sign;
endif

for i = 1:length(time)
    if time(i)*bitrate < index-(bitrate/2)
        modulation(i) = sign*voltage;
    else
        modulation(i) = -sign*voltage;
    endif
    if time(i)*bitrate >= index
        index = index+1;
        #... Inversion when next bit "0"
        if index <= length(bits) && bits(index) == 0
            sign = -1*sign;
        endif
    endif
endfor

plot(time, modulation,"LineWidth",1);
axis([0 end_time -voltage-5 voltage+5]);
line([0 end_time], [0,0]);
grid on;

#... Demodulation
index = 1;
last = voltage;

for i = 1:length(modulation)
    if modulation(i) == last && time(i)*bitrate < index-(bitrate/2)
        demodultaion(index) = 1;
    endif
    if modulation(i) != last && time(i)*bitrate < index-(bitrate/2)
        demodultaion(index) = 0;
    endif
    if time(i)*bitrate >= index
        last = modulation(i);
        index = index+1;
    endif
endfor

disp(demodultaion);
