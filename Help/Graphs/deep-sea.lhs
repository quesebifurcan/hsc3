deep sea (jrhb)

> let { rand' = Sound.SC3.UGen.Base.rand
>     ; lfNoise1' = Sound.SC3.UGen.Base.lfNoise1
>     ; lfNoise2' = Sound.SC3.UGen.Base.lfNoise2
>     ; range s l r = let m = (r - l) * 0.5 in mulAdd s m (m + l)
>     ; amp = 1
>     ; pan = 0
>     ; variation = 0.9
>     ; n = rand' (uid 0) 7 46
>     ; dt1 = 25.0 + rand' (uid 1) (-1.7) 1.7
>     ; dt2 = (dt1 + lfNoise2' (uid 0) KR 2) * variation * 0.001
>     ; freq = 901 + rand' (uid 2) 0 65
>     ; t = impulse AR (recip dt2) 0 * 100
>     ; count = pulseCount t 0
>     ; mul = count <* n
>     ; u1 = bpf (mul * t) freq 1 * 0.1
>     ; freq2 = freq * ((count `modE` range (lfNoise1' (uid 0) KR 1) 2 20) + 1)
>     ; u2 = bpf u1 freq2 1 * 0.2 }
> in audition (mrg [ detectSilence u2 0.0001 0.2 RemoveSynth
>                  , out 0 (pan2 u2 pan (amp * 10)) ])

{ var amp = 1
; var pan = 0
; var variation = 0.9
; var n = Rand(7, 46)
; var dt1 = 25.0 + Rand(-1.7, 1.7)
; var dt2 = (dt1 + LFNoise2.kr(2)) * variation * 0.001
; var freq = 901 + Rand(0, 65)
; var t = Impulse.ar(dt2.reciprocal, 0, 100)
; var count = PulseCount.ar(t, 0)
; var mul = count < n
; var u1 = BPF.ar(mul * t, freq, 1) * 0.1
; var freq2 = freq * ((count % LFNoise1.kr(1).range(2, 20)) + 1)
; var u2 = BPF.ar(u1, freq2, 1) * 0.2
; DetectSilence.ar(u2, 0.0001, 0.2, 2)
; Out.ar(0, Pan2.ar(u2, pan, amp * 10)) }.draw