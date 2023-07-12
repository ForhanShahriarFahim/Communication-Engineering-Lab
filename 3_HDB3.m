clc; #... Clear command line
clear all; #... Clear variables
close all; #... Clear figures

bits = [1 1 0 0 0 0 0 0 0 0 0];

#... Modulation
bitrate = 1;
voltage = 5;

sampling_rate = 1000;
sampling_time = 1/sampling_rate;

end_time = length(bits)/bitrate;
time = 0:sampling_time:end_time;

zero = 0; one = 0;
for i = 1:length(bits)
  if bits(i) == 0
    zero = zero+1;
  else
    zero = 0;
    one = one+1;
  endif
  if zero == 4
    bits(i) = -1; #previous signal state is +ve
    zero = 0;
    if rem(one, 2) == 0
      bits(i-3) = 1;
    endif
  endif
endfor

index = 1;
sign = -1;

for i = 1:length(time)
  modulation(i) = bits(index)*sign*voltage;
  if time(i)*bitrate >= index
    if bits(index) == 1
      sign = -sign;
    endif
    index = index+1;
  endif
endfor

plot(time, modulation, "LineWidth",2);
axis([0 end_time -voltage-5 voltage+5]);
line([0 end_time], [0 0]);
grid on;

#... Demodulation
index = 1;

for i = 1:length(modulation)
  demodulation(index) = modulation(i)/voltage;
  if time(i)*bitrate >= index
    index = index+1;
  endif
endfor

last = 0;
for i = 1:length(demodulation)
  if demodulation(i) != 0
    if last != 0 && demodulation(i) == last
      for j = -3:0
        demodulation(i+j) = 0;
      endfor
    endif
    last = demodulation(i);
  endif
endfor

demodulation = abs(demodulation);

disp(demodulation);
