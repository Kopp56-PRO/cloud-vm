@echo off
setlocal

:: Define the Node.js installer URL
set NODE_INSTALLER_URL=https://nodejs.org/dist/v18.17.1/node-v18.17.1-x64.msi
set NODE_INSTALLER=nodejs-installer.msi

:: Download Node.js installer
echo Downloading Node.js installer...
powershell -Command "Invoke-WebRequest -Uri %NODE_INSTALLER_URL% -OutFile %NODE_INSTALLER%"

:: Install Node.js
echo Installing Node.js...
msiexec /i %NODE_INSTALLER% /quiet /norestart

:: Verify Node.js installation
node --version
npm --version

:: Clean up
echo Cleaning up...
del %NODE_INSTALLER%

endlocal
