module Sound.SC3.UGen.Noise.Monadic where

import Sound.SC3.UGen.Rate (Rate)
import Sound.SC3.UGen.UGen (UGen, uniquify)
import qualified Sound.SC3.UGen.Noise.Base as N

-- | Brown noise.
brownNoise :: Rate -> IO UGen
brownNoise r = uniquify (N.brownNoise r)

-- | Clip noise.
clipNoise :: Rate -> IO UGen
clipNoise r = uniquify (N.clipNoise r)

-- | Randomly pass or block triggers.
coinGate :: UGen -> UGen -> IO UGen
coinGate prob i = uniquify (N.coinGate prob i)

-- | Random impulses in (-1, 1).
dust2 :: Rate -> UGen -> IO UGen
dust2 r density = uniquify (N.dust2 r density)

-- | Random impulse in (0,1).
dust :: Rate -> UGen -> IO UGen
dust r density = uniquify (N.dust r density)

-- | Random value in exponential distribution.
expRand :: UGen -> UGen -> IO UGen
expRand lo hi = uniquify (N.expRand lo hi)

-- | Gray noise.
grayNoise :: Rate -> IO UGen
grayNoise r = uniquify (N.grayNoise r)

-- | Random integer in uniform distribution.
iRand :: UGen -> UGen -> IO UGen
iRand lo hi = uniquify (N.iRand lo hi)

-- | Clip noise.
lfClipNoise :: Rate -> UGen -> IO UGen
lfClipNoise r freq = uniquify (N.lfClipNoise r freq)

-- | Dynamic clip noise.
lfdClipNoise :: Rate -> UGen -> IO UGen
lfdClipNoise r freq = uniquify (N.lfdClipNoise r freq)

-- | Dynamic step noise.
lfdNoise0 :: Rate -> UGen -> IO UGen
lfdNoise0 r freq = uniquify (N.lfdNoise0 r freq)

-- | Dynamic ramp noise. 
lfdNoise1 :: Rate -> UGen -> IO UGen
lfdNoise1 r freq = uniquify (N.lfdNoise1 r freq)

-- | Dynamic quadratic noise
lfdNoise2 :: Rate -> UGen -> IO UGen
lfdNoise2 r freq = uniquify (N.lfdNoise2 r freq)

-- | Step noise.
lfNoise0 :: Rate -> UGen -> IO UGen
lfNoise0 r freq = uniquify (N.lfNoise0 r freq)

-- | Ramp noise.
lfNoise1 :: Rate -> UGen -> IO UGen
lfNoise1 r freq = uniquify (N.lfNoise1 r freq)

-- | Quadratic noise.
lfNoise2 :: Rate -> UGen -> IO UGen
lfNoise2 r freq = uniquify (N.lfNoise2 r freq)

-- | Random value in skewed linear distribution.
linRand :: UGen -> UGen -> UGen -> IO UGen
linRand lo hi m = uniquify (N.linRand lo hi m)

-- | Random value in sum of n linear distribution.
nRand :: UGen -> UGen -> UGen -> IO UGen
nRand lo hi n = uniquify (N.nRand lo hi n)

-- | Pink noise.
pinkNoise :: Rate -> IO UGen
pinkNoise r = uniquify (N.pinkNoise r)

-- | Random value in uniform distribution.
rand :: UGen -> UGen -> IO UGen
rand lo hi = uniquify (N.rand lo hi)

-- | Random value in exponential distribution on trigger.
tExpRand :: UGen -> UGen -> UGen -> IO UGen
tExpRand lo hi trig = uniquify (N.tExpRand lo hi trig)

-- | Random integer in uniform distribution on trigger.
tiRand :: UGen -> UGen -> UGen -> IO UGen
tiRand lo hi trig = uniquify (N.tiRand lo hi trig)

-- | Random value in uniform distribution on trigger.
tRand :: UGen -> UGen -> UGen -> IO UGen
tRand lo hi trig = uniquify (N.tRand lo hi trig)

-- | White noise.
whiteNoise :: Rate -> IO UGen
whiteNoise r = uniquify (N.whiteNoise r)
