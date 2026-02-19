# distances from points 

using PShapes


let distances::Matrix{Float64} = Matrix{Float64}(undef, (9, 2*Threads.nthreads()))

    thread_idx() = 2*(Threads.threadid() - 1) + 1

    function get_dists!(idx, pos, x)
        ti = thread_idx()

        r, h = random_from(pos)

        p, h = more_random_from(h)
        distances[idx, ti] = abs((pos + p) - x)
        idx += 1
        
        if r < 0.1
            p, h = more_random_from(h)
            distances[idx, ti] = abs((pos + p) - x)
            idx += 1
        end

        if r < 0.02
            p, h = more_random_from(h)
            distances[idx, ti] = abs((pos + p) - x)
            idx += 1
        end

        return idx

    end

    global function worley_noise(x)
        l, r, d = bounds(x)
        i = get_dists!(1, l-1, x)
        i = get_dists!(i, l, x)
        i = get_dists!(i, r, x)
        dists = @view distances[1:i-1, thread_idx()]
        sort!(dists)
        return @view distances[1:3]
    end

end