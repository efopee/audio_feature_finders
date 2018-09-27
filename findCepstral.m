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
    
    tukey_falloff = 2*(FS/4000)/N;
    tukey1 = window(@tukeywin,N,tukey_falloff)';
    tukey2 = window(@tukeywin,N,10*tukey_falloff)';

    liftered = cepstrum.*tukey1;
    liftered2 = cepstrum.*tukey2;
%     half_liftered = liftered(1:floor(N/2));
    
    figure
%     subplot(2,1,1)
    q = 0:1/FS:(N-1)/FS;
    plot(q,liftered2)
    hold on
%     plot(q,tukey1)
%     plot(q,tukey2)
    legend('liftered cepstrum')
    xlabel('quefrency [s]')
    
    figure
%     subplot(2,1,2)
    w = 0:FS/N:(N-1)*FS/N;
    plot(w,logstrum)
    hold on
    plot(w,-abs(fft(cepstrum-liftered2))+10)
    xlabel('f [Hz]')
    legend('spectrum [dB]','liftered spectrum + 10 dB')
    
    harmonic_freq = 1;  %dummy

    
end