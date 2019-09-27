/*****************************************************************
 * Arturo
 * 
 * Programming Language + Interpreter
 * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: versions.d
 *****************************************************************/

module versions;

// Imports

import std.stdio;
import std.string;

import helpers.terminal;

// Constants

const string ART_NAME           = "Arturo";
const string ART_VERSION        = "0.3.1";
const string ART_COPYRIGHT      = "2019";
const string ART_AUTHOR         = "Yanis Zafirópulos";
const string ART_BUILD          = import("build.txt");
const string ART_BUILD_DATE     = import("build_date.txt").strip;

version(X86)    { const string ART_BUILD_BITS = "x86"; }
version(X86_64) { const string ART_BUILD_BITS = "x86_64"; }

version(OSX)        { const string ART_BUILD_OS = "macOS"; }
version(linux)      { const string ART_BUILD_OS = "Linux"; }
version(Windows)    { const string ART_BUILD_OS = "Windows"; }
version(FreeBSD)    { const string ART_BUILD_OS = "FreeBSD"; }
version(Solaris)    { const string ART_BUILD_OS = "Solaris"; }

const string VERSION_TEMPLATE       = "\x1B[32m\x1B[1m%s %s\x1B[0m (%s build %s) [%s-%s]";

const string LOGO_TEMPLATE          = "\x1B[32m\x1B[1m%s %s\x1B[0m (%s build %s) [%s-%s]
(c) %s %s";

// Functions

void showVersion() {
    writeln(format(VERSION_TEMPLATE,
        ART_NAME, ART_VERSION, ART_BUILD_DATE, ART_BUILD, ART_BUILD_BITS, ART_BUILD_OS));
}

void showLogo(Terminal* t = null) {
    if (t is null)
        writeln(format(LOGO_TEMPLATE,
            ART_NAME, ART_VERSION, ART_BUILD_DATE, ART_BUILD, ART_BUILD_BITS, ART_BUILD_OS,
            ART_COPYRIGHT, ART_AUTHOR));
    else
        t.writeln(format(LOGO_TEMPLATE,
            ART_NAME, ART_VERSION, ART_BUILD_DATE, ART_BUILD, ART_BUILD_BITS, ART_BUILD_OS,
            ART_COPYRIGHT, ART_AUTHOR));
}
