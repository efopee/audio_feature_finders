function harmonic_freq = findCepstral ...
    ( ...
        vector, ...
        FS, ...
        win ...
    )

    wvector = vector.*win;
    N = length(wvector);
    weight = sum(win);
    
    spectrum = abs(fft(wvector)/weight);
    logstrum = 20*log10(spectrum);
    cepstrum = ifft(logstrum);
    
    stopband = 7;
    transband = 7;
    tukey_falloff = 2*transband/N;
    tukey = window(@tukeywin,N-2*stopband,tukey_falloff)';
    lifter = [zeros(1,stopband) tukey zeros(1,stopband)];

    liftered = cepstrum.*(lifter.^2);
    half_liftered = liftered(1:floor(N/2));
    
    avg = mean(half_liftered(half_liftered>0));
    MPD = 5;
    [~, locs] = findpeaks(  half_liftered, ...
                'minpeakheight', 15*avg, ...
                'minpeakdistance', MPD, ...
                'npeaks', 3);
    
%     figure
%     q = 0:1/FS:(N-1)/FS;
%     plot(q,liftered)
%     hold on
%     plot(q,10*avg*ones(1,length(liftered)))
%     legend('liftered cepstrum')
%     xlabel('quefrency [s]')
    
    harmonic_freq = [FS./locs NaN(1,3-length(locs))]';
    
%     figure
%     w = 0:FS/N:(N-1)*FS/N;
%     plot(w,logstrum)
%     hold on
%     plot(w,lift_spectrum+10)
%     xlabel('f [Hz]')
%     legend('spectrum [dB]','liftered spectrum + 10 dB')

    
end