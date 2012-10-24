# fusuma

fusuma has been written in MacRuby, [and who doesn't like Ruby](http://www.youtube.com/watch?v=QkqxQROcTIU)? there are no nibs/xibs, no compiled binaries or anything else you get when you make a regular OSX project with Apple's tools.

#### so shut down XCode, pop open Vim/Emacs/Sublime/TextMate/nano(?) and jump in!

***

### fusuma can

  * keep track of unique windows and applications
  * position and resize any window
  * activate and set focus to any window
  * automatically tile and organize your windows based on the configured layout's rules
  * assign global hot keys for any of the above actions

### fusuma can't

  * remove window decorations from another application

***

### todo

  * clean up and documentation (this is an ongoing todo item)
  * a few more default layouts and more keymaps
  * multi-layout/monitor support
  * observer to notify fusuma when a window opens/closes/changes state
  * fix sizing of fixed-ratio windows like terminals and editors with fixed width fonts like MacVim/Emacs (if this is even possible)
  * finish packaging/configuration (yawn)

***

### wanna help/play?

  * download and install the latest [MacRuby](http://macruby.org/)
  * fork fusuma
  * run './build_app' to build the latest version
  * run 'open fusuma.app' (or double click it)
  * hax (the most important step!)

***

### license

    MIT License

    Copyright (C) 2012 Gino Lucero

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.
