[Y, FS]=audioread('csivava.wav');
Y = Y(:,1);

blocksize = floor(FS/10);
blocktime = blocksize/FS;
numof_blocks = floor(length(Y)/blocksize);
win = window(@blackmanharris, blocksize);

freqs = zeros(1, numof_blocks);
harms = zeros(1, numof_blocks);
imps = zeros(1, numof_blocks);

for i = 0:numof_blocks-1
    block = Y(1+i*blocksize:(i+1)*blocksize);
    
    tic
    [~, freqs(i+1)] = findSpectral(block, FS, win);
    toc
    tic
    harms(i+1) = findCepstral(block, FS, win);
    toc
    tic
    [imps(i+1), ~] = findTransient(block, FS);
    toc
end

t = 0:blocktime:(numof_blocks-1)*blocktime;
figure
plot(t, freqs, ':d')
hold on
plot(t, harms)
plot(t, imps)