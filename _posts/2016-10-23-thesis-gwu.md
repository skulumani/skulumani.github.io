---
layout: post
title: "GWU Thesis Class"
date: 2016-10-23
tags: [latex]
excerpt: "A template and class file to automatically format a PhD/MS thesis for GWU"
---

Download [here](https://github.com/skulumani/thesis-gwu)

## Description

This is a template and class file for a PhD/MS thesis at the George Washington University School of Engineering and Applied Science.
It is fully compliant with the guidelines set forth by [GWU ETD](http://library.gwu.edu/etd/formatting-content).

Furthermore, it greatly improves upon, and finally provides, an automatic way of formatting a thesis for GWU SEAS.
Rather than relying on complex `tex` code in the document, all of the formatting is handled automatically in `thesis-gwu.cls`.
This includes the format of the title page, frontmatter, table of contents, and the text itself. 

The use of a class file such as this is not necessary but greatly improves and reduces the workload on the student. 
This class file was modified and updated from the great work done by [Derek Dalle](http://www-personal.umich.edu/~dalle/codes/thesis-umich/).

I primarily took his great work and corrected some outdated packages/commands and modified the format to follow GWU standards.

## Usage

You can find a copy of the source code on [Github](https://github.com/skulumani/thesis-gwu). 

The source code includes `thesis-gwu.cls` as well as a sample thesis using the class file, which highlights many of the features. 
It's as simple as placing `thesis-gwu.cls` in your working directory and using

`\documentclass[thesis]{thesis-gwu}` 

at the start of your document.

The sample thesis uses many of the features of the template and is split up into several `.tex` files.
This allows one to split up a long document into much more manageable sub-files through the use of `\include{filename.tex}`.
Furthermore, the use of `\includeonly{filename.tex}` allows for selective compiling of a specific section rather than the entire document. 

If you have a modern editor, you can also use the `%!TEX root = ../thesis-sample.tex` at the start of each included file.
This will allow yout to compile from a subfile automatically rather than having to go into the main document and compile from there. 

There are several useful packages already included and some of their usage is shown in the sample thesis. 

## Contributing

Feel free suggest improvements or corrections that you may find. 
You can add any issues to the [Github repository](https://github.com/skulumani/thesis-gwu/issues).
I'm also more than happy to accept any [pull requests](https://help.github.com/articles/about-pull-requests/) for improvements.

