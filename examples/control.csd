<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

sr = 44100
nchnls = 2
0dbfs = 1
ksmps = 8

instr 1
kFreq     invalue   "freq"
kAmp      invalue   "amp"
kAmp      port      kAmp, .01
aSin      poscil    kAmp, kFreq
          out       aSin, aSin
endin

</CsInstruments>
<CsScore>
i 1 0 999
</CsScore>
</CsoundSynthesizer>

