import Pkg
Pkg.add("GaussianRandomFields")
Pkg.add("Plots")
using Plots
Pkg.add("SpecialFunctions")
using SpecialFunctions
using GaussianRandomFields
using DelimitedFiles

# input

aux = 0.5
cl = 10.0^aux

np = 1025

nKL = 1500
exponential = SquaredExponential(cl) # 0.1 is the length scale λ
cov = CovarianceFunction(1, exponential) # 1 is the number of dimensions.
pts = range(-0.5, stop=0.5, length=np) # 1001 is the number of points

grf = GaussianRandomField(cov, KarhunenLoeve(nKL), pts)
print(rel_error(grf))
print('\n')

n = 10
num_realization =5000
dir = string("cl", aux, "_np", np)

mkpath(dir)
for pid in 1:num_realization
    xi=randn(randdim(grf))
    y = sample(grf; xi )

    #p=plot(grf)
    #y = p[1][1][:y]
    
    # yy = zeros( 1, length(pts))
    # d = zeros( 1, length(pts))

    # for i in 1:length(pts)
    #     tmp = y[i]/sqrt(2.0)
    #     yy[i]=0.5*(1.0+erf(tmp))

    #     # inverse cdf
    #     inv_n = 1.0 /n;
    #     d[i] = 1.0 - (1.0 - yy[i])^inv_n
        
    # end
    # print("----------------------------\n")
    # print("i: ", pid)
    # print("\n")
    # print(yy)
    # print("\n")
    # print(d)
    # print("\n")


    
    
    open(string(dir,"/","initial_values_", pid - 1, ".txt"), "w") do file
        write(file, string(length(y)))
        write(file, "\n")
        for di in 1:length(y)
            writedlm(file, y[di])
            #write(file, "\n")
        end
        close(file)
    end

    open(string(dir,"/","xi_values", pid - 1, ".txt"), "w") do file1
        write(file1, string(length(xi)))
        write(file1, "\n")
        for di in 1:length(xi)
            writedlm(file1, xi[di])
            #write(file, "\n")
        end
        close(file1)
    end
end

