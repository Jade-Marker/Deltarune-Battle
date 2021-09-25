echo off

AssetRipper

echo %CD%

cd Assets

call ImgConvertHorizontal "%CD%\Kris_Idle0-0.png"
call ImgConvertHorizontal "%CD%\Kris_Idle0-1.png"
call ImgConvertHorizontal "%CD%\Kris_Idle0-2.png"

pause
exit