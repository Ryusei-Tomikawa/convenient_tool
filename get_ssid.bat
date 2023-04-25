@echo off
setlocal EnableDelayedExpansion

rem 現在接続しているWi-FiのSSID取得する.bat

rem 現在接続しているWi-Fiの情報をテキストファイルに書き込む
type nul > wifi.txt
netsh wlan show interface >> wifi.txt

rem SSIDの部分だけ読み込む
set count=0
for /f "skip=8 delims=" %%i in (wifi.txt) do (
    set ssid=%%i
    set /a count+=1
)&if !count!==1 goto :wf
:wf

set current_SSID=%ssid:~29%

// ***** => 取得したSSID名
// ************************ => エラーメッセージ
if %current_SSID% == ***** (
  echo;
  echo *****************************************。
  echo; 
) else (
  echo;
  echo 現在 %current_SSID% に接続しています。
  echo;
) 

pause
exit
