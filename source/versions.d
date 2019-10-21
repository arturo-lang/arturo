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

import external.terminal;

// Constants

enum ART_NAME           = "Arturo";
enum ART_VERSION        = "0.3.9";
enum ART_COPYRIGHT      = "2019";
enum ART_AUTHOR         = "Yanis Zafirópulos";
enum ART_BUILD          = import("build.txt");
enum ART_BUILD_DATE     = import("build_date.txt").strip;

version(X86)        { enum ART_BUILD_BITS = "x86"; }
version(X86_64)     { enum ART_BUILD_BITS = "x86_64"; }

version(OSX)        { enum ART_BUILD_OS = "macOS"; }
version(linux)      { enum ART_BUILD_OS = "Linux"; }
version(Windows)    { enum ART_BUILD_OS = "Windows"; }
version(FreeBSD)    { enum ART_BUILD_OS = "FreeBSD"; }
version(Solaris)    { enum ART_BUILD_OS = "Solaris"; }

version(DigitalMars)    { enum ART_BUILD_COMPILER = "dmd"; }
version(LDC)            { enum ART_BUILD_COMPILER = "ldc"; }

version(GTK)        { enum ART_BUILD_GTK    = "+gtk"; }     else { enum ART_BUILD_GTK = ""; }
version(SQLITE)     { enum ART_BUILD_SQLITE = "+sqlite"; }  else { enum ART_BUILD_SQLITE = ""; }

enum VERSION_TEMPLATE       = import("version_template.txt").replace("\\x1B","\x1B");

enum LOGO_TEMPLATE          = import("logo_template.txt").replace("\\x1B","\x1B");

// Functions

void showVersion() {
    writeln(format(VERSION_TEMPLATE,
        ART_NAME, ART_VERSION, ART_BUILD_DATE, ART_BUILD, ART_BUILD_BITS, 
        ART_BUILD_GTK ~ ART_BUILD_SQLITE, ART_BUILD_COMPILER,
        ART_BUILD_OS));
}

void showLogo(Terminal* t = null) {
    if (t is null)
        writeln(format(LOGO_TEMPLATE,
            ART_NAME, ART_VERSION, ART_BUILD_DATE, ART_BUILD, ART_BUILD_BITS, 
            ART_BUILD_GTK ~ ART_BUILD_SQLITE, ART_BUILD_COMPILER,
            ART_BUILD_OS,
            ART_COPYRIGHT, ART_AUTHOR));
    else
        t.writeln(format(LOGO_TEMPLATE,
            ART_NAME, ART_VERSION, ART_BUILD_DATE, ART_BUILD, ART_BUILD_BITS, 
            ART_BUILD_GTK ~ ART_BUILD_SQLITE, ART_BUILD_COMPILER,
            ART_BUILD_OS,
            ART_COPYRIGHT, ART_AUTHOR));
}
