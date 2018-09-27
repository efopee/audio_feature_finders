function [pk_values, pk_indices, crests] = findAllPeaks ...
    (...
        vector, ...
        begs, ...
        ends, ...
        threshold_ratio ...
    )

    vector = vector(begs:ends);
    power = vector.*conj(vector);
    avg = mean(power);
    MPH = threshold_ratio^2*avg;
    
    [peaks, indices] = findpeaks(power,'MinPeakHeight',MPH);
    if isempty(peaks)
        pk_values = NaN(1);
        pk_indices = NaN(1);
        crests = NaN(1);
    else
        pk_values = peaks.^0.5;
        pk_indices = indices+begs-1;
        crests = pk_values/(avg^0.5);
    end
end