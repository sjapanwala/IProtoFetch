@echo off
chcp 65001>nul
setlocal enabledelayedexpansion
title IProtoFetch │ In The Menu
:: -- color imports --
set "brightred=[91m"
set "brightyellow=[93m"
set "brightgreen=[92m"
set "brightblue=[94m"
set "brightpurple=[95m"
set "brightcyan=[96m"
set "brightwhite=[97m"
set "darkred=[31m"
set "darkyellow=[33m"
set "darkgreen=[32m"
set "[34m=[34m"
set "darkpurple=[35m"
set "darkcyan=[36m"
set "white=[37m"
set "grey=[90m"
set currentfilename=%~n0%~x0
set sessioncode=%random%
FOR /F %%a IN ('curl -s https://ipv4.icanhazip.com/') DO set localip=%%a

if "%1"=="--info" (
    echo.
    echo Prefix Information
    echo [[95m1[97m] - Choice
    echo [[95m![97m] - Alert
    echo [[95m?[97m] - Question/Text Box
    echo [[95m*[97m] - Statement
    echo [[95m+[97m] - Information
    echo [[95mX[97m] - Incorrect / Fail
    echo [[95m✓[97m] - Correct / Success
    echo.
    goto exitprog
)
if "%1"=="--help" (
    echo.
    echo Parameter Help,
    echo "--info"  Shows Information On Prefix Symbols
    echo "--help"  Shows This Help Menu
    echo.
    echo.
    echo Program Help,
    echo Welcome To IProtoFetch, An Internet Protocal Adddress Generator.
    echo Scanning IP Addresses until a successful on is found and relayed to the user.
    echo.
    echo Read More @[1;92m%https://github.com/sjapanwala/IProtoFetch[97m
    echo.
    goto exitprog
)
if "%1"=="--ezplant" (
    move %currentfilename% C:\Users\%username%
)

if not exist C:\Users\%username%\.config\iprotosettings (
    md C:\Users\%username%\.config\iprotosettings
)
if exist C:\Users\%username%\.config\iprotosettings\.init (
    goto main
) else (
    echo %random% > secret.code
    echo settings > 2secs.settings
    echo main > .init
    move ".init" "C:\Users\%username%\.config\iprotosettings"
    move "2secs.settings" "C:\Users\%username%\.config\iprotosettings"
)

:main
set filename=?
set filetype=?
:line
cls
echo.
echo  [96m ___ ____            _        _____    _       _     
echo  [96m│_ _│  _ \ _ __ ___ │ │_ ___ │  ___│__│ │_ ___│ │__  
echo  [94m │ ││ │_) │ '__/ _ \│ __/ _ \│ │_ / _ \ __/ __│ '_ \ 
echo  [34m │ ││  __/│ │ │ (_) │ ││ (_) │  _│  __/ ││ (__│ │ │ │
echo  [35m│___│_│   │_│  \___/ \__\___/│_│  \___│\__\___│_│ │_│[97m                                                 
echo.
echo ******************************************************
echo.
echo [[95m1[97m] Generate IP's
echo [[95m2[97m] Change Output File
echo └─[Current File: %filename%]
echo   └─[[95m2-1[97m] Launch %filename%
echo   └─[[95m2-2[97m] Wipe %filename%
echo [[95m3[97m] Information
echo.
echo [[95m0[97m] Exit Program
set /p choice=└─〉
echo.
if %choice%==1 goto generateip
if %choice%==2 goto outputfile
if %choice%==3 goto settings
if %choice%==2-1 start %filename% && goto line
if %choice%==2-2 goto wipefileconfirm
if %choice%==0 goto exitprog
goto line

:generateip
if %filename%==? (
    echo [[95m![97m] Please Set An Output File
    pause>nul
    goto line
)
title IProtoFetch │ Generating IP's
cls
echo [90mNOTE: Larger Range = Less IP's Detected.
set /p range=[[95m?[97m] Please Set A Range ( [93mGreater Than 0, Less Than 10[97m ): 
if not %range% lss 10 (
    echo [[95m![97m] Out Of Range.
    pause>nul
    goto generateip
)
if not %range% gtr 0 (
    echo [[95m![97m] Out Of Range.
    pause>nul
    goto generateip
)
echo [[95m*[97m] Range Set To [0-%range%)
set /p counter=[[95m?[97m] How Many IP's To Search?: 
if %counter%==0 goto line
if %counter% gtr 40 (
    echo [[95m![97m] Search Rate Is Limited To Less Than 40, Please Purchase Premium For Larger Search Rate
    pause>nul
    goto generateip
)
echo [[95m*[97m] IP's To Search [%counter%]
set /p "addcode=[[95m?[97m]Add Any Params? (leave blank if none):"
echo.
echo [[95m*[97m]Starting Search in 3
timeout 1 >nul
echo [[95m*[97m]Starting Search in 2
timeout 1 >nul
echo [[95m*[97m]Starting Search in 1
echo.
echo STATUS │ IP Address
echo ───────┼────────────────
timeout 1 >nul
set lookcount=0
set successfulip=0
set failedip=0
:startloop
::if exist C:\Users\%username%\.config\iprotosettings\2secs.settings timeout 2 >nul
if %lookcount%==%counter% goto finished
set /a num=%random% %%%range%
set /a num1=%random% %%4
set /a num2=%random% %%4
set /a num3=%random% %%4
set /a num4=%random% %%4
set /a num5=%random% %%4
set /a num6=%random% %%4
set /a num7=%random% %%4
set /a num8=%random% %%4
set /a num9=%random% %%4
set /a num10=%random% %%4
set /a num11=%random% %%4
:: precision algo
if %num%==0 (
    set num=
    if %num1%==0 set num1=
    if %num2%==0 goto startloop
)
if %num3%==0 (
    set num3=
    if %num4%==0 set num4=
    if %num5%==0 goto startloop
)
if %num6%==0 (
    set num6=
    if %num7%==0 set num7=
    if %num8%==0 goto startloop
)
if %num9%==0 (
    set num9=
    if %num10%==0 set num10=
    if %num11%==0 goto startloop
)
set generatedip=%num%%num1%%num2%.%num3%%num4%%num5%.%num6%%num7%%num8%.%num9%%num10%%num11%
set "padded_number=0%lookcount%"
set "padded_number=!padded_number:~-2!"
for /f "tokens=*" %%i in ('curl -s "http://ip-api.com/line/%generatedip%?fields=status"') do set status=%%i
if %status%==fail (
    echo [90m%padded_number% [97m[[1;91mX[97m] │ %generatedip%
    if %filetype%==.txt (
        echo ❌ │ %generatedip%>>%filename%
    )
    set /a failedip+=1
    set /a lookcount+=1
) 
if %status%==success (
    echo [90m%padded_number% [97m[[1;92m✓[97m] │ %generatedip%
    if %filetype%==.txt (
        echo ✅ │ %generatedip% >>%filename%
    )
    if %filetype%==.nrf (
        echo Internet Protocal Address   %generatedip%   Status   Success>>%filename%
    )
    set /a successfulip+=1
    set /a lookcount+=1
)
goto startloop

:finished
title IProtoFetch │ Finished Generating IP's
:: do some math to find averages
set /a probgoodip=%successfulip% / %lookcount%
set /a probbadip=%failedip% / %lookcount%
set /a percentgood=%probgoodip% * 100
set /a percentbad=%probbadip% * 100

echo.
echo ════════Statistics══════
echo [[95m![97m]Search Finished,
echo [[95m*[97m] IP's Searched:   %lookcount%
echo [[95m*[97m] Successful IP's: %successfulip%
echo [[95m*[97m] Failed IP's:     %failedip%
echo ════════════════════════
echo.
echo [[95m✓[97m] Data Successfully Exported to %filename%
echo.
pause>nul
goto line

:outputfile
title IProtoFetch │ Setting An Output File
echo.
echo [[95m+[97m] Current Output File Name: %filename%
echo [[95m+[97m] Current Output File Type: %filetype%
echo.
echo Please Choose A File Type:
echo.
:choosefiletype
echo [[95m1[97m] Text File (.txt)
echo [[95m2[97m] Netwise Readible File (.nrf)
set /p filetypechoice=└─〉 
if %filetypechoice%==1 set filetype=.txt && goto namefile
if %filetypechoice%==2 set filetype=.nrf && goto namefile
if %filetypechoice%==0 goto line
echo.
echo [[95m![97m] Please Choose A Valid Option
echo.
goto choosefiletype

:namefile
echo.
echo [[95m+[97m] Current Output File Name: %filename%
echo [[95m+[97m] Current Output File Type: %filetype%
echo.
echo [[95m*[97m]This file Will Be Saved in (%cd%)
echo.
echo Please Choose A Name For The File:
set filenumber=1
set /p filename=└─〉 
if %filename%==? goto namefile1
set filename=%filename%%filetype%
goto line
:namefile1
if not exist untitledfile_%filenumber%%filetype% (
    set filename=untitledfile_%filenumber%%filetype%
) else (
    set /a filenumber+=1
    goto namefile1
)
goto line

:settings
echo.
echo [[95m*[97m] Version:           2024.01
echo [[95m*[97m] Subscription Type: Free
echo [[95m*[97m] Session Code:      %sessioncode%
echo [[95m*[97m] Personal IP:       %localip%
echo [[95m*[97m] Current File:      %currentfilename%
echo [[95m*[97m] Current Directory: %cd%
echo.
echo [1;92m%https://github.com/sjapanwala/IProtoFetch[97m
echo.
pause>nul
goto line

:wipefileconfirm
echo.
set /p delfileconfim= [[95m?[97m] Are You Sure You Want To Delete %filename%?: 
if %delfileconfim%==Y del %filename% && goto line
if %delfileconfim%==y del %filename% && goto line
if %delfileconfim%==N goto line
if %delfileconfim%==n goto line
goto line


:exitprog

