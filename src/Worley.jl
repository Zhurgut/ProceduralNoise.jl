
function get_8_closest!(out_dists, p, points, norm_p)
    N = min(8, length(points))
    for i=1:N
        out_dists[i] = norm(points[i] .- p, norm_p)
    end

    sort!(@view(out_dists[1:N]))

    for i = N+1:length(points)
        d = norm(points[i] .- p, norm_p)
        if d < out_dists[8]
            for j=1:8
                if d < out_dists[j]
                    for k=8:-1:j+1
                        out_dists[k] = out_dists[k-1]
                    end
                    out_dists[j] = d
                    break
                end
            end
        end
    end
    out_dists
end


let index::Vector{pad(Int)} = zeros(pad(Int), Threads.nthreads()),
    distances::Matrix{Float64} = zeros(8, Threads.nthreads())

    global function worley_noise(x; norm_p=2)
        points = voronoi_points(x)
        for i = 1:5
            distances[i] *= normalizers[i]
        end
        get_8_closest!(@view(distances[1:5, Threads.threadid()]), x, points, norm_p)
    end

    global function worley_noise(x, y; norm_p=2)
        points = voronoi_points(x, y)
        get_8_closest!(@view(distances[1:8, Threads.threadid()]), (x, y), points, norm_p)
    end

    global function worley_noise(x, y, z; norm_p=2)
        points = voronoi_points(x, y, z)
        get_8_closest!(@view(distances[1:8, Threads.threadid()]), (x, y, z), points, norm_p)
    end

    global function worley_noise(x, y, z, w; norm_p=2)
        points = voronoi_points(x, y, z, w)
        get_8_closest!(@view(distances[1:8, Threads.threadid()]), (x, y, z, w), points, norm_p)
    end

end