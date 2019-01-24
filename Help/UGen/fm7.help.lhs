    Sound.SC3.UGen.Help.viewSC3Help "FM7"
    Sound.SC3.UGen.DB.ugenSummary "FM7"

> import Sound.SC3 {- hsc3 -}
> import qualified Sound.SC3.UGen.Bindings.Composite.External as X {- hsc3 -}

two of six...

> gr_01 =
>     let c = [[xLine KR 300 310 4 DoNothing,0,1]
>             ,[xLine KR 300 310 8 DoNothing,0,1]
>             ,[0,0,1]
>             ,[0,0,1]
>             ,[0,0,1]
>             ,[0,0,1] ]
>         m = [[line KR 0 0.001 2 DoNothing,line KR 0.1 0 4 DoNothing,0,0,0,0]
>             ,[line KR 0 6 1 DoNothing,0,0,0,0,0]
>             ,[0,0,0,0,0,0]
>             ,[0,0,0,0,0,0]
>             ,[0,0,0,0,0,0]
>             ,[0,0,0,0,0,0] ]
>         [l,r,_,_,_,_] = mceChannels (X.fm7_mx c m)
>     in mce2 l r * 0.1

An algorithmically generated graph courtesy f0.

> gr_02 =
>     let x = [[[0.0,-1/3,-1.0,0.0]
>              ,[0.75,0.75,0.0,-0.5]
>              ,[-0.5,-0.25,0.25,-0.75]
>              ,[-0.5,1.0,1.0,1.0]
>              ,[0.0,1/6,-0.75,-1.0]
>              ,[0.5,0.5,-0.5,1/3]]
>             ,[[-1/3,0.5,-0.5,-0.5]
>              ,[0.5,0.75,0.25,0.75]
>              ,[-15/18,0.25,-1.0,0.5]
>              ,[1.5,0.25,0.25,-0.25]
>              ,[-2/3,-2/3,-1.0,-0.5]
>              ,[-1.0,0.0,-15/18,-1/3]]
>             ,[[0.25,-0.5,-0.5,-1.0]
>              ,[-0.5,1.0,-1.5,0.0]
>              ,[-1.0,-1.5,-0.5,0.0]
>              ,[0.5,-1.0,7/6,-0.5]
>              ,[15/18,-0.75,-1.5,0.5]
>              ,[0.25,-1.0,0.5,1.0]]
>             ,[[1.0,1/3,0.0,-0.75]
>              ,[-0.25,0.0,0.0,-0.5]
>              ,[-0.5,-0.5,0.0,0.5]
>              ,[1.0,0.75,0.5,0.5]
>              ,[0.0,1.5,-0.5,0.0]
>              ,[1.0,0.0,-0.25,-0.5]]
>             ,[[0.5,-0.25,0.0,1/3]
>              ,[0.25,-0.75,1/3,-1.0]
>              ,[-0.25,-0.5,0.25,-7/6]
>              ,[0.0,0.25,0.5,1/6]
>              ,[-1.0,-0.5,15/18,-0.5]
>              ,[15/18,-0.75,-0.5,0.0]]
>             ,[[0.0,-0.75,-1/6,0.0]
>              ,[1.0,0.5,0.5,0.0]
>              ,[-0.5,0.0,-0.5,0.0]
>              ,[-0.5,-1/6,0.0,0.5]
>              ,[-0.25,1/6,-0.75,0.25]
>              ,[-7/6,-4/3,-1/6,1.5]]]
>         y = [[[0.0,-0.5,1.0,0.0]
>              ,[-0.5,1.0,0.5,-0.5]
>              ,[0.0,1/3,1.0,1.0]]
>             ,[[-0.5,0.5,1.0,1.0]
>              ,[0.0,1/3,0.0,1.5]
>              ,[-0.5,15/18,1.0,0.0]]
>             ,[[0.25,-2/3,0.25,0.0]
>              ,[0.5,-0.5,-0.5,-0.5]
>              ,[0.5,-0.5,-0.75,15/18]]
>             ,[[-0.25,1.0,0.0,1/3]
>              ,[-1.25,-0.25,0.5,0.0]
>              ,[0.0,-1.25,-0.25,-0.5]]
>             ,[[0.75,-0.25,1.5,0.0]
>              ,[0.25,-1.5,0.5,0.5]
>              ,[-0.5,-0.5,-0.5,-0.25]]
>             ,[[0.0,0.5,-0.5,0.25]
>              ,[0.25,0.5,-1/3,0.0]
>              ,[1.0,0.5,-1/6,0.5]]]
>         cs = map (map (\[f,p,m,a] -> sinOsc AR f p * m + a)) x
>         ms = map (map (\[f,w,m,a] -> pulse AR f w * m + a)) y
>         [c1,c2,c3,c4,c5,c6] = mceChannels (X.fm7_mx cs ms)
>         g3 = linLin (lfSaw KR 0.1 0) (-1) 1 0 (dbAmp (-12))
>         g6 = dbAmp (-3)
>     in mce [c1 + c3 * g3 + c5,c2 + c4 + c6 * g6]
