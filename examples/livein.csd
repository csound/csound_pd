<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>
0dbfs = 1
ksmps = 8
nchnls = 2

instr 1
aL	inch	1
aR	inch	2
asinL	oscils	.1, 300, 0
asinR	oscils	.1, 400, 0
	outch	1, aL+asinL
	outch	2, aR+asinR
kout	phasor	.1
	outvalue "testsig", kout
endin

</CsInstruments>
<CsScore>
i 1 0 10000
</CsScore>
</CsoundSynthesizer>

