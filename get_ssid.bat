@echo off
setlocal EnableDelayedExpansion

rem ���ݐڑ����Ă���Wi-Fi��SSID�擾����.bat

rem ���ݐڑ����Ă���Wi-Fi�̏����e�L�X�g�t�@�C���ɏ�������
type nul > wifi.txt
netsh wlan show interface >> wifi.txt

rem SSID�̕��������ǂݍ���
set count=0
for /f "skip=8 delims=" %%i in (wifi.txt) do (
    set ssid=%%i
    set /a count+=1
)&if !count!==1 goto :wf
:wf

set current_SSID=%ssid:~29%

if %current_SSID% == Yaskawa_Wlan (
  echo;
  echo Yaskawa_Wlan�ɐڑ����Ă��邽�߁A�ʂ�Wi-Fi�i����e�U�����O�Ȃǁj�ɐڑ����Ă��������B
  echo; 
) else (
  echo;
  echo ���� %current_SSID% �ɐڑ����Ă��܂��B
  echo;
) 

pause
exit