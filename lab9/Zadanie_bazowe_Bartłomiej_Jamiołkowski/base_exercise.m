data = readtable('Ukraine Explorer Inputs Prod - RefugeesSeries.csv');

% 1. Oblicz przyrosty bezwzględne, względne i logarytmiczne. Oblicz średnią i odchylenie standardowe. Przedstaw wyniki na wykresie (w dowolnej formie).

absolute_increase = diff(data.NoRefugees);
relative_increase = diff(data.NoRefugees) ./ data.NoRefugees(1:end - 1);
log_increase = diff(log(data.NoRefugees));
mean_val = mean(data.NoRefugees);
std_dev = std(data.NoRefugees);

data.RefugeesDate = datetime(data.RefugeesDate);
dates = data.RefugeesDate(2:end);

figure;
subplot(3,1,1);
plot(dates, absolute_increase, 'b');
xlabel('Data');
ylabel('Przyrost bezwzględny');
title('Przyrosty bezwzględne');

subplot(3,1,2);
plot(dates, relative_increase, 'r');
xlabel('Data');
ylabel('Przyrost względny');
title('Przyrosty względne');

subplot(3,1,3);
plot(dates, log_increase, 'g');
xlabel('Data');
ylabel('Przyrost logarytmiczny');
title('Przyrosty logarytmiczne');

figure;
plot(dates, data.NoRefugees(2:end), 'm');
hold on;
plot(dates, mean_val * ones(size(dates)), 'k--');
plot(dates, (mean_val + std_dev) * ones(size(dates)), 'b--');
plot(dates, (mean_val - std_dev) * ones(size(dates)), 'b--');
xlabel('Data');
ylabel('Liczba uchodźców');
title('Liczba uchodźców wraz z średnią i odchyleniem standardowym');
legend('Liczba uchodźców', 'Średnia', 'Odchylenie standardowe');
hold off;

% 2. Dokonaj aproksymacji trendu liniowego. Oblicz błąd aproksymacji.

stopien = 1;
Y = data.NoRefugees;
osX = 1:length(data.NoRefugees);
par = polyfit(osX,Y,stopien);
newY = polyval(par,osX);

approximation_error = norm(data.NoRefugees - newY);

% 3. Wygładź dane z wykorzystaniem metody średniej ruchomej, dla stałych wygładzania k = 5, 10, 15 próbek. Efekt wygładzania przedstaw na wykresie.

smoothed_data_5 = movmean(data.NoRefugees, 5);
smoothed_data_10 = movmean(data.NoRefugees, 10);
smoothed_data_15 = movmean(data.NoRefugees, 15);

figure;
plot(data.NoRefugees, 'DisplayName', 'Dane oryginalne');
hold on;
plot(smoothed_data_5, 'DisplayName', 'Wygładzone (k=5)');
plot(smoothed_data_10, 'DisplayName', 'Wygładzone (k=10)');
plot(smoothed_data_15, 'DisplayName', 'Wygładzone (k=15)');
title('Efekt wygładzania średnią ruchomą');
xlabel('Czas');
ylabel('Wartość');
legend('show');
hold off;

% 4. Dokonaj aproksymacji danych z wykorzystaniem wielomianu stopnia 3. Narysuj rezidua.

par_3 = polyfit(osX, Y, 3);
newY_3 = polyval(par_3, osX);
residuals_poly_3 = data.NoRefugees - newY_3';

figure;
plot(osX, residuals_poly_3, 'b-', 'LineWidth', 1.5);
title('Rezidua');
xlabel('Numer próbki');
ylabel('Rezydua');

% 5. Porównaj i opisz skuteczność metod w p.3 oraz p. 4

