using ProceduralNoise
using BenchmarkTools

function benchmark()
    println("1D         \tuncached \tcached")
    t1 = @belapsed uncached1D(random_noise)
    t2 = @belapsed cached1D(random_noise)
    println(random_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached1D(value_noise)
    t2 = @belapsed cached1D(value_noise)
    println(value_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached1D(perlin_noise)
    t2 = @belapsed cached1D(perlin_noise)
    println(perlin_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached1D(worley_noise1)
    t2 = @belapsed cached1D(worley_noise1)
    println(worley_noise1, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached1D(worley_noise8)
    t2 = @belapsed cached1D(worley_noise8)
    println(worley_noise8, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")

    println()
    println("2D         \tuncached \tcached")
    t1 = @belapsed uncached2D(random_noise)
    t2 = @belapsed cached2D(random_noise)
    println(random_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached2D(value_noise)
    t2 = @belapsed cached2D(value_noise)
    println(value_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached2D(perlin_noise)
    t2 = @belapsed cached2D(perlin_noise)
    println(perlin_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached2D(worley_noise1)
    t2 = @belapsed cached2D(worley_noise1)
    println(worley_noise1, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached2D(worley_noise8)
    t2 = @belapsed cached2D(worley_noise8)
    println(worley_noise8, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")

    println()
    println("3D         \tuncached \tcached")
    t1 = @belapsed uncached3D(random_noise)
    t2 = @belapsed cached3D(random_noise)
    println(random_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached3D(value_noise)
    t2 = @belapsed cached3D(value_noise)
    println(value_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached3D(perlin_noise)
    t2 = @belapsed cached3D(perlin_noise)
    println(perlin_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached3D(worley_noise1)
    t2 = @belapsed cached3D(worley_noise1)
    println(worley_noise1, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached3D(worley_noise8)
    t2 = @belapsed cached3D(worley_noise8)
    println(worley_noise8, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")

    println()
    println("4D         \tuncached \tcached")
    t1 = @belapsed uncached4D(random_noise)
    t2 = @belapsed cached4D(random_noise)
    println(random_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached4D(value_noise)
    t2 = @belapsed cached4D(value_noise)
    println(value_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached4D(perlin_noise)
    t2 = @belapsed cached4D(perlin_noise)
    println(perlin_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached4D(worley_noise1)
    t2 = @belapsed cached4D(worley_noise1)
    println(worley_noise1, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached4D(worley_noise8)
    t2 = @belapsed cached4D(worley_noise8)
    println(worley_noise8, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")

    println("\n\nGRADIENTS:")
    println("1D         \tuncached \tcached")
    t1 = @belapsed uncached1D_grad(value_noise)
    t2 = @belapsed cached1D_grad(value_noise)
    println(value_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached1D_grad(perlin_noise)
    t2 = @belapsed cached1D_grad(perlin_noise)
    println(perlin_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached1D_grad(worley_noise1)
    t2 = @belapsed cached1D_grad(worley_noise1)
    println(worley_noise1, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached1D_grad(worley_noise8)
    t2 = @belapsed cached1D_grad(worley_noise8)
    println(worley_noise8, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")

    println()
    println("2D         \tuncached \tcached")
    t1 = @belapsed uncached2D_grad(value_noise)
    t2 = @belapsed cached2D_grad(value_noise)
    println(value_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached2D_grad(perlin_noise)
    t2 = @belapsed cached2D_grad(perlin_noise)
    println(perlin_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached2D_grad(worley_noise1)
    t2 = @belapsed cached2D_grad(worley_noise1)
    println(worley_noise1, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached2D_grad(worley_noise8)
    t2 = @belapsed cached2D_grad(worley_noise8)
    println(worley_noise8, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")

    println()
    println("3D         \tuncached \tcached")
    t1 = @belapsed uncached3D_grad(value_noise)
    t2 = @belapsed cached3D_grad(value_noise)
    println(value_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached3D_grad(perlin_noise)
    t2 = @belapsed cached3D_grad(perlin_noise)
    println(perlin_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached3D_grad(worley_noise1)
    t2 = @belapsed cached3D_grad(worley_noise1)
    println(worley_noise1, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached3D_grad(worley_noise8)
    t2 = @belapsed cached3D_grad(worley_noise8)
    println(worley_noise8, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")

    println()
    println("4D         \tuncached \tcached")
    t1 = @belapsed uncached4D_grad(value_noise)
    t2 = @belapsed cached4D_grad(value_noise)
    println(value_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached4D_grad(perlin_noise)
    t2 = @belapsed cached4D_grad(perlin_noise)
    println(perlin_noise, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached4D_grad(worley_noise1)
    t2 = @belapsed cached4D_grad(worley_noise1)
    println(worley_noise1, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")
    t1 = @belapsed uncached4D_grad(worley_noise8)
    t2 = @belapsed cached4D_grad(worley_noise8)
    println(worley_noise8, "\t", "$(round(t1*1e7, digits=2))ns   \t$(round(t2*1e7, digits=2))ns")

end

function cached1D(f::F) where F
    x = f(rand())
    i=2
    while i < 100
        i += 1
        x = f(x * rand())
    end
    x
end

function cached2D(f::F) where F
    x = f(rand(), rand())
    i=2
    while i < 100
        i += 1
        x = f(rand(), x)
    end
    x
end

function cached3D(f::F) where F
    x = f(rand(), rand(), rand())
    i=2
    while i <= 100
        x = f(rand(), x, x)
        i += 1
    end
    x
end

function cached4D(f::F) where F
    x = f(rand(), rand(), rand(), rand())
    i=2
    while i <= 100
        x = f(rand(), x, x, x)
        i += 1
    end
    x
end

function uncached1D(f::F) where F
    x = f(rand())
    i=2
    while i < 100
        i += 1
        x = f(x+i)
    end
    x
end

function uncached2D(f::F) where F
    x = f(rand(), rand())
    i=2
    while i < 100
        i += 1
        x = f(x+i, x)
    end
    x
end

function uncached3D(f::F) where F
    x = f(rand(), rand(), rand())
    i=2
    while i <= 100
        x = f(x+i, x, x)
        i += 1
    end
    x
end

function uncached4D(f::F) where F
    x = f(rand(), rand(), rand(), rand())
    i=2
    while i <= 100
        x = f(x+i, x, x, x)
        i += 1
    end
    x
end

function uncached1D_grad(f::F) where F
    x = f(rand(), gradient=true)
    i=2
    while i < 100
        i += 1
        x = f(x+i, gradient=true)
    end
    x
end

function uncached2D_grad(f::F) where F
    x = f(rand(), rand(), gradient=true)
    i=2
    while i < 100
        i += 1
        x = f(x[1]+i, x[2], gradient=true)
    end
    x
end

function uncached3D_grad(f::F) where F
    x = f(rand(), rand(), rand(), gradient=true)
    i=2
    while i <= 100
        x = f(x[1]+i, x[2], x[3], gradient=true)
        i += 1
    end
    x
end

function uncached4D_grad(f::F) where F
    x = f(rand(), rand(), rand(), rand(), gradient=true)
    i=2
    while i <= 100
        x = f(x[1]+i, x[2], x[3], x[4], gradient=true)
        i += 1
    end
    x
end


function cached1D_grad(f::F) where F
    x = f(rand(), gradient=true)
    i=2
    while i < 100
        i += 1
        x = f(min(abs(x), 1.0)*rand(), gradient=true)
    end
    x
end

function cached2D_grad(f::F) where F
    x = f(rand(), rand(), gradient=true)
    i=2
    while i < 100
        i += 1
        x = f(rand(), min(abs(x[2]), 1.0), gradient=true)
    end
    x
end

function cached3D_grad(f::F) where F
    x = f(rand(), rand(), rand(), gradient=true)
    i=2
    while i <= 100
        x = f(rand(), abs(x[2]), abs(x[3]), gradient=true)
        i += 1
    end
    x
end

function cached4D_grad(f::F) where F
    x = f(rand(), rand(), rand(), rand(), gradient=true)
    i=2
    while i <= 100
        x = f(rand(), abs(x[2]), abs(x[3]), abs(x[4]), gradient=true)
        i += 1
    end
    x
end







benchmark()