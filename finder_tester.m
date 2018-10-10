warning('off','all');

tic
[Y, FS]=audioread('a.wav');

Y = Y(:,1)';
len = FS/10;

win = window(@blackmanharris, len)';
blocks = floor(length(Y)/length(win));
harmonic_freq = zeros(3,blocks);
impulses = zeros(1,blocks);

for i = 1:blocks
    audio = Y((i-1)*len+1 : i*len);
    harmonic_freq(:,i) = findCepstral(audio,FS,win);
    impulses(i) = findTransients(audio,FS);
    findSpectral(audio,FS,win);
end

toc
figure
hold on
blocksamples = 0:len:(blocks-1)*len;
scatter(blocksamples,harmonic_freq(1,:))
scatter(blocksamples,harmonic_freq(2,:))
scatter(blocksamples,harmonic_freq(3,:))

stem(blocksamples+impulses,500*impulses./impulses)


plot(Y*1000)




