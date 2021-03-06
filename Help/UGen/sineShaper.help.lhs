    Sound.SC3.UGen.Help.viewSC3Help "SineShaper"
    Sound.SC3.UGen.DB.ugenSummary "SineShaper"

> import Sound.SC3 {- hsc3 -}
> import qualified Sound.SC3.UGen.Bindings.DB.External as X {- hsc3 -}

{SineShaper.ar(SinOsc.ar([400, 404], 0, 0.2), MouseX.kr(0, 1))}.play

> g_01 = X.sineShaper (sinOsc AR (mce2 400 404) 0 * 0.2) (mouseX KR 0 1 Linear 0.2)

{SineShaper.ar(SoundIn.ar, MouseX.kr(0, 1))}.play

> g_02 = X.sineShaper (soundIn 0) (mouseX KR 0 1 Linear 0.2)
