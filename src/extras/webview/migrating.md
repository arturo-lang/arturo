## Migration instructions

This is more like a guideline as per what we should do in case we want to pull the latest sources from the parent repo @ webview/webview.

(I honestly don't remember the specifics or the *why* behind this weirdness; all I do remember is that I had totally struggled to get it working a) with errors, b) Windows included and c) without the whole Nim project switching to C++, so... I'm satisfied enough).

### Step-by-step

I'll use `P` for denoting the "Parent" files (@ webview/webview) and `A` for denoting Arturo's version.

----

We go into **P**:`webview.h` and...

- copy-paste all of it into **A**:`webview-windows.h` 
- copy-paste the part starting just after `#define WEBVIEW_H` (without including, before `#ifndef WEBVIEW_API` - which we do include along with any preceding comments) until `#ifndef WEBVIEW_HEADER` (without including it) into **A**:`webview.h`. A trailing `#endif` is missing. That is our header, yay!
- copy-paste everything from `#ifndef WEBVIEW_API` (including it along with any preceding comments) until the very last `#endif /* __cplusplus */` (including it) into **A**:`webview-unix.cc`. We should also remove the `#ifndef WEBVIEW_HEADER` statement and its corresponding `#endif` at the end.

### Also...

Make sure the main function signatures haven't changed (even if you don't make sure, you'll notice because of the compiler errors lol) + if they have and/or there are new functions, add them at our own: `extras/webview.nim`