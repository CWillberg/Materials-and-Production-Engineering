using FFTW
using Plots
using DSP

# Number of points 
N = 4000 - 1 
# Sample period
Ts = 1 / (1.1 * N) 
# Start time 
t0 = 0 
tmax = t0 + N * Ts
# time coordinate
t = t0:Ts:tmax

# signal 
signal = sin.(2π * 60 .* t) + sin.(2*pi * 90 .* t) + sin.(2*pi * 1500 .* t)  # sin (2π f t) 

# Fourier Transform of it 
F = fft(signal) |> fftshift
freqs = fftfreq(length(t), 1.0/Ts) |> fftshift


responsetype = Lowpass(0.1)
designmethod = Butterworth(4)
filt_signal = filt(digitalfilter(responsetype, designmethod), signal)

filt_F = fft(filt_signal) |> fftshift

# plots 
time_domain = plot(t, signal, title = "Signal")
freq_domain = plot(freqs, abs.(F), title = "Spectrum", xlim=(0, 2000)) 
filt_time_domain = plot(t, filt_signal, title = "Signal")
filt_freq_domain = plot(freqs, abs.(filt_F), title = "Spectrum", xlim=(0, 2000)) 
plot(time_domain, freq_domain, filt_time_domain, filt_freq_domain, layout = 4)