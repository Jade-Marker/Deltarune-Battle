echo off

AssetRipper

echo %CD%

cd Assets

call ImgConvertHorizontal "%CD%\Kris_Idle0-0.png"
call ImgConvertHorizontal "%CD%\Kris_Idle0-1.png"
call ImgConvertHorizontal "%CD%\Kris_Idle0-2.png"
call ImgConvertHorizontal "%CD%\Kris_Idle1-0.png"
call ImgConvertHorizontal "%CD%\Kris_Idle1-2.png"
call ImgConvertHorizontal "%CD%\Kris_Idle2-0.png"
call ImgConvertHorizontal "%CD%\Kris_Idle2-2.png"
call ImgConvertHorizontal "%CD%\Kris_Idle3-0.png"
call ImgConvertHorizontal "%CD%\Kris_Idle3-2.png"
call ImgConvertHorizontal "%CD%\Kris_Idle4-0.png"
call ImgConvertHorizontal "%CD%\Kris_Idle4-2.png"
call ImgConvertHorizontal "%CD%\Kris_Idle5-0.png"
call ImgConvertHorizontal "%CD%\Kris_Idle5-2.png"


call ImgConvertHorizontal "%CD%\Maus_Idle0-0.png"
call ImgConvertHorizontal "%CD%\Maus_Idle0-1.png"

call ImgConvertHorizontal "%CD%\Susie_Idle0-0.png"
call ImgConvertHorizontal "%CD%\Susie_Idle0-1.png"
call ImgConvertHorizontal "%CD%\Susie_Idle0-2.png"

pause
exit