G-Code Audializer
=================

This is a first-pass at implementing a silly notion.

[MID2CNC](http://tim.cexx.org/?p=633) is a great little project for turning MIDI
audio files into machine instructions for playback on CNC machines, including
[MakerBots](http://www.makerbot.com/).

After thinking about this for some time, it dawned on me that this process
should be able to be reversed - given some G-Code for the machine, we can
simulate the sound that would be produced by the stepper motors.

This is a Processing sketch that actually does it.

Thanks
------

Thanks to [cibomahto](http://www.cibomahto.com/) for the `GCode` class from his
[GCodeDrawer](https://github.com/cibomahto/GCodeDrawer).

Usage
=====

Run the sketch. It will read the `data/penny-opener-cut.gcode` file, which is
just a random file I had handy on my machine. You should hear triphonic
goodness as it simulates building a raft and then a bottle opener. A `.wav`
file will be saved as `g-code.wav`.

Feel free to change the sketch to use your own files!

TODOs
=====

I knocked this out in a couple of hours so there is a long wish list already:

* Use sampled motor noise and pitch-shift it rather than using triangle waves.
* Add filters to make each axis more true to the MakerBot's resonances.
* Add extruder noise when the extruder is on.
* Add optional periodic click-clack of heater relays.
* Add automated build platform motor noise.
* Honor `G92` "you are here" codes for resetting position.
* The timing model is lame and occasionally locks up for a moment. Should
probably be queuing up moves in a better way.
* X/Y/Z component feedrate calculation may be off, some weird high-pitched
sounds are produced unexpectedly that don't match what the bot would do.
* High-speed "dump-to-wav" would be nice so you don't have to listen in
real time. :)
* Simulate motor noise motion in space with parallax :D
