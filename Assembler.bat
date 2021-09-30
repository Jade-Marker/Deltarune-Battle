rgbds\rgbasm -oDeltaruneBattle.obj DeltaruneBattle.asm
if %errorlevel% neq 0 call :exit 1

rgbds\rgbasm -ogbt_player.obj Includes\gbt_player.asm
rgbds\rgbasm -ogbt_player_bank1.obj Includes\gbt_player_bank1.asm
if %errorlevel% neq 0 call :exit 1

rgbds\rgblink -mDeltaruneBattle.map -nDeltaruneBattle.sym -oDeltaruneBattle.gb DeltaruneBattle.obj gbt_player.obj gbt_player_bank1.obj
if %errorlevel% neq 0 call :exit 1
rgbds\rgbfix -p0 -v DeltaruneBattle.gb
if %errorlevel% neq 0 call :exit 1
call :exit 0

:exit
pause
exit