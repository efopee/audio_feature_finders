function [peak_dB, peak_freq] = findSpectral ...
    ( ...
        vector, ...
        FS, ...
        win ...
    )

    ratio = 10;

    K = length(vector);
    N = length(win);
    weight = sum(win);
    M = floor(N/2);
    n = floor(length(vector)/M)-1;
    
    peak_dB = NaN(1,n);
    peak_freq = NaN(1,n);
    
    for i = 0:n-1
        
        wvector = vector(i*M+1:i*M+N).*win;
        spectrum = abs(fft(wvector,K)/weight);

        
        half_spectrum = 2*spectrum(1:floor(K/2));
        df = FS/K;
        
        [peak_mag, peak_index, ~] = ...
            findMaxPeak(half_spectrum, ...
            1, ...
            length(half_spectrum), ...
            ratio ...
            );
        peak_dB(i+1) = 20*log10(peak_mag);
        peak_freq(i+1) = df*(peak_index-1);

    end
end