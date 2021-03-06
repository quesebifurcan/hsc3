    > Sound.SC3.UGen.Help.viewSC3Help "RunningMax"
    > Sound.SC3.UGen.DB.ugenSummary "RunningMax"

> import Sound.SC3 {- hsc3 -}
>
> g_01 =
>     let n = dust 'α' AR 20
>         t = impulse AR 0.4 0
>         f = runningMax n t * 500 + 200
>     in t + sinOsc AR f 0 * 0.2

follow a sine lfo, reset rate controlled by mouse x

> g_02 =
>     let t = impulse KR (mouseX KR 0.01 2 Linear 0.1) 0
>         f = runningMax (sinOsc KR 0.2 0) t * 500 + 200
>     in t + sinOsc AR f 0 * 0.2
