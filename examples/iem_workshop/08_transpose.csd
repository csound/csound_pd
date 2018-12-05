<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 8
nchnls = 2
0dbfs = 1

instr 1

 ;audio input from pd
 aIn inch 1
 
 ;transposition in cent
 kTrans chnget "transpose"
 
 ;perform fft and apply transposition
 fIn pvsanal aIn, 512, 128, 512, 1
 fTransp pvscale fIn, cent(kTrans)
  
 ;ifft and output
 aTransp pvsynth fTransp
 out aTransp, aTransp

endin
schedule(1,0,-1) ;run forever

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
