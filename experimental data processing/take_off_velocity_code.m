% Specify the path to the CSV file
csvFilePath = 'Jumping-Data-5Nm-Trail1-5mm-8volts.csv';

% Read the CSV file using csvread (assuming there are only numbers in the file)
data = readmatrix(csvFilePath);

% Extract the first two columns
column1 = data(:, 1);
column2 = data(:, 2);
column1 = ((column1 * 30)/10000);
column2 = column2 / 100;

% Plot the data from the first two columns
figure;
plot(column1, column2, 'o-'); % 'o-' represents markers and lines connecting them
xlabel('Time (seconds)');
ylabel('Distance (meters)');
title('Plot of First Two Columns from CSV');
grid on;

% Let the user click on two points
disp('Click on two points to calculate the slope.');
points = ginput(2);
x_points = points(:, 1);
y_points = points(:, 2);

% Calculate the slope using linear regression (least squares method)
coefficients = polyfit(x_points, y_points, 1);
slope(1,1) = coefficients(1);

fprintf('Slope of the line: %.4f\n', slope);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


