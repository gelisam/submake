Directory testing
===

Unit tests validate that given a particular input value, a function produces the expected output value.

I/O tests validate that given a particular input stream, a program produces the expected output stream.

Directory tests shall validate that given a particular input directory state (files with known contents), a program produces the expected output directory state.

Example
---

Given a directory in which the only file is this README file, the code `echo ok > out` should result in a directory in which this README is untouched, but there is also a file named "out" containing the line "ok".
