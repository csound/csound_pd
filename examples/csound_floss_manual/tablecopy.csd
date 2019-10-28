<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 8
nchnls = 1
0dbfs = 1

giBeats ftgen 1, 0, -88200, 2, 0
giFox ftgen 2, 0, 0, 1, "fox.wav", 0, 0, 1

  opcode BufPlay1, a, ikik
	ifn, kspeed, iskip, kvol	xin
kcps	= kspeed / (ftlen(ifn) / sr)
iphs	= iskip / (ftlen(ifn) / sr)
asig	poscil3 		kvol, kcps, ifn, iphs
  	xout		asig
  endop
  
instr 1
itable = p4
aout BufPlay1 itable, 1, 0, .5
out aout
endin

</CsInstruments>
<CsScore>
f 0 3600
</CsScore>
</CsoundSynthesizer>

