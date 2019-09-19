---
layout: post
title: "Notes of Bourne Shell Scripting"
categories: study
author: "Yizheng Huang"
---

This is a brief reading note about the _Bourne Shell Scripting_ from [Wikibooks.org](https://en.wikibooks.org).

### What's SH (Bourne Shell)

Right after the Unix was invented, Stephen Bourne set himself to the task and came up with what he called a shell: a small, on-the-fly compiler that could take one command at a time, translate it into the
sequence of bits understood by the machine and have that command carried out. We now call this type of program an interpreter, but at the time, the term "shell" was much more common (since it was a shell over the underlying system for the user).

Stephen’s shell was slim, fast, and though a bit unwieldy at times, its power is still the envy of many current operating system command-line interfaces today. Since it was designed by Stephen Bourne, this shell is called the Bourne Shell. The executable is simply called sh and use of this shell in scripting is still so ubiquitous, there isn’t a Unix-based system on this earth that doesn’t offer a shell whose executable can be reached under the name __sh__.

### Improvements in SH

Indeed, requirements of user are growing fast while the original Bourne Shell cannot meet the them anymore. 

So developers built a lot of shells that can run in sh-like mode, to more closely emulate that very first sh, though most people tend just to run their shells in the default mode, which provides more power than the minimum sh.

Today, we can find __bash__ in many Unix systems, it is a heavily extended form of the Bourne Shell produced by the Free Software Foundation.

### Multiprocessing

This book, _Bourne Shell Scripting_ also has a little part about the Unix and multiprocessing. Since the tutorial bases in the Unix, and, Unix Operating System is and always has been a multt-user, multi-processing operating system (this in contrast with other operating systems like macOS and Microsoft’s DOS/Windows operating systems). 

The multiple tasks feature means two things,

- A child process can _never_ make changes to the operating environment of its parent—it only has access to a copy of that environment;
- If you actually do _want_ to make changes in the environment of your shell (or specifically want to avoid it), you have to know when a command runs as a child process and when it runs within your current shell; you might otherwise pick a variant that has the opposite effect of that which you want.

