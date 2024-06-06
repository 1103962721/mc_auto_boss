@echo on
rem ���뵱ǰ�ļ���
cd /d %~dp0

@REM �����ǰĿ¼
echo ��ǰĿ¼��%CD%

@REM �жϵ�ǰ�Ƿ��Թ���ԱȨ�����У������������ʾ���˳�
net session >nul 2>nul
if %errorlevel% neq 0 (
    echo ���Թ���ԱȨ�����д˽ű���
    pause
    exit /b 1
)

@REM ��⵱ǰĿ¼·���Ƿ�������ģ������������ʾ���˳�
set "currentDir=%CD%"
set "hasChinese=false"

for %%a in (%currentDir%) do (
    if not "%%~a" == "%%~a" (
        set "hasChinese=true"
        break
    )
)
if "%hasChinese%" == "true" (
    echo ��ǰĿ¼·�����������ַ���
    pause
    exit /b 1
)

@REM �ж� py310 �ļ����Ƿ���� ��������������� https://cloudreve.caiyun.fun/f/x2ux/py310.zip ����ѹ�� py310 �ļ���
if not exist py310\ (
    echo δ�ҵ� Python 3.10 �������������ز���ѹ...
    curl -k -L https://cloudreve.caiyun.fun/f/x2ux/py310.zip -o py310.zip
    @REM     �ж� �Ƿ���� py310 �ļ��У�������������ѹ
    if not exist py310 (
    rem ���� py310 �ļ���
        mkdir py310
    )
    tar  -xf py310.zip -C py310
    (echo python310.zip) > py310/python310._pth
    (echo .) >> py310/python310._pth
    (echo import site) >> py310/python310._pth
    del py310.zip
) else (
    echo Python 3.10 �����Ѵ���
)

@REM �����ʱ�������� python310 Ŀ¼
set PATH=%~dp0\py310;%PATH%
@REM �ж��Ƿ���pip, ���û���� ���� python ִ�� get-pip.py
if not exist py310\Scripts\pip.exe (
    rem ��װpip
    python get-pip.py
)else (
    rem pip�Ѱ�װ
)
@REM �����ʱ�������� python310/Scripts Ŀ¼
set PATH=%~dp0\py310\Scripts;%PATH%
REM ��������Ƿ��Ѿ���װ
@REM ���� requirements.txt ��װ����
for /f "delims=" %%i in (requirements.txt) do (
    REM Check if the package is installed
    pip show %%i >nul 2>nul
    if errorlevel 1 (
        REM If the package is not installed, install it
        echo Installing %%i...
        pip install %%i -i https://pypi.tuna.tsinghua.edu.cn/simple
    ) else (
        echo %%i is already installed.
    )
)
@REM ���г���
python background/main.py
pause
exit
