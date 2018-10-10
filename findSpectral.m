function [peak_dB, peak_freq] = findSpectral ...
    ( ...
        vector, ...
        FS, ...
        win ...
    )

    ratio = 12;
    
    wvector = vector.*win;
    N = length(wvector);
    weight = sum(win);
    
    spectrum = abs(fft(wvector)/weight);
    logstrum = 20*log10(spectrum);
    offset = logstrum(1);    
   
%     figure
%     w = 0:FS/N:(N-1)*FS/N;
%     plot(w,logstrum)
%     hold on
%     plot(w,medfilt1(logstrum-offset,50)+offset+ratio)
%     xlabel('f [Hz]')
%     legend('spectrum [dB]','medfilt')

end