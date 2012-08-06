-- | Bindings to unit generators not distributed with SuperCollider
--   proper.
module Sound.SC3.UGen.External where

import Sound.SC3.UGen.Rate
import Sound.SC3.UGen.Type
import Sound.SC3.UGen.UGen

-- * DFM1

-- | Variant FM synthesis node.
dfm1 :: UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen
dfm1 i f r g ty nl = mkFilter "DFM1" [i,f,r,g,ty,nl] 1

-- * f0plugins

-- | Emulation of the sound generation hardware of the Atari TIA chip.
atari2600 :: UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen
atari2600 audc0 audc1 audf0 audf1 audv0 audv1 rate = mkOsc AR "Atari2600" [audc0,audc1,audf0,audf1,audv0,audv1,rate] 1

-- | POKEY Chip Sound Simulator
mzPokey :: UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen
mzPokey f1 c1 f2 c2 f3 c3 f4 c4 ctl = mkOsc AR "MZPokey" [f1,c1,f2,c2,f3,c3,f4,c4,ctl] 1

-- * skUG

-- | Phase modulation oscillator matrix.
fm7 :: [[UGen]] -> [[UGen]] -> UGen
fm7 ctl m0d = mkOsc AR "FM7" (concat ctl ++ concat m0d) 6

-- * PitchDetection

-- | Tartini model pitch tracker.
tartini ::  Rate -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen
tartini r input threshold n k overlap smallCutoff = mkOscR [KR] r "Tartini" [input,threshold,n,k,overlap,smallCutoff] 2

-- | Constant Q transform pitch follower.
qitch ::  Rate -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen
qitch r input databufnum ampThreshold algoflag ampbufnum minfreq maxfreq = mkOscR [KR] r "Qitch" [input,databufnum,ampThreshold,algoflag,ampbufnum,minfreq,maxfreq] 2

-- Local Variables:
-- truncate-lines:t
-- End:
