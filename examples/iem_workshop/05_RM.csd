<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 8
nchnls = 2
0dbfs = 1

instr RM

 ;receive audio from PD
 aIn inch 1
 
 ;receive modulator frequency, panning and volume from PD
 kModFreq chnget "modfreq"
 kPan chnget "pan" ;0..1
 kVolDb chnget "vol_db"
 
 ;smooth volume transitions
 kVolDb port kVolDb, .01
 
 ;perform ring modulation
 aRM poscil aIn, kModFreq
 
 ;volume and panning
 aL, aR pan2 aRM*ampdb(kVolDb), kPan
 
 ;output
 out aL, aR

endin
schedule "RM", 0, 999999

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
