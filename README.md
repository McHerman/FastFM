# FastFm
## Parallel-processing FM-Symthesizer framework built in Chisel hdl  

#### Do you want FM/PM synthesis but just faster than your plain old MCU, much faster? 100 times faster? 

Then you found the right repo. FastFM is a hardware accelerated FM synthesizer implemented in Chisel HDL, allowing for blistering fast parallel computation of Phase modulated sine waves. The framework is parametraziable thereby allowing for custom scaling of the Synth engine, with variable amounts of voices and operators.

#### How does it work

The voices and operators in the FastFM synthesizer do not rely on actual sine wavetables. High resolution wavetables take up a lot of memory, and without a lot of complicated logic, it would only be possible for one operator to read from the wavetable at once, and then we are back to the same old linear algorithms that you would use in a serial processor. Instead FastFM cheats and uses 2nd degree sine approximations, this allows it to get by with only a sigle multiplier pr voice. This is by no means a perfect aproximation, it does introduce unwanted higher harmonics into the audio-path. But it does allow for decentrialized and easily parallelized computation of phase modulation.


