@echo off
chcp 65001 >nul
setlocal

REM ============================================
REM  FDE Journey - daily push helper
REM  Double-click to run. Type a one-line summary.
REM ============================================

cd /d "%~dp0"

REM --- check git identity (first-time only) ---
for /f "tokens=*" %%i in ('git config user.name 2^>nul') do set GITNAME=%%i
if "%GITNAME%"=="" (
  echo.
  echo [FIRST TIME SETUP] Git identity is not configured yet.
  echo.
  set /p GITNAME=  Enter your GitHub username: 
  set /p GITMAIL=  Enter your GitHub email: 
  git config user.name "%GITNAME%"
  git config user.email "%GITMAIL%"
  echo Done. Identity saved.
  echo.
)

echo.
echo === FDE Journey - daily push ===
echo.
echo Files changed:
git status --short
echo.

set /p MSG=  Today's summary (e.g. D1: finished audit table v0): 

if "%MSG%"=="" (
  echo No message entered. Aborted.
  pause
  exit /b 1
)

echo.
echo --- git add ---
git add .
if errorlevel 1 (
  echo [ERROR] git add failed.
  pause
  exit /b 1
)

echo --- git commit ---
git commit -m "%MSG%"
if errorlevel 1 (
  echo [ERROR] git commit failed. Maybe nothing changed.
  pause
  exit /b 1
)

echo --- git push ---
git push
if errorlevel 1 (
  echo.
  echo [ERROR] git push failed. Common causes:
  echo   1. Remote not set yet - run:
  echo      git remote add origin https://github.com/USERNAME/fde-journey.git
  echo      git branch -M main
  echo      git push -u origin main
  echo   2. Not logged in - run:  git credential-manager github login
  echo      or open GitHub in browser and approve the device login.
  pause
  exit /b 1
)

echo.
echo === Pushed. See you tomorrow. ===
timeout /t 3 >nul
endlocal
