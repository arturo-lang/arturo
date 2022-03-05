import os, strutils
    
switch("cincludes","extras")
switch("path","src")
switch("hints","off")

if hostOS=="windows":

    switch("gcc.path", staticExec("pkg-config --libs-only-L gmp")
                       .strip()
                       .replace("-L","")
                       .replace("/../lib","")
    )