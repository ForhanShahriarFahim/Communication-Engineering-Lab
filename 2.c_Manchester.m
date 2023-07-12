clc; #... Clear command line
clear all; #... Clear variables
close all; #... Clear figures

bits = [1 0 1 1 0 0 1]; # 0 -> .5+ve to-.5ve; 1 -> .5(-ve)to.5 +ve

#... Modulation
bitrate = 1;
voltage = 5;

sampling_rate = 1000;
sampling_time = 1/sampling_rate;

end_time = length(bits)/bitrate;
time = 0:sampling_time:end_time;

index = 1;

for i = 1:length(time)
    if bits(index) == 1
        modulation(i) = -voltage;
    else
        modulation(i) = voltage;
    endif
    if time(i)*bitrate >= index-(bitrate/2)
        modulation(i) = -modulation(i);
    endif
    if time(i)*bitrate >= index
        index = index+1;
    endif
endfor

plot(time, modulation,'LineWidth',1);
axis([0 end_time -voltage-5 voltage+5]);
line([0 end_time], [0,0]);
grid on;

#... Demodulation
index = 1;

for i = 1:length(modulation)
    if modulation(i) == -voltage && time(i)*bitrate < index-(bitrate/2)
        demodultaion(index) = 1;
    endif
    if modulation(i) == voltage && time(i)*bitrate < index-(bitrate/2)
        demodultaion(index) = 0;
    endif
    if time(i)*bitrate >= index
        index = index+1;
    endif
endfor

disp(demodultaion);
