# CHIP8 Perf test

This is just a simple CHIP8 interpretter that just runs the test program as fast as possible.
It really is minimal.
The goal is to implement it in roc and a few other languages to compare performance.
I am trying to make the structure and implementations apples to apples where possible.
Clearly roc will be immutable and others will not, but we still map as close as we can.

Hopefully, this gives us a good optimization target for the roc interpretter.

TODO: build out a real platform for roc and get it executing the same as everything else once supported.
