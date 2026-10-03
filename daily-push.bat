@echo off
setlocal
cd /d "%~dp0"
set GIT=C:\Users\10102\.workbuddy\binaries\PortableGit\versions\1.2.0\mingw64\bin\git.exe

echo ============================================
echo   FDE Journey - Daily Push
echo   Type one line about what you did today.
echo ============================================
echo.

set /p MSG=Today (e.g. D1: finished audit table v0):
if "%MSG%"=="" (
  echo Nothing typed. Aborted.
  pause
  exit /b 1
)

echo.
"%GIT%" add .

"%GIT%" diff --cached --quiet
if errorlevel 1 (
  "%GIT%" commit -m "%MSG%"
  if errorlevel 1 (
    echo [ERROR] Commit failed. Take a screenshot and ask WorkBuddy.
    pause
    exit /b 1
  )
) else (
  echo No new changes to commit. Trying push only.
)

echo Pushing...
"%GIT%" push
if errorlevel 1 (
  echo.
  echo [ERROR] Push failed.
  echo If a browser window asked you to log in, finish it there, then run this file again.
  pause
  exit /b 1
)

echo.
echo ============================================
echo   Pushed. See you tomorrow.
echo ============================================
timeout /t 4 >nul
endlocal
