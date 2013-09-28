Submake
=======

A submakefile will be similar to a makefile, except that recipes will express bash pipelines instead of bash scripts.

    mythumbnail.png: myimage.png
      pngtopnm
      pamscale -xyfit 32 32
      pnmtopng

Like make, submake will re-evaluate a pipeline if its input file has changed. In contrast to make, submake will also re-evaluate a pipeline if the pipeline itself has changed.

Submake will use git to store intermediate results. Thus, if only part of the pipeline has changed, only part of the pipeline will be re-evaluated.
