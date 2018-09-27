[Y, FS]=audioread('a.wav');
start = 20000;
len = 4410;
audio = Y(start+1:start+len,1)';
win = window(@blackmanharris, 4410)';
t = 0:1/FS:(length(audio)-1)/FS;
tic

%[dB, freq] = findSpectral(audio, FS, win)
harmonic_freq = findCepstral(audio, FS, win);
imp_time = findTransients(audio, FS);
toc

figure
% sound(audio,FS)

plot(audio)