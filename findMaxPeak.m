function [peak_value, peak_index, crest] = findMaxPeak ...
    (...
        vector, ...
        begs, ...
        ends, ...
        threshold_ratio ...
    )

    power = vector.*conj(vector);
    [peaks, indices] = findpeaks(power(begs:ends));
    [max_pow, max_ind] = max(peaks);

    crest = sqrt(max_pow/mean(power(begs:ends)));
    if crest > threshold_ratio
        peak_value = sqrt(peaks(max_ind));
        peak_index = indices(max_ind)+begs-1;
    else
        peak_value = NaN(1);
        peak_index = NaN(1);
        crest = NaN(1);
    end
end