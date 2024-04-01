@echo off
chcp 65001>nul
title IProtoFetch │ In The Menu
:: -- color imports --
set "brightred=[40;91m"
set "brightyellow=[40;93m"
set "brightgreen=[40;92m"
set "brightblue=[40;94m"
set "brightpurple=[40;95m"
set "brightcyan=[40;96m"
set "brightwhite=[40;97m"
set "darkred=[40;31m"
set "darkyellow=[40;33m"
set "darkgreen=[40;32m"
set "darkblue=[40;34m"
set "darkpurple=[40;35m"
set "darkcyan=[40;36m"
set "white=[40;37m"
set currentfilename=%~n0%~x0
set sessioncode=%random%
FOR /F %%a IN ('curl -s https://ipv4.icanhazip.com/') DO set localip=%%a

if "%1"=="--info" (
    echo.
    echo Prefix Information
    echo [%brightpurple%1%brightwhite%] - Choice
    echo [%brightpurple%!%brightwhite%] - Alert
    echo [%brightpurple%?%brightwhite%] - Question/Text Box
    echo [%brightpurple%*%brightwhite%] - Statement
    echo [%brightpurple%+%brightwhite%] - Information
    echo [%brightpurple%X%brightwhite%] - Incorrect / Fail
    echo [%brightpurple%✓%brightwhite%] - Correct / Success
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
    echo Read More @%brightgreen%https://github.com/sjapanwala/IProtoFetch%brightwhite%
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
echo  %brightcyan% ___ ____            _        _____    _       _     
echo  %brightcyan%│_ _│  _ \ _ __ ___ │ │_ ___ │  ___│__│ │_ ___│ │__  
echo  %brightblue% │ ││ │_) │ '__/ _ \│ __/ _ \│ │_ / _ \ __/ __│ '_ \ 
echo  %darkblue% │ ││  __/│ │ │ (_) │ ││ (_) │  _│  __/ ││ (__│ │ │ │
echo  %darkpurple%│___│_│   │_│  \___/ \__\___/│_│  \___│\__\___│_│ │_│%brightwhite%
echo.
echo ******************************************************
echo.
echo [%brightpurple%1%brightwhite%] Generate IP's
echo [%brightpurple%2%brightwhite%] Change Output File [Current File: %filename%]
echo [%brightpurple%3%brightwhite%] Information
echo.
echo [%brightpurple%0%brightwhite%] Exit Program
set /p choice=└─〉
if %choice%==1 goto generateip
if %choice%==2 goto outputfile
if %choice%==3 goto settings
if %choice%==0 goto exitprog
goto line

:generateip
if %filename%==? (
    echo [%brightpurple%!%brightwhite%] Please Set An Output File
    pause>nul
    goto line
)
title IProtoFetch │ Generating IP's
cls
set /p counter=[%brightpurple%?%brightwhite%] How Many IP's To Search?: 
if %counter%==0 goto line
if %counter% gtr 40 (
    echo [%brightpurple%!%brightwhite%] Search Rate Is Limited To Less Than 40, Please Purchase Premium For Larger Search Rate
    pause>nul
    goto generateip
)
set /p "addcode=[%brightpurple%?%brightwhite%]Add Any Params? (leave blank if none):"
echo.
echo [%brightpurple%*%brightwhite%]Starting Search in 3
timeout 1 >nul
echo [%brightpurple%*%brightwhite%]Starting Search in 2
timeout 1 >nul
echo [%brightpurple%*%brightwhite%]Starting Search in 1
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
set /a num=%random% %%4
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
if %num%==0 goto startloop
if %num3%==0 goto startloop
if %num6%==0 goto startloop
if %num9%==0 goto startloop
set generatedip=%num%%num1%%num2%.%num3%%num4%%num5%.%num6%%num7%%num8%.%num9%%num10%%num11%
for /f "tokens=*" %%i in ('curl -s "http://ip-api.com/line/%generatedip%?fields=status"') do set status=%%i
if %status%==fail (
    echo [%brightred%X%brightwhite%]    │ %generatedip%
    if %filetype%==.txt (
        echo ❌ │ %generatedip%>>%filename%
    )
    set /a failedip+=1
    set /a lookcount+=1
) 
if %status%==success (
    echo [%brightgreen%✓%brightwhite%]    │ %generatedip%
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
echo ═══════Statistics═══════
echo [%brightpurple%!%brightwhite%]Search Finished,
echo [%brightpurple%*%brightwhite%] IP's Searched:   %lookcount%
echo [%brightpurple%*%brightwhite%] Successful IP's: %successfulip%
echo [%brightpurple%*%brightwhite%] Failed IP's:     %failedip%
echo ════════════════════════
echo.
echo [%brightpurple%✓%brightwhite%] Data Successfully Exported to %filename%
echo.
pause>nul
goto line

:outputfile
title IProtoFetch │ Setting An Output File
echo.
echo [%brightpurple%+%brightwhite%] Current Output File Name: %filename%
echo [%brightpurple%+%brightwhite%] Current Output File Type: %filetype%
echo.
echo Please Choose A File Type:
echo.
:choosefiletype
echo [%brightpurple%1%brightwhite%] Text File (.txt)
echo [%brightpurple%2%brightwhite%] Netwise Readible File (.nrf)
set /p filetypechoice=└─〉 
if %filetypechoice%==1 set filetype=.txt && goto namefile
if %filetypechoice%==2 set filetype=.nrf && goto namefile
if %filetypechoice%==0 goto line
echo.
echo [%brightpurple%!%brightwhite%] Please Choose A Valid Option
echo.
goto choosefiletype

:namefile
echo.
echo [%brightpurple%+%brightwhite%] Current Output File Name: %filename%
echo [%brightpurple%+%brightwhite%] Current Output File Type: %filetype%
echo.
echo [%brightpurple%*%brightwhite%]This file Will Be Saved in (%cd%)
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
echo [%brightpurple%*%brightwhite%] Version:           2024.01
echo [%brightpurple%*%brightwhite%] Subscription Type: Free
echo [%brightpurple%*%brightwhite%] Session Code:      %sessioncode%
echo [%brightpurple%*%brightwhite%] Personal IP:       %localip%
echo [%brightpurple%*%brightwhite%] Current File:      %currentfilename%
echo [%brightpurple%*%brightwhite%] Current Directory: %cd%
echo.
echo %brightgreen%https://github.com/sjapanwala/IProtoFetch%brightwhite%
echo.
pause>nul
goto line

:exitprog

