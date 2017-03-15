// instantiate a Sound Buffer named 'buffer' and connect it to the digital-analog converter
SndBuf buffer => dac;

// read the audio file into the buffer
me.dir() + "windowBreak.wav" => buffer.read;

//makes sure the buffer restarts if reaches the end of the file
1 => buffer.loop;

//get the number of samples in the buffer, divide by 16 and assign that duration to 'tick'
buffer.samples() / 16 => int s;
s::samp => dur tick;


// play continuously
while(true) {

  // occasionally jump to a different position in the buffer
  if (Std.rand2(1,10) < 4) {
    s * Std.rand2(0,15) => buffer.pos;
  }
  // randomly set the playback rate of the buffer from half to double speed, with weighted probability
  if (Std.rand2(1,10) < 2) {2 => buffer.rate;}
  else if (Std.rand2(1,10) < 1) {1.5 => buffer.rate;}
  else if (Std.rand2(1,10) < 1) {0.75 => buffer.rate;}
  else if (Std.rand2(1,10) < 3) {0.5 => buffer.rate;}
  else {1 => buffer.rate;}

  // run the machine in its current state for one 'tick' then return to line 19
  tick => now;
}
