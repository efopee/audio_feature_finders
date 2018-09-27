function peak_time = findTransients ...
    ( ...
        signal, ...
        FS ...
    )
    threshold_ratio = 2.5;
    
    tukey = window(@tukeywin,length(signal),0.3)';

    thirty_ms = ceil(0.03*FS);
    rmswin = window(@blackmanharris,thirty_ms)';
    rmswin = rmswin/sum(rmswin);
    
    signal = signal.*tukey;
    
    rms = abs(filtfilt(rmswin,1,signal.^2)).^0.5;
    avg = mean(rms);

    MPH = threshold_ratio*avg;
    [peaks, indices] = findpeaks( ...
                        rms, ...
                        'MinPeakHeight',MPH);
    
    if isempty(peaks)
        peak_time = NaN(1);
    else
        peak_time = indices/FS;
    end
    
    t = 0:(1/FS):((length(signal)-1)/FS);
    figure
    hold on
    plot(t,MPH*ones(1,length(signal)))
    plot(t,signal,'g')
    findpeaks(rms,FS,'minpeakheight',MPH)
    legend('threshold','signal','RMS')
    xlabel('t [s]')
    
end
