% a) Pojawienia się w szeregu co najmniej 3 kolejnych skokowych wartości, których amplituda jest większa niż 1.5 krotność bieżącej
% średniej szeregu (liczonej w oknie o długości 22 próbek).

function indices = find_spikes(series_data)
    % Calculate differences and moving average
    series_diff = diff(series_data);
    sma_22 = conv(series_data, ones(1,22) / 22, 'valid');

    counter = 0;
    indices = [];

    for i = 1:length(sma_22)
        if series_diff(20 + i) > 1.5 * sma_22(i)
            counter = counter + 1;
        else
            if counter >= 3
                for j = (21 + i - counter):(21 + i - 1)
                    indices = [indices, j];
                end
            end
            counter = 0;
        end
    end
end
    