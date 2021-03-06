    Sound.SC3.UGen.Help.viewSC3Help "DemandEnvGen"
    Sound.SC3.UGen.DB.ugenSummary "DemandEnvGen"

> import Sound.SC3 {- hsc3 -}

Frequency ramp, exponential curve.

> g_01 =
>     let l = dseq 'α' dinf (mce2 440 9600)
>         y = mouseY KR 0.01 3 Exponential 0.2
>         s = env_curve_shape EnvExp
>         f = demandEnvGen AR l y s 0 1 1 1 0 1 DoNothing
>     in sinOsc AR f 0 * 0.1

Frequency envelope with random times.

> g_02 =
>     let l = dseq 'α' dinf (mce [204,400,201,502,300,200])
>         t = drand 'β' dinf (mce [1.01,0.2,0.1,2.0])
>         y = mouseY KR 0.01 3 Exponential 0.2
>         s = env_curve_shape EnvCub
>         f = demandEnvGen AR l (t * y) s 0 1 1 1 0 1 DoNothing
>     in sinOsc AR (f * mce2 1 1.01) 0 * 0.1

Frequency modulation

> g_03 =
>     let n = dwhite 'α' dinf 200 1000
>         x = mouseX KR (-0.01) (-4) Linear 0.2
>         y = mouseY KR 1 3000 Exponential 0.2
>         s = env_curve_shape (EnvNum undefined)
>         f = demandEnvGen AR n (sampleDur * y) s x 1 1 1 0 1 DoNothing
>     in sinOsc AR f 0 * 0.1

Short sequence with doneAction, linear

> g_04 =
>     let l = dseq 'α' 1 (mce [1300,500,800,300,400])
>         s = env_curve_shape EnvLin
>         f = demandEnvGen KR l 2 s 0 1 1 1 0 1 RemoveSynth
>     in sinOsc AR (f * mce2 1 1.01) 0 * 0.1

Gate, mouse x on right side of screen toggles gate

> g_05 =
>     let n = roundTo (dwhite 'α' dinf 300 1000) 100
>         x = mouseX KR 0 1 Linear 0.2
>         g = x >** 0.5
>         f = demandEnvGen AR n 0.1 5 0.3 g 1 1 0 1 DoNothing
>     in sinOsc AR (f * mce2 1 1.21) 0 * 0.1

gate
mouse x on right side of screen toggles sample and hold
mouse button does hard reset

> g_06 =
>     let l = dseq 'α' 2 (mce [dseries 'β' 5 400 200,500,800,530,4000,900])
>         x = mouseX KR 0 1 Linear 0.2
>         g = (x >** 0.5) - 0.1
>         b = mouseButton KR 0 1 0.2
>         r = (b >** 0.5) * 2
>         s = env_curve_shape EnvSin
>         f = demandEnvGen KR l 0.1 s 0 g r 1 0 1 DoNothing
>     in sinOsc AR (f * mce2 1 1.001) 0 * 0.1

initialise coordinate buffer
layout is (initial-level,duration,level,..,loop-duration)

    > withSC3 (async (b_alloc_setn1 0 0 [0,0.5,0.1,0.5,1,0.01]))

> g_07 =
>     let b = 0
>         l_i = dseries 'β' dinf 0 2
>         d_i = dseries 'γ' dinf 1 2
>         l = dbufrd 'δ' b l_i Loop
>         d = dbufrd 'ε' b d_i Loop
>         s = env_curve_shape EnvLin
>         e = demandEnvGen KR l d s 0 1 1 1 0 5 RemoveSynth
>         f = midiCPS (60 + (e * 12))
>     in sinOsc AR (f * mce2 1 1.01) 0 * 0.1

change envelope by setting values or indeed reallocating buffer

    > import Sound.OSC {- hosc -}
    > withSC3 (sendMessage (b_set1 0 1 0.1))
    > withSC3 (async (b_alloc_setn1 0 0 [0.5,0.9,0.1,0.1,1,0.01]))

read envelope break-points from buffer, here simply duration/level pairs.
the behavior is odd if the curve is zero (ie. flat segments).

> g_08 =
>     let b = asLocalBuf 'α' [61,1,60,2,72,1,55,5,67,9,67]
>         lvl = dbufrd 'β' b (dseries 'γ' 6 0 2) Loop
>         dur = dbufrd 'δ' b (dseries 'ε' 5 1 2) Loop
>         e = demandEnvGen KR lvl dur 1 0 1 1 1 0 1 RemoveSynth
>     in sinOsc AR (midiCPS e) 0 * 0.1

lfNoise1

> g_09 =
>     let y = mouseY KR 0.5 20 Linear 0.2
>         lvl = dwhite 'β' dinf (-0.1) 0.1
>         dur = sampleDur * y
>     in demandEnvGen AR lvl dur 5 (-4) 1 1 1 0 1 RemoveSynth

lfBrownNoise

> g_10 =
>     let y = mouseY KR 1 100 Exponential 0.2
>         lvl = dbrown 'β' dinf (-0.1) 0.1 0.1
>         dur = sampleDur * y
>     in demandEnvGen AR lvl dur 1 0 1 1 1 0 1 RemoveSynth
