@echo off
setlocal EnableDelayedExpansion

@REM 電波強度と電波品質の値を取得する.bat

echo  +-----------------------------------------------+
echo;
echo 電波強度と電波品質の値を取得します。
echo;
echo  +-----------------------------------------------+

:loop
echo 電波強度と電波品質のデータを格納するフォルダを作成します。
echo 格納するファイル名を入力してください。
echo ※終了する場合は"e" or "Enter" を入力してください。
set result_dir=
set /p result_dir=

if %result_dir% == e (
    echo;
    echo +--------------------------------------------+
    echo 計測終了するわ、お疲れぃ。
    echo +--------------------------------------------+
    echo;
    pause
    exit
) else (
    set current_dir=%~dp0
    md %current_dir%%result_dir%

    echo "計測日時" >%current_dir%%result_dir%\README.txt
    echo %date%_%time% >>%current_dir%%result_dir%\README.txt
    ipconfig >>%current_dir%%result_dir%\README.txt

    echo;
    echo 電波強度と電波品質の計測を開始します。
    echo;

    @REM 電波強度と電波品質の値を取得する
    @REM 15回計測し、平均値を求める
    cd C:\tool\L5G\platform-tools
    for /L %%i in (1,1,15) do (
    for /f "usebackq delims=" %%A in (`ver`) do set HOGE=%%A
    adb shell atcli at+bnrinfo >!current_dir!!result_dir!\電波強度と電波品質データ_%%i回目.txt
    findstr "RSRP" !current_dir!!result_dir!\電波強度と電波品質データ_%%i回目.txt>>!current_dir!!result_dir!\get_RSRP_SINR.txt
    )

    cd !current_dir!!result_dir!

    echo !CD!

    @REM csvに変換
    FOR /f "tokens=1-9" %%a IN (get_RSRP_SINR.txt) DO (
    echo %%a, %%b, %%c, %%d, %%e, %%f, %%g, %%h, %%i>>get_RSRP_SINR.csv
    )

    echo 計測終了しました。デスクトップに電波強度と電波品質の計測結果が格納されたフォルダがあります。
    echo;

    goto loop
)

pause
exit