    Sound.SC3.UGen.Help.viewSC3Help "StkFlute"
    Sound.SC3.UGen.DB.ugenSummary "StkFlute"

> import Sound.SC3 {- hsc3 -}
> import Sound.SC3.UGen.Record.Plain.StkFlute {- hsc3-rec -}

...not working...

> g_01 = mkStkFlute stkFluteR

> g_02 =
>   let u = stkFluteR
>           {freq = 440
>           ,jetDelay = 49
>           ,noisegain = 0.15
>           ,jetRatio = 0.32}
>   in mkStkFlute u

> g_03 =
>   let u = stkFluteR
>           {freq = 440
>           ,jetDelay = 49
>           ,noisegain = line KR 0.05 0.25 3 DoNothing
>           ,jetRatio = line KR 0.10 0.60 3 RemoveSynth}
>   in mkStkFlute u

<https://ccrma.stanford.edu/software/stk/classstk_1_1Flute.html>
