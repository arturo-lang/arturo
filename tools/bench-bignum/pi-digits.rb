q = 1; r = 0; t = 1; k = 1; n = 3; l = 3; digits = 0; out = +""
while digits < 4000
    if 4 * q + r - t < n * t
        out << n.to_s; digits += 1
        nr = 10 * (r - n * t)
        n = (10 * (3 * q + r)) / t - 10 * n
        q *= 10; r = nr
    else
        nr = (2 * q + r) * l
        nn = (q * (7 * k) + 2 + r * l) / (t * l)
        q *= k; t *= l; l += 2; k += 1; n = nn; r = nr
    end
end
puts "#{out.size} #{out[0, 20]}"
