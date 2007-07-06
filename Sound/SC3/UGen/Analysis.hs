module Sound.SC3.UGen.Analysis where

import Sound.SC3.UGen.Rate (Rate(KR))
import Sound.SC3.UGen.UGen (UGen)
import Sound.SC3.UGen.UGen.Construct (mkFilter, mkOsc)

-- | Amplitude follower.
amplitude :: Rate -> UGen -> UGen -> UGen -> UGen
amplitude r i at rt = mkOsc r "Amplitude" [i, at, rt] 1

-- | Compressor, expander, limiter, gate, ducker.
compander :: UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen
compander i c t sb sa ct rt = mkFilter "Compander" [i, c, t, sb, sa, ct, rt] 1

-- | Autocorrelation pitch follower.
pitch :: UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen -> UGen
pitch i initFreq minFreq maxFreq execFreq maxBinsPerOctave median ampThreshold peakThreshold downSample = mkOsc KR "Pitch" [i, initFreq, minFreq, maxFreq, execFreq, maxBinsPerOctave, median, ampThreshold, peakThreshold, downSample] 2

-- | Slope of signal.
slope :: UGen -> UGen
slope i = mkFilter "Slope" [i] 1

-- | Zero crossing frequency follower.
zeroCrossing :: UGen -> UGen
zeroCrossing i = mkFilter "ZeroCrossing" [i] 1

-- Local Variables:
-- truncate-lines:t
-- End:
