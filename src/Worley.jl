

let distances::Matrix{Float64} = zeros(8, NR_CACHES)

    # sort the points so that the N closest points to p are sorted by distance
    # N <= 8
    global function sort_points!(points, p, N, ti)
        dists = @view(distances[1:N, ti])
        dists .= 100.0

        m = argmax(dists)
        for i=eachindex(points)
            d = norm(p .- points[i])
            if d < dists[m]
                dists[m] = d
                points[m], points[i] = points[i], points[m]
                m = argmax(dists)
            end
        end

        # selection sort
        for i=1:N
            m = argmin(@view(dists[i:N]))+i-1
            dists[m], dists[i] = dists[i], dists[m]
            points[m], points[i] = points[i], points[m]
        end
    end

end

let cache::Vector{pad(Float64)} = zeros(pad(Float64), NR_CACHES),
    level::Vector{pad(Int)} = zeros(pad(Int), NR_CACHES)

    function worley_point(x, L, ti)
        points = if cache[ti].value == x && L <= level[ti].value
            voronoi_points(x, cache_index=ti)
        else
            ps = voronoi_points(x, cache_index=ti)
            sort_points!(ps, x, L, ti)
            cache[ti] = Padding(x, cache[ti].padding)
            level[ti] = Padding(L, level[ti].padding)
            ps
        end
        return points[L]
    end

    function worley_noise(x, L, cache_index, normalize, gradient)
        ti = mod(cache_index-1, NR_CACHES) + 1
        max_dists = (1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5)
        min_dists = (0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5) # since up to 3 points per cell

        p = worley_point(Float64(x), L, ti)

        if gradient
            out = sign(x - p)
            if normalize
                out *= 1 / (max_dists[L] - min_dists[L])
            end
            return out
        end

        dist = abs(x - p)
        
        if normalize
            return (dist - min_dists[L]) * (1 / (max_dists[L] - min_dists[L]))
        end

        return dist
    end

    global worley_noise1(x; cache_index=1, normalize=true, gradient=false) = worley_noise(x, 1, cache_index, normalize, gradient)
    global worley_noise2(x; cache_index=1, normalize=true, gradient=false) = worley_noise(x, 2, cache_index, normalize, gradient)
    global worley_noise3(x; cache_index=1, normalize=true, gradient=false) = worley_noise(x, 3, cache_index, normalize, gradient)
    global worley_noise4(x; cache_index=1, normalize=true, gradient=false) = worley_noise(x, 4, cache_index, normalize, gradient)
    global worley_noise5(x; cache_index=1, normalize=true, gradient=false) = worley_noise(x, 5, cache_index, normalize, gradient)
    global worley_noise6(x; cache_index=1, normalize=true, gradient=false) = worley_noise(x, 6, cache_index, normalize, gradient)
    global worley_noise7(x; cache_index=1, normalize=true, gradient=false) = worley_noise(x, 7, cache_index, normalize, gradient)
    global worley_noise8(x; cache_index=1, normalize=true, gradient=false) = worley_noise(x, 8, cache_index, normalize, gradient)


end


let cache::Vector{pad(NTuple{2, Float64})} = zeros(pad(NTuple{2, Float64}), NR_CACHES),
    level::Vector{pad(Int)} = zeros(pad(Int), NR_CACHES)

    function worley_point(x, y, L, ti)
        points = if cache[ti].value == (x, y) && L <= level[ti].value
            voronoi_points(x, y, cache_index=ti)
        else
            ps = voronoi_points(x, y, cache_index=ti)
            sort_points!(ps, (x, y), L, ti)
            cache[ti] = Padding((x, y), cache[ti].padding)
            level[ti] = Padding(L, level[ti].padding)
            ps
        end
        return points[L]
    end

    function worley_noise(x, y, L, cache_index, normalize, gradient)
        ti = mod(cache_index-1, NR_CACHES) + 1
        normalizers = (sqrt(0.5), sqrt(0.4), sqrt(4/13), sqrt(50/169), sqrt(0.2), sqrt(0.2), sqrt(0.2), sqrt(16/85))

        p = worley_point(Float64(x), Float64(y), L, ti)
        dist = norm((x, y) .- p)

        if gradient
            inv_dist = 1 / dist
            dx = (x - p[1]) * inv_dist
            dy = (y - p[2]) * inv_dist
            if normalize
                return normalizers[L] .* (dx, dy)
            end
            return (dx, dy)
        end
        
        if normalize
            return normalizers[L] * dist
        end

        return dist
    end

    global worley_noise1(x, y; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, 1, cache_index, normalize, gradient)
    global worley_noise2(x, y; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, 2, cache_index, normalize, gradient)
    global worley_noise3(x, y; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, 3, cache_index, normalize, gradient)
    global worley_noise4(x, y; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, 4, cache_index, normalize, gradient)
    global worley_noise5(x, y; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, 5, cache_index, normalize, gradient)
    global worley_noise6(x, y; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, 6, cache_index, normalize, gradient)
    global worley_noise7(x, y; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, 7, cache_index, normalize, gradient)
    global worley_noise8(x, y; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, 8, cache_index, normalize, gradient)

end


let cache::Vector{pad(NTuple{3, Float64})} = zeros(pad(NTuple{3, Float64}), NR_CACHES),
    level::Vector{pad(Int)} = zeros(pad(Int), NR_CACHES)

    function worley_point(x, y, z, L, ti)
        points = if cache[ti].value == (x, y, z) && L <= level[ti].value
            voronoi_points(x, y, z, cache_index=ti)
        else
            ps = voronoi_points(x, y, z, cache_index=ti)
            sort_points!(ps, (x, y, z), L, ti)
            cache[ti] = Padding((x, y, z), cache[ti].padding)
            level[ti] = Padding(L, level[ti].padding)
            ps
        end
        return points[L]
    end

    function worley_noise(x, y, z, L, cache_index, normalize, gradient)
        ti = mod(cache_index-1, NR_CACHES) + 1
        normalizers = (sqrt(1/3), sqrt(1/3), sqrt(4/14), sqrt(4/14), sqrt(4/17), sqrt(4/17), sqrt(50/219), sqrt(4/19))

        p = worley_point(Float64(x), Float64(y), Float64(z), L, ti)
        dist = norm((x, y, z) .- p)

        if gradient
            inv_dist = 1 / dist
            dx = (x - p[1]) * inv_dist
            dy = (y - p[2]) * inv_dist
            dz = (z - p[3]) * inv_dist
            if normalize
                return normalizers[L] .* (dx, dy, dz)
            end
            return (dx, dy, dz)
        end
        
        if normalize
            return normalizers[L] * dist
        end

        return dist
    end

    global worley_noise1(x, y, z; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, 1, cache_index, normalize, gradient)
    global worley_noise2(x, y, z; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, 2, cache_index, normalize, gradient)
    global worley_noise3(x, y, z; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, 3, cache_index, normalize, gradient)
    global worley_noise4(x, y, z; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, 4, cache_index, normalize, gradient)
    global worley_noise5(x, y, z; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, 5, cache_index, normalize, gradient)
    global worley_noise6(x, y, z; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, 6, cache_index, normalize, gradient)
    global worley_noise7(x, y, z; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, 7, cache_index, normalize, gradient)
    global worley_noise8(x, y, z; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, 8, cache_index, normalize, gradient)

end



let cache::Vector{pad(NTuple{4, Float64})} = zeros(pad(NTuple{4, Float64}), NR_CACHES),
    level::Vector{pad(Int)} = zeros(pad(Int), NR_CACHES)

    function worley_point(x, y, z, w, L, ti)
        points = if cache[ti].value == (x, y, z, w) && L <= level[ti].value
            voronoi_points(x, y, z, w, cache_index=ti)
        else
            ps = voronoi_points(x, y, z, w, cache_index=ti)
            sort_points!(ps, (x, y, z, w), L, ti)
            cache[ti] = Padding((x, y, z, w), cache[ti].padding)
            level[ti] = Padding(L, level[ti].padding)
            ps
        end
        return points[L]
    end

    function worley_noise(x, y, z, w, L, cache_index, normalize, gradient)
        ti = mod(cache_index-1, NR_CACHES) + 1
        normalizers = (0.5, 0.5, 0.5, 0.5, sqrt(2/9), sqrt(2/9), sqrt(2/9), sqrt(2/9))

        p = worley_point(Float64(x), Float64(y), Float64(z), Float64(w), L, ti)
        dist = norm((x, y, z, w) .- p)

        if gradient
            inv_dist = 1 / dist
            dx = (x - p[1]) * inv_dist
            dy = (y - p[2]) * inv_dist
            dz = (z - p[3]) * inv_dist
            dw = (w - p[4]) * inv_dist
            if normalize
                return normalizers[L] .* (dx, dy, dz, dw)
            end
            return (dx, dy, dz, dw)
        end
        
        if normalize
            return normalizers[L] * dist
        end

        return dist
    end

    global worley_noise1(x, y, z, w; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, w, 1, cache_index, normalize, gradient)
    global worley_noise2(x, y, z, w; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, w, 2, cache_index, normalize, gradient)
    global worley_noise3(x, y, z, w; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, w, 3, cache_index, normalize, gradient)
    global worley_noise4(x, y, z, w; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, w, 4, cache_index, normalize, gradient)
    global worley_noise5(x, y, z, w; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, w, 5, cache_index, normalize, gradient)
    global worley_noise6(x, y, z, w; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, w, 6, cache_index, normalize, gradient)
    global worley_noise7(x, y, z, w; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, w, 7, cache_index, normalize, gradient)
    global worley_noise8(x, y, z, w; cache_index=1, normalize=true, gradient=false) = worley_noise(x, y, z, w, 8, cache_index, normalize, gradient)

end

