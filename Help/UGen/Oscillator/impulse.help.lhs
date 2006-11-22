impulse freq iPhase

Impulse oscillator.  Outputs non band limited single sample impulses.

freq  - frequency in Hertz
phase - phase offset in cycles (0..1)

> audition $ impulse AR 800 0 * 0.1

> let f = xLine KR 800 10 5 RemoveSynth
> audition $ impulse AR f 0.0 * 0.1

> let f = mouseY KR 4 8 Linear 0.1
> audition $ impulse AR f (MCE [0, mouseX KR 0 1 Linear 0.1]) * 0.1