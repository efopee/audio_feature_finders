[Y, FS]=audioread('a.wav');
audio = Y(20001 : 22205);
win = window(@blackmanharris, length(audio))';
waudio = audio.*win;

N = length(waudio);
w = 0:FS/N:(N-1)*FS/N;

spectrum = abs(fft(waudio)/N);
logstrum = 20*log10(spectrum);
cepstrum = ifft(logstrum);
kepstrum = rceps(waudio);

lift = 30;
liftered = [cepstrum(1:lift)...
            zeros(1, N-2*lift-1)...
            cepstrum(N-lift:end)];
plot(cepstrum)
hold on
plot(kepstrum)
retstrum = -abs(fft(liftered));

figure
plot(logstrum)
hold on
plot(retstrum)
