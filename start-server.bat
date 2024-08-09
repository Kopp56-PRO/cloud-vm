@echo off
setlocal

:: Check if Node.js is installed
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo Node.js is not installed. Installing Node.js...
    call install-node.bat
)

:: Run the Node.js server
echo Starting Node.js server...
node server.js

endlocal
