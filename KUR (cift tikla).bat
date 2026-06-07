@echo off
chcp 65001 >nul
title A Plague Tale Requiem - Turkce Yama Kurulum
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0kur.ps1"
