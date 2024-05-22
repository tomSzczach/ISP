## IP Core blocks

### Simple Dual Port RAM
 - name = video_mem
 - width = 1
 - depth = 147456 = 384x384
 - common clock
 - read latency = 1 clock cycle

### DDS Compiler
 - name = sincosgen
 - Configuration Options = Phase Generator and SIN COS LUT
 - Number of Channels = 2 
 - Spurious Free Dynamic Range (dB) = 65
 - System Clock (MHz) = 100
 - Frequency per Channel (Fs)) = 50 MHz
 - Frequency Resolution (Hz) = 1000
 - Noise Shaping = None
 
 - Phase Increment Programmability = Programmable
	(insert bits from LSB)
 - Phase Offset Programmability = None
 - Output Selection = Sine and Cosine
 - Has Phase Out = UNCHECKED
 
 - Control Signals = ACLKEN + ARESETn
 
 - Output Frequencies (1st and 2nd channel) = 0.1953125 (MHz)
