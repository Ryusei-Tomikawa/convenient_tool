@echo off
setlocal EnableDelayedExpansion

@REM �d�g���x�Ɠd�g�i���̒l���擾����.bat

echo  +-----------------------------------------------+
echo;
echo �d�g���x�Ɠd�g�i���̒l���擾���܂��B
echo;
echo  +-----------------------------------------------+

:loop
echo �d�g���x�Ɠd�g�i���̃f�[�^���i�[����t�H���_���쐬���܂��B
echo �i�[����t�@�C��������͂��Ă��������B
echo ���I������ꍇ��"e" or "Enter" ����͂��Ă��������B
set result_dir=
set /p result_dir=

if %result_dir% == e (
    echo;
    echo +--------------------------------------------+
    echo �v���I�������A����ꂡ�B
    echo +--------------------------------------------+
    echo;
    pause
    exit
) else (
    set current_dir=%~dp0
    md %current_dir%%result_dir%

    echo "�v������" >%current_dir%%result_dir%\README.txt
    echo %date%_%time% >>%current_dir%%result_dir%\README.txt
    ipconfig >>%current_dir%%result_dir%\README.txt

    echo;
    echo �d�g���x�Ɠd�g�i���̌v�����J�n���܂��B
    echo;

    @REM �d�g���x�Ɠd�g�i���̒l���擾����
    @REM 15��v�����A���ϒl�����߂�
    cd C:\tool\L5G\platform-tools
    for /L %%i in (1,1,15) do (
    for /f "usebackq delims=" %%A in (`ver`) do set HOGE=%%A
    adb shell atcli at+bnrinfo >!current_dir!!result_dir!\�d�g���x�Ɠd�g�i���f�[�^_%%i���.txt
    findstr "RSRP" !current_dir!!result_dir!\�d�g���x�Ɠd�g�i���f�[�^_%%i���.txt>>!current_dir!!result_dir!\get_RSRP_SINR.txt
    )

    cd !current_dir!!result_dir!

    echo !CD!

    @REM csv�ɕϊ�
    FOR /f "tokens=1-9" %%a IN (get_RSRP_SINR.txt) DO (
    echo %%a, %%b, %%c, %%d, %%e, %%f, %%g, %%h, %%i>>get_RSRP_SINR.csv
    )

    echo �v���I�����܂����B�f�X�N�g�b�v�ɓd�g���x�Ɠd�g�i���̌v�����ʂ��i�[���ꂽ�t�H���_������܂��B
    echo;

    goto loop
)

pause
exit