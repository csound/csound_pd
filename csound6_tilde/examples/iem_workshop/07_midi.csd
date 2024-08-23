<CsoundSynthesizer>
<CsOptions>
-+rtmidi=null -M0 ;necessary for midi
-m128 ;reduce printout
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 8
nchnls = 2
0dbfs = 1
seed 0 ;always different seed

instr 1

 ;receive pitch and velocity from pd
 iCps cpsmidi 
 iDb veloc -30, 0
 
 ;receive detuning (cent) and create random deviation
 iDetune chnget "detune"
 iDetune random -iDetune, iDetune
 
 ;real frequency with detuning
 iCps *= cent(iDetune)
 
 ;create plucked string sound
 aPluck pluck ampdb(iDb), iCps, iCps, 0, 1
 
 ;envelope for release
 aOut linenr aPluck, 0, .1, .01
 
 ;output
 out aOut, aOut

endin

</CsInstruments>
<CsScore>

</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
