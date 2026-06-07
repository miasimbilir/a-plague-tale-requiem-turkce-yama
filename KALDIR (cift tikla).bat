@echo off
chcp 65001 >nul
title A Plague Tale Requiem - Turkce Yama Kaldir
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0kaldir.ps1"
