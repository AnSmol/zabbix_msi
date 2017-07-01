@echo off

SET VERSION=3.2.6
SET SUBVERSION=0
set PRODUCTGUID={C1DAD7D4-6385-45BB-A991-583A7989B4A6}
del /f /q zip\*.msi >nul 2>&1
del /f /q zip\zabbix_agent-*_msi-source.zip >nul 2>&1
if .%SUBVERSION%. NEQ .0. set SUB=.%SUBVERSION%
if .%SUBVERSION%. EQU .0. set SUB=
cd %0%\..
set PROJECTDIR=%cd%
Set PROG=zabbix_agent
set WIX_BIN_PATH="C:\Program Files (x86)\WiX Toolset v3.11\bin"
del /f /q "*.wixobj" >nul 2>&1
del /f /q "*.wixpdb" >nul 2>&1
SET PROCARCH=x86
%WIX_BIN_PATH%\candle.exe "msiscript\%PROG%.wxs" "msiscript\ParameterDlg.wxs" -ext "%PROJECTDIR%\MsiScript\wixextensions\WixSystemToolsExtension.dll" -dProcessorArchitecture=%PROCARCH% -dVersionProduct=%VERSION%.%SUBVERSION% -dProductGuid=%PRODUCTGUID% -ext WixFirewallExtension
%WIX_BIN_PATH%\Light.exe -ext WixUIExtension -ext "%PROJECTDIR%\MsiScript\wixextensions\WixSystemToolsExtension.dll" -out "Zip\%PROG%-%VERSION%%SUB%_%PROCARCH%.msi" "%PROG%.wixobj" "ParameterDlg.wixobj" -ext WixFirewallExtension
del /f /q "*.wixobj" >nul 2>&1
del /f /q "*.wixpdb" >nul 2>&1
SET PROCARCH=x64
%WIX_BIN_PATH%\candle.exe "msiscript\%PROG%.wxs" "msiscript\ParameterDlg.wxs" -ext "%PROJECTDIR%\MsiScript\wixextensions\WixSystemToolsExtension.dll" -dProcessorArchitecture=%PROCARCH% -dVersionProduct=%VERSION%.%SUBVERSION% -dProductGuid=%PRODUCTGUID% -ext WixFirewallExtension
%WIX_BIN_PATH%\Light.exe -ext WixUIExtension -ext "%PROJECTDIR%\MsiScript\wixextensions\WixSystemToolsExtension.dll" -out "Zip\%PROG%-%VERSION%%SUB%_%PROCARCH%.msi" "%PROG%.wixobj" "ParameterDlg.wixobj" -ext WixFirewallExtension
del /f /q "*.wixobj" >nul 2>&1
del /f /q "zip\*.wixpdb" >nul 2>&1
call "%ProgramFiles%\7-zip\7z.exe" a -r -tzip ".\zip\zabbix_agent-%version%%SUB%_msi-source.zip" @msi.list
pause
