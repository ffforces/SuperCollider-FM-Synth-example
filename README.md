DX7 inspired SuperCollider 6 operator FM synthesis.

It's possible that the single sample feedback system is not implemented right (in the DSP sense), but at least it makes nice noises:)

(it is actually not working as single sample as the blocksize still has an effect on it, but it still makes cool noises. If you want to achieve single sample feedback you can try using the DynUgen's from Dennis Scheiba: https://github.com/capital-G/DynGen)

I was using this recently on my new record 'Permutations' released by Biodiversità Records (https://biodiversitarecords.bandcamp.com/album/permutations).

YouTube video about the code:
https://www.youtube.com/watch?v=SnkOAMBq_Lk

There is of course already the ready-made FM7.ar (https://doc.sccode.org/Classes/FM7.html) but I wanted to do my own version.
