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

Indeed, requirements of user are growing fast while the original Bourne Shell cannot meet them anymore. 

So developers built a lot of shells that can run in sh-like mode, to more closely emulate that very first sh, though most people tend just to run their shells in the default mode, which provides more power than the minimum sh.

Today, we can find __bash__ in many Unix systems, it is a heavily extended form of the Bourne Shell produced by the Free Software Foundation.

### Multiprocessing

This book, _Bourne Shell Scripting_ also has a little part about the Unix and multiprocessing. Because the tutorial bases in the Unix, and, Unix Operating System is and always has been a multt-user, multi-processing operating system (this in contrast with other operating systems like macOS and Microsoft’s DOS/Windows operating systems), the book puts this part before telling some real commands. 

The multiple tasks feature means two things,

- A child process can _never_ make changes to the operating environment of its parent—it only has access to a copy of that environment;
- If you actually do _want_ to make changes in the environment of your shell (or specifically want to avoid it), you have to know when a command runs as a child process and when it runs within your current shell; you might otherwise pick a variant that has the opposite effect of that which you want.

### Variable Expansion

The reason that using a variable is called substitution is that the shell literally replaces each reference to any variable with its value. The simplest way of using a variable is the way we’ve already seen, prepending the variable name with a `$`. So for instance:

```bash
$ USER=JoeSixpack 
$ echo $USER
```

So, how to use variables? To using variables, we have multiple ways, let's see a simple example. 

Input:

```bash
$ ANIMAL=duck
$ echo One $ANIMAL, two $ANIMALs
```

Output:
```bash
duck, two
```

So what went wrong here? Well, obviously the shell substituted nothing for the `ANIMAL` variable, but why? Because with the extra `s` the shell thought we were asking for the non-existent `ANIMALs` variable. But what gives there? We’ve used variables in the middle of strings before (as in `/home/ANIMAL/logs`). But an `s` is not a `/`: an `s` can be a valid part of a variable name, so the shell cannot tell the difference. In cases where you explicitly have to separate the variable from other text, you can use braces:

```bash
$ ANIMAL=duck
$ echo One $ANIMAL, two ${ANIMAL}s
```

And we can use default values while using variables, something like this:

```bash
${ <nowiki/>varname [:]-default <nowiki/> }
```

An example is,

Input:
```bash
$ THIS_ONE_SET=Hello
$ echo $THIS_ONE_SET ${THIS_ONE_NOT:-World}
```

Output:
```bash
Hello World
```

But is you want to do the default assignment while doing the substitution, you can use a more convenient way,

```bash
${ <nowiki/>varname [:]=default <nowiki/>}
```

Here is an example,

Input:
```bash
$ echo ${NEWVAR:=newval}
newval
$ echo $NEWVAR
newval
```

If you want to substitute with value check, you can use,

```bash
${ <nowiki/>varname [:]?message <nowiki/>}
```

Here is an example,

```bash
$ echo ${SOMEVAR:?has not been set} 
-sh: SOMEVAR: has not been set
$ echo ${SOMEVAR:?}
-sh: SOMEVAR: parameter null or not set
```


