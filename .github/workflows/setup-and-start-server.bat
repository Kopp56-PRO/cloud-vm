@echo off
setlocal

:: Define the Python installer URL
set PYTHON_INSTALLER_URL=https://www.python.org/ftp/python/3.9.7/python-3.9.7-amd64.exe
set PYTHON_INSTALLER=python-installer.exe

:: Download Python installer
echo Downloading Python installer...
powershell -Command "Invoke-WebRequest -Uri %PYTHON_INSTALLER_URL% -OutFile %PYTHON_INSTALLER%"

:: Install Python
echo Installing Python...
%PYTHON_INSTALLER% /quiet InstallAllUsers=1 PrependPath=1

:: Verify Python installation
python --version

:: Run ipconfig command
echo Running ipconfig...
ipconfig

:: Start Python HTTP server
echo Starting HTTP server...
cd C:\
python -m http.server 8080

:: Clean up
echo Cleaning up...
del %PYTHON_INSTALLER%
