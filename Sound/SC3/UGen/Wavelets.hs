-- | Wavelet unit generators (Nick Collins).
module Sound.SC3.UGen.Wavelets where

import Sound.SC3.UGen.Rate
import Sound.SC3.UGen.UGen

dwt :: UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen
dwt buf i h wnt a wns wlt = mkOsc KR "DWT" [buf,i,h,wnt,a,wns,wlt] 1

idwt :: UGen -> UGen -> UGen -> UGen -> UGen
idwt buf wnt wns wlt = mkOsc AR "IDWT" [buf,wnt,wns,wlt] 1

wt_MagAbove :: UGen -> UGen -> UGen
wt_MagAbove buf thr = mkOsc KR "WT_MagAbove" [buf,thr] 1

wt_FilterScale :: UGen -> UGen -> UGen
wt_FilterScale buf wp = mkOsc KR "WT_FilterScale" [buf,wp] 1

wt_TimeWipe :: UGen -> UGen -> UGen
wt_TimeWipe buf wp = mkOsc KR "WT_TimeWipe" [buf,wp] 1

wt_Mul :: UGen -> UGen -> UGen
wt_Mul ba bb = mkOsc KR "WT_Mul" [ba,bb] 1
