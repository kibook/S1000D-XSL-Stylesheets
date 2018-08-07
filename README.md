# S1000D XSL Stylesheets

The S1000D XSL stylesheets can be used as part of a publication system to produce
page-oriented (PDF) output from S1000D conformant XML source files.

The sample directory contains a comprehensive README document (marked up with S1000D tags,
of course) that describes how to install, configure and use the stylesheets -- a ready 
formatted copy of that document can be found at:

https://github.com/smartavionics/S1000D-XSL-Stylesheets/raw/master/S1000DXSL-README.pdf

See COPYING for copyright and warranty information.

# s1kd2pdf setup instructions

The s1kd2pdf script is meant to provide a quick way to produce a PDF
using these stylesheets from the command line. To install the script
and stylesheets, run the following:

```
# make install
```

To change where these are installed, specify the `PREFIX` make variable. For example:

```
# make PREFIX=/usr install
```

The default prefix is `/usr/local`.

Instructions for using the script can be found in
[s1kd2pdf.README](s1kd2pdf.README) or the man page for s1kd2pdf(1),
or by running the following:

```
$ s1kd2pdf -h
```
