data = readtable('Ukraine Explorer Inputs Prod - RefugeesSeries.csv');

dates = table2array(data(:, 1));

% 1. Wygeneruj drugi szereg o takiej samej długości, zawierający pseudolosowe dane z rozkładu normalnego.
rng(1);
second_series = randn(size(data.NoRefugees));


plot(dates, second_series, 'b');
xlabel('dates');
ylabel('second_series'); 
hold off;

% 2. Oblicz korelację szeregów.
series_corr = corr(data.NoRefugees, second_series);

% 3. Oblicz podobieństwo szeregów z wykorzystaniem metryki Euklidesowej oraz Minkowskiego.
euclidean_distance = norm(data.NoRefugees - second_series);

m = 5;
minkowski_distance = sum(abs(data.NoRefugees - second_series).^m)^(1/m);

% 4. W szeregach znajdź wzorce:
% a) Pojawienia się w szeregu co najmniej 3 kolejnych skokowych wartości, których amplituda jest większa niż 1.5 krotność bieżącej
% średniej szeregu (liczonej w oknie o długości 22 próbek).

sma_22_second = conv(second_series, ones(1,22) / 22, 'valid');

found_indices = find_spikes(second_series);

plot(dates, second_series, 'b');
hold on;
plot(dates(22:end), sma_22_second, 'g')

for index = found_indices
    scatter(dates(index), second_series(index), 'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red', 'LineWidth', 1.5);
end

xlabel('dates');
ylabel('second_series'); 


sma_22_refugees = conv(data.NoRefugees, ones(1,22) / 22, 'valid');

found_indices_refugees = find_spikes(data.NoRefugees);

plot(dates, data.NoRefugees, 'b');
hold on;
plot(dates(22:end), sma_22_refugees, 'g');

for index = found_indices_refugees
    scatter(dates(index), data.NoRefugees(index), 'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red', 'LineWidth', 1.5);
end

xlabel('Dates');
ylabel('NoRefugees');

% b) Pojawienia się w szeregu sekwencji (wzorca) o długości 4 próbek, charakteryzującej się dla każdej kolejnej próbki zmianą
% wartości znaku skokowej zmiany (+/+/–/– lub /+/–/+/–).

ex4b_patterns_NoRefugees = find_patterns_ex4b(data.NoRefugees);

for i = 1:numel(ex4b_patterns_NoRefugees)
    disp(['Pattern ', num2str(i), ':']); 
    disp(['Start index: ', num2str(ex4b_patterns_NoRefugees{i}{1})]);
    disp(['End index: ', num2str(ex4b_patterns_NoRefugees{i}{2})]);
    disp('Pattern sequence:');
    disp(ex4b_patterns_NoRefugees{i}{3});
end

plot(dates, data.NoRefugees, 'b');
hold on;


for i = 1:numel(ex4b_patterns_NoRefugees)
    start_idx = ex4b_patterns_NoRefugees{i}{1};
    end_idx = ex4b_patterns_NoRefugees{i}{2};
    plot(dates(start_idx), data.NoRefugees(start_idx), 'ro', 'MarkerSize', 10);
    plot(dates(end_idx), data.NoRefugees(end_idx), 'gx', 'MarkerSize', 10);
end

xlabel('dates');
ylabel('Number of Refugees');
title('Patterns in Number of Refugees');
legend('Number of Refugees', 'Start of Pattern', 'End of Pattern', 'Location', 'northwest', 'FontSize', 8);
hold off;


ex4b_patterns_second_series = find_patterns_ex4b(second_series);

for i = 1:numel(ex4b_patterns_second_series)
    disp(['Pattern ', num2str(i), ':']); 
    disp(['Start index: ', num2str(ex4b_patterns_second_series{i}{1})]);
    disp(['End index: ', num2str(ex4b_patterns_second_series{i}{2})]);
    disp('Pattern sequence:');
    disp(ex4b_patterns_second_series{i}{3});
end 

plot(dates, second_series, 'b');
hold on;

for i = 1:numel(ex4b_patterns_second_series)
    start_idx = ex4b_patterns_second_series{i}{1};
    end_idx = ex4b_patterns_second_series{i}{2};
    plot(dates(start_idx), second_series(start_idx), 'ro', 'MarkerSize', 10);
    plot(dates(end_idx), second_series(end_idx), 'gx', 'MarkerSize', 10);
end

xlabel('dates');
ylabel('second_series');
title('Patterns in Number of Refugees');
legend('second_series', 'Start of Pattern', 'End of Pattern', 'Location', 'northwest', 'FontSize', 8);
hold off;