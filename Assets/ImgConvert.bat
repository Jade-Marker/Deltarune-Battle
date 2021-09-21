echo off
cd ..

set asset=%1
set assetPath=%asset:~0, -5%"
set output=%assetPath:~0, -1%.bin"

echo on
rgbds\rgbgfx %asset% -f -o %output%
echo off

pause
exit