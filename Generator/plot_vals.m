% cl-2.5_np8193/
% cl-2.5_np16385/
cl = '-0.5';
np = '16385';
np = '1025';
ser = '1';
%fileNameBase = 'cl-2.5_np8193/initial_values_0';
%fileNameBase = 'cl-4.0_np16385/initial_values_0';
%fileNameBase = 'cl-3.0_np16385/initial_values_0';
%fileNameBase = 'cl-2.0_np16385/initial_values_0';
fileNameBase = ['cl', cl, '_np', np, '/initial_values_', ser];
fileNamexi = ['_Y_values/cl', cl, '_np', np, '/xi_values', ser, '.txt'];

fileName = [fileNameBase, '.txt'];
fid = fopen(fileName, 'r');
num = fscanf(fid, '%d', 1);
vals = zeros(num, 1);
for i = 1:num
    vals(i) = fscanf(fid, '%f', 1);
end
[pdf_y, pdf_x] = ksdensity(vals);
figure(1);
plot(pdf_x, pdf_y);
savefig([fileNameBase, '_pdf.fig']);
print('-dpng', [fileNameBase, '_pdf.png']);
x = -.5:1/(length(vals) - 1):0.5;
figure(2);
plot(x, vals);
savefig([fileNameBase, '_x.fig']);
print('-dpng', [fileNameBase, '_x.png']);

figure(3);
plot(x, vals, '-x');
xlim([0,0.01])
xlim([0,0.1])
savefig([fileNameBase, '_xzoom.fig']);
print('-dpng', [fileNameBase, '_xzoom.png']);
xmin = min(vals)
xmax = max(vals)
xmean = mean(vals)
xstd = std(vals)
fns = [fileNameBase, '_stat.txt'];
fido = fopen(fns, 'w');
fprintf(fido, 'xmin\t%f\n', xmin);
fprintf(fido, 'xmax\t%f\n', xmax);
fprintf(fido, 'xmean\t%f\n', xmean);
fprintf(fido, 'xstd\t%f\n', xstd);
fclose(fido);
fclose(fid);

fid = fopen(fileNamexi, 'r');
num = fscanf(fid, '%d', 1);
xis = zeros(num, 1);
for i = 1:num
    xis(i) = fscanf(fid, '%f', 1);
end
figure(4);
plot(1:num, xis);
savefig([fileNameBase, '_xi.fig']);
print('-dpng', [fileNameBase, '_xi.png']);

fclose('all');