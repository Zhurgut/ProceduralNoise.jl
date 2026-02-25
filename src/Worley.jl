
function get_8_closest!(out_dists, p, points)
    N = min(8, length(out_dists))
    for i=1:N
        out_dists[i] = norm(points[i] .- p)
    end

    sort!(out_dists)

    for i = N+1:length(out_dists)
        d = norm(points[i] .- p)
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


let index::Vector{pad(Int)} = zeros(pad(Int), NR_CACHES),
    distances::Matrix{Float64} = zeros(8, NR_CACHES)

    global function worley_noise(x; cache_index=1)
        ti = mod(cache_index-1, NR_CACHES) + 1

        points = voronoi_points(x; cache_index=ti)
        normalizers = (1.0, 1/1.5, 1/2, 1/2.5, 1/3)
        dists = @view(distances[1:5, ti])
        get_8_closest!(dists, x, points)
        for i = 1:5
            dists[i] *= normalizers[i]
        end
        dists
    end

    global function worley_noise(x, y; cache_index=1)
        ti = mod(cache_index-1, NR_CACHES) + 1

        points = voronoi_points(x, y; cache_index=ti)
        normalizers = (sqrt(0.5), sqrt(0.4), sqrt(4/13), sqrt(50/169), sqrt(0.2), sqrt(0.2), sqrt(0.2), sqrt(16/85))
        dists = @view(distances[1:8, ti])
        get_8_closest!(dists, (x, y), points)
        for i = 1:8
            dists[i] *= normalizers[i]
        end
        dists
    end

    global function worley_noise(x, y, z; cache_index=1)
        ti = mod(cache_index-1, NR_CACHES) + 1

        points = voronoi_points(x, y, z; cache_index=ti)
        normalizers = (sqrt(1/3), sqrt(1/3), sqrt(4/14), sqrt(4/14), sqrt(4/17), sqrt(4/17), sqrt(50/219), sqrt(4/19))
        dists = @view(distances[1:8, ti])
        get_8_closest!(dists, (x, y, z), points)
        for i = 1:8
            dists[i] *= normalizers[i]
        end
        dists
    end

    global function worley_noise(x, y, z, w; cache_index=1)
        ti = mod(cache_index-1, NR_CACHES) + 1

        points = voronoi_points(x, y, z, w; cache_index=ti)
        normalizers = (0.5, 0.5, 0.5, 0.5, sqrt(2/9), sqrt(2/9), sqrt(2/9), sqrt(2/9))
        dists = @view(distances[1:8, ti])
        get_8_closest!(dists, (x, y, z, w), points)
        for i = 1:8
            dists[i] *= normalizers[i]
        end
        dists
    end

end