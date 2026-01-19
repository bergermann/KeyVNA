
using DSP, FFTW


"""
    time_domain(freqs::AbstractVector{<:Real},sdata::AbstractArray{<:Number})

Transform `sdata` into time domain and return time axis and time domain data.
"""
function time_domain(freqs::AbstractVector{<:Real},sdata::AbstractArray{<:Number})
    df = freqs[2]-freqs[1] # df = mean(diff(freqs))

    taxis = fftshift(fftfreq(length(freqs),1/df));
    sdata_ = ifftshift(ifft(sdata))

    return taxis, sdata_
end

"""
    freq_gate(freqs::AbstractVector{<:Real},start::Real,stop::Real; transition_width::Real=0.)

Return a gate mask for `freqs` to be used with time gating. Set gate boundaries `start` and `stop`
in seconds.
"""
function freq_gate(freqs::AbstractVector{<:Real},start::Real,stop::Real; transition_width::Real=0.)
    @assert (stop-start) > transition_width*2 "Window limits are smaller than transition width."

    idx_start = start .< freqs .< start+transition_width
    idx_stop = stop-transition_width .< freqs .< stop
    idx_const = start+transition_width .<= freqs .<= stop-transition_width

    N_start = sum(idx_start); N_end = sum(idx_stop)

    gate_full = zeros(length(freqs))
    gate = hanning(N_start+N_end)
    gate_full[idx_start] .= gate[1:N_start]
    gate_full[idx_const] .= 1.0
    gate_full[idx_stop] .= gate[N_start+1:end]

    return gate_full
end

"""
    time_gate(freqs::AbstractVector{<:Real},sdata::AbstractArray{<:Number},start::Real,stop::Real;
        transition_width::Real=0.)

Return time gated frequency domain data with gate boundaries `start` and `stop` in seconds.
"""
function time_gate(freqs::AbstractVector{<:Real},sdata::AbstractArray{<:Number},start::Real,stop::Real;
        transition_width::Real=0.)

    taxis, sdata_ = time_domain(freqs,sdata)

    gate = freq_gate(taxis,start,stop; transition_width=transition_width)

    sdata__ = fft(fftshift(sdata_.*gate))

    return sdata__
end
