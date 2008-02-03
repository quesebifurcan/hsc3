eggcrate (rd)

> let { cosu = cos . (/ pi) 
>     ; sinu = sin . (/ pi)
>     ; eggcrate u v = cosu u * sinu v
>     ; tChoose t a = do { n <- tiRand 0 (fromIntegral (length a)) t
>                        ; return (select n (mce a)) }
>     ; p = [64, 72, 96, 128, 256, 6400, 7200, 8400, 9600] }
> in do { [x, y] <- replicateM 2 (brownNoise KR)
>       ; t <- dust KR 2.4
>       ; [f0, f1] <- replicateM 2 (tChoose t p)
>       ; let { f = linLin (eggcrate x y) (-1) 1 f0 f1
>             ; a = linLin x (-1) 1 0 0.1 }
>         in audition (out 0 (pan2 (mix (sinOsc AR f 0)) y a)) }