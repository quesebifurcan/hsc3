a + b

> import Sound.SC3

> let o = fSinOsc AR 800 0
> in do { n <- pinkNoise AR
>       ; audition (out 0 ((o + n) * 0.1)) }

DC offset.

> audition (out 0 ((fSinOsc AR 440 0 * 0.1) + 0.5))