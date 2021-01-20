@echo off
color 06
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
:--------------------------------------





:MENU
echo                                 ####################################################
echo                                 #          CONTEXT MENU HANDLER V. 01 (2010)       #
echo                                 #  1: ADD NOTEPAD                                  #
echo                                 #  2: REMOVE NOTEPAD                               #
echo                                 #  3: ADD CUSTOM APPLICATION                       #
echo                                 #  4: REMOVE CUSTOM ENTRY                          #
echo                                 #  X: EXIT                                         #
echo                                 ####################################################
echo(
SET /P M=OPTION										
IF %M%==1 GOTO ADDN									
IF %M%==2 GOTO DELN
IF %M%==3 GOTO CUSTA
IF %M%==4 GOTO CUSTD	
IF %M%==X || x EXIT

:ADDN
REG ADD HKEY_CLASSES_ROOT\Directory\Background\shell\Notepad\command /d ""C:\WINDOWS\system32\notepad.exe""
pause
CLS
GOTO MENU

:DELN
reg delete HKEY_CLASSES_ROOT\Directory\Background\shell\Notepad /f
pause
CLS
GOTO MENU

:CUSTA
set /p name=Enter Entry Name
set /p add=Enter App Add as text (NO SPACES ALLOWED)	 										
REG ADD HKEY_CLASSES_ROOT\Directory\Background\shell\%name%\command /d ""%add%""
pause
CLS
GOTO MENU

:CUSTD
set /p name=Enter CONTEXT MENU ENTRY

reg delete HKEY_CLASSES_ROOT\Directory\Background\shell\%name% /f
pause
CLS
GOTO MENU






