
# points are sorted accordingly as well 
function get_8_closest!(out_dists, p, points)
    for i = eachindex(points)
        d = norm(points[i] .- p)
        if i == 1
            out_dists[i] = d
        else
            last_i = min(i-1, 8)
            if d < out_dists[last_i]
                for j=1:last_i
                    if d < out_dists[j]
                        for k=min(8, last_i+1):-1:j+1
                            out_dists[k] = out_dists[k-1]
                            points[k], points[k-1] = points[k-1], points[k]
                        end
                        out_dists[j] = d
                        points[i], points[j] = points[j], points[i]
                        break
                    end
                end
            elseif i <= 8
                out_dists[i] = d
            end
        end
    end
    out_dists
end


let index::Vector{pad(Int)} = zeros(pad(Int), NR_CACHES),
    distances::Matrix{Float64} = zeros(8, NR_CACHES)

    global function worley_noise(x; cache_index=1, normalize=true)
        ti = mod(cache_index-1, NR_CACHES) + 1

        points = voronoi_points(x; cache_index=ti)
        normalizers = (1.0, 1/1.5, 1/2, 1/2.5, 1/3)
        dists = @view(distances[1:8, ti])
        get_8_closest!(dists, x, points)
        if normalize
            for i = 1:5
                dists[i] *= normalizers[i]
            end
        end
        @view(distances[1:5, ti])
    end

    global function worley_noise(x, y; cache_index=1, normalize=true)
        ti = mod(cache_index-1, NR_CACHES) + 1

        points = voronoi_points(x, y; cache_index=ti)
        normalizers = (sqrt(0.5), sqrt(0.4), sqrt(4/13), sqrt(50/169), sqrt(0.2), sqrt(0.2), sqrt(0.2), sqrt(16/85))
        dists = @view(distances[1:8, ti])
        get_8_closest!(dists, (x, y), points)
        if normalize
            for i = 1:8
                dists[i] *= normalizers[i]
            end
        end
        dists
    end

    global function worley_noise(x, y, z; cache_index=1, normalize=true)
        ti = mod(cache_index-1, NR_CACHES) + 1

        points = voronoi_points(x, y, z; cache_index=ti)
        normalizers = (sqrt(1/3), sqrt(1/3), sqrt(4/14), sqrt(4/14), sqrt(4/17), sqrt(4/17), sqrt(50/219), sqrt(4/19))
        dists = @view(distances[1:8, ti])
        get_8_closest!(dists, (x, y, z), points)
        if normalize
            for i = 1:8
                dists[i] *= normalizers[i]
            end
        end
        dists
    end

    global function worley_noise(x, y, z, w; cache_index=1, normalize=true)
        ti = mod(cache_index-1, NR_CACHES) + 1

        points = voronoi_points(x, y, z, w; cache_index=ti)
        normalizers = (0.5, 0.5, 0.5, 0.5, sqrt(2/9), sqrt(2/9), sqrt(2/9), sqrt(2/9))
        dists = @view(distances[1:8, ti])
        get_8_closest!(dists, (x, y, z, w), points)
        if normalize
            for i = 1:8
                dists[i] *= normalizers[i]
            end
        end
        dists
    end

end