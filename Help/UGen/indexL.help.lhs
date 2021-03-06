    > Sound.SC3.UGen.Help.viewSC3Help "IndexL"
    > Sound.SC3.UGen.DB.ugenSummary "IndexL"

> import Sound.SC3 {- hsc3 -}

Index buffer for frequency values

> g_01 =
>   let b = asLocalBuf 'α' [50,100,200,400,800,1600]
>       ph = 1 -- 0
>       i = range 0 7 (lfSaw KR 0.1 ph)
>   in sinOsc AR (mce2 (indexL b i) (index b i)) 0 * 0.1

> g_02 =
>   let b = asLocalBuf 'α' [200,300,400,500,600,800]
>       x = mouseX KR 0 7 Linear 0.2
>   in sinOsc AR (mce2 (indexL b x) (index b x)) 0 * 0.1
