
# points are sorted accordingly as well 
function get_8_closest!(out_dists, p, points)
    out_dists[1] = norm(points[1] .- p)

    for i = 2:length(points)
        d = norm(points[i] .- p)
        last_i = min(i-1, 8)
        if d < out_dists[last_i]
            for j=1:last_i
                if d < out_dists[j]
                    for k=min(8, last_i+1):-1:j+1
                        out_dists[k] = out_dists[k-1]
                        points[k], points[k-1] = points[k-1], points[k]
                    end
                    out_dists[j] = d
                    break
                end
            end
        elseif i <= 8
            out_dists[i] = d
        end
    end
    
    out_dists
end


let index::Vector{pad(Int)} = zeros(pad(Int), NR_CACHES),
    distances::Matrix{Float64} = zeros(32, NR_CACHES)

    global function worley_noise(x; cache_index=1, normalize=true, gradient=false)
        ti = mod(cache_index-1, NR_CACHES) + 1

        points = voronoi_points(x; cache_index=ti)
        normalizers = (1.0, 1/1.5, 1/2, 1/2.5, 1/3)
        dists = @view(distances[1:8, ti])
        get_8_closest!(dists, x, points)

        if gradient 
            for i=1:5
                distances[i] = sign(x - points[i])
            end
        end

        if normalize
            for i = 1:5
                distances[i] *= normalizers[i]
            end
        end

        return @view(distances[1:5, ti])
    end

    global function worley_noise(x, y; cache_index=1, normalize=true, gradient=true)
        ti = mod(cache_index-1, NR_CACHES) + 1

        points = voronoi_points(x, y; cache_index=ti)
        normalizers = (sqrt(0.5), sqrt(0.4), sqrt(4/13), sqrt(50/169), sqrt(0.2), sqrt(0.2), sqrt(0.2), sqrt(16/85))
        dists = @view(distances[1:8, ti])
        get_8_closest!(dists, (x, y), points)

        if gradient
            for i=8:-1:1
                inv_dist = 1 / dists[i]
                dxi = 2i-1
                dyi = 2i
                if normalize
                    distances[dxi] = (x - points[i][1]) * inv_dist * normalizers[i]
                    distances[dyi] = (y - points[i][2]) * inv_dist * normalizers[i]
                else
                    distances[dxi] = (x - points[i][1]) * inv_dist
                    distances[dyi] = (y - points[i][2]) * inv_dist
                end
            end
            return @view(distances[1:16, ti])
        elseif normalize
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