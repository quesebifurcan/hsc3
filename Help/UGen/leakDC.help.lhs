    > Sound.SC3.UGen.Help.viewSC3Help "LeakDC"
    > Sound.SC3.UGen.DB.ugenSummary "LeakDC"

> import Sound.SC3

> g_01 =
>     let a = lfPulse AR 800 0 0.5 * 0.1 + 0.5
>     in mce [a,leakDC a 0.995]
