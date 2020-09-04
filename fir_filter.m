FL =99; %length of filter from the design

fc_n= 0.05; %compensated normalised cutoff frequency
wc_n=2*fc_n * pi;  %fc_n in radians
i = -(FL-1)/2:(FL-1)/2;%window function 
Hamm_wn= 0.54 + 0.46*cos((i.*pi*2)/FL);%hamming window function
%Hd=zeros(1,FL);
Hd= (2 * fc_n *sin (i.*wc_n))./(i*wc_n);%ideal low pass transfer function
Hd(49)=2 * fc_n;% value for Hd(0);
%now calucalate filter coefficients
fcof = Hd .*Hamm_wn; 
%plotting%

[Hmm, w]=freqz(fcof,1,512);%use matlab inbuilt function to get the frequency respond vector
figure
freqz(fcof,1,512);
title('Hamming Frequency  response');
figure
plot(w/pi,20*log(abs(Hmm)));

figure

plot(fcof);
xlabel('n');
ylabel('h(n)');
v=fir1(FL-1,fc_n * 2);
title('Hamming window-time response');
figure

plot(v);
xlabel('n');
ylabel('h(n)');
title('Matlab time response');

figure

error=(fcof-v).*(fcof-v);
plot(error);
xlabel('n');
ylabel('h(n)');
title('Error signal');