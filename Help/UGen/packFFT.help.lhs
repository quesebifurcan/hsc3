    > Sound.SC3.UGen.Help.viewSC3Help "PackFFT"
    > Sound.SC3.UGen.DB.ugenSummary "PackFFT"

> import Sound.SC3 {- hsc3 -}

> g_01 =
>   let b = localBuf 'α' 512 1
>       n = 100
>       square a = a * a
>       r1 z = range 0 1 (fSinOsc KR (expRand (z,'β') 0.1 1) 0)
>       m1 = map r1 (id_seq n 'γ')
>       m2 = zipWith (*) m1 (map square [1.0, 0.99 ..])
>       r2 z = lfPulse KR (2 ** iRand (z,'δ') (-3) 5) 0 0.3
>       i = map r2 (id_seq n 'ε')
>       m3 = zipWith (*) m2 i
>       p = replicate n 0.0
>       c1 = fft' b (fSinOsc AR 440 0)
>       c2 = packFFT c1 512 0 (constant n - 1) 1 (packFFTSpec m3 p)
>       s = ifft' c2
>   in mce2 s s

    > putStrLn $ synthstat_concise g_01
