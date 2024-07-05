% b) Pojawienia się w szeregu sekwencji (wzorca) o długości 4 próbek, charakteryzującej się dla każdej kolejnej próbki zmianą
% wartości znaku skokowej zmiany (+/+/–/– lub /+/–/+/–).

function filtered_patterns = find_patterns_ex4b(series)
    found_patterns = {};

    for i = 1:length(series) - 4
        base_num = series(i);
        actual_pattern = {};
        for j = i + 1:i + 4
            next_num = series(j);
            if next_num > base_num
                actual_pattern{end+1} = '+';
            elseif next_num < base_num
                actual_pattern{end+1} = '-';
            else
                actual_pattern{end+1} = '0';
            end
            base_num = series(j);
        end
        found_patterns{end+1} = {i, i + 4, actual_pattern};
    end

    filtered_patterns = {};
    for k = 1:length(found_patterns)
        pattern = found_patterns{k};
        if isequal(pattern{3}, {'+', '+', '-', '-'} ) || isequal(pattern{3}, {'+', '-', '+', '-'} )
            filtered_patterns{end+1} = pattern;
        end
    end
end