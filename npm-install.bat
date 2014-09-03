::npm-install.bat
@echo off
::install web server dependencies && api server dependencies
cd web-server && npm install -d && cd .. && cd api-server && npm install -d