@echo off
setlocal EnableDelayedExpansion

rem ��ʔ�����\���Z�b�g�A�b�v��.bat

echo +-------------------------------------------------------+
echo;
echo ��ʔ�����\���Z�b�g�A�b�v���J�n���܂��B
echo;
echo +-------------------------------------------------------+

:setup_loop

echo python�̃C���X�g�[�����J�n���܂��B��낵���ł����H�iy/n�j
echo �����łɃC���X�g�[���ς̏ꍇ�́A"h"����͂��Ă��������B

set start=
set /p start= 

if %start% == y (
  rem echo %start%
  echo;
  echo python�̃C���X�g�[�����J�n���܂��B
  echo; 
  call python-3.10.6-amd64

) else if %start% == n (
  echo;
  echo ��ʔ�����\���Z�b�g�A�b�v�𒆎~���܂��B
  pause
  exit

) else if %start% == h (
  echo;
  echo �C���X�g�[���ςȂ̂ŃX�L�b�v���܂��B
  echo;

) else (
  echo y or n or h����͂��Ă��������B
  goto setup_loop
) 

rem ���ݐڑ����Ă���Wi-Fi�̏����e�L�X�g�t�@�C���ɏ�������
type nul > wifi.txt
netsh wlan show interface >> wifi.txt

set count=0
for /f "skip=8 delims=" %%i in (wifi.txt) do (
    set ssid=%%i
    set /a count+=1
)&if !count!==1 goto :wf
:wf

set current_SSID=%ssid:~29%

timeout 2 /nobreak >nul

if %current_SSID% == Yaskawa_Wlan (
  echo;
  echo Yaskawa_Wlan�ɐڑ����Ă��邽�߁A�ʂ�Wi-Fi�i����e�U�����O�Ȃǁj�ɐڑ����Ă��������B
  echo ��Yaskawa_Wlan��Yaskawa_Mobile�ɐڑ����Ă���ꍇ�A���̃X�e�b�v�Ŏ��s���܂��B
�@echo; 
  pause
  exit
) else (
  echo;
  echo ���� %current_SSID% �ɐڑ����Ă��܂��B
  rem �K�v�ȃ��C�u����
  echo ��ʔ�����\���ɕK�v�ȃ��C�u�������C���X�g�[�����܂��B
  timeout 2 /nobreak >nul
  py -m pip install pyautogui pywin32 Pillow opencv-python psutil jpholiday
  echo; 
  py -m pip list
  echo;
) 

echo +-------------------------------------------------------------------------+
echo;
echo �ȉ��̃��C�u�������C���X�g�[�����ꂽ���m�F���Ă��������B
echo pyautogui pywin32 Pillow opencv-python psutil jpholiday
echo;
echo �����C���X�g�[������Ă����ꍇ�A��ʔ�����\���Z�b�g�A�b�v�͏I���ł��B
echo �����l�ł����B
echo ��������肭�����Ȃ������ꍇ�y��܂�
echo;
echo +------------------------------------------------------------------------+

pause
exit