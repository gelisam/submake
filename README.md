Submake
=======

Submake lets you to write and debug long bash pipelines. It stores intermediate results, using them to automatically skip the part of the pipeline which has not changed since the last run.


Usage
---

A submakefile is similar to a makefile, except that recipes express Bash pipelines instead of Bash scripts.

    mythumbnail.png: myimage.png
      pngtopnm
      pamscale -xyfit 32 32
      pnmtopng

Like make, submake re-evaluates a recipe if its input file has changed. In contrast to make, submake also re-evaluates a pipeline if the pipeline itself has changed.

Submake uses git to store intermediate results, using a non-intrusive mechanism which doesn't create new commits. It won't work unless it is executed from inside a git repository.
