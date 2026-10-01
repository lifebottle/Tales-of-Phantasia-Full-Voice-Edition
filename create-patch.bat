@echo off

call loadenv.bat

xdelta -e -f -S none -B 2073741824 -s top-fve.iso "%OUT_DIR%\top-fve.iso" "%OUT_DIR%\top-fve.xdelta
