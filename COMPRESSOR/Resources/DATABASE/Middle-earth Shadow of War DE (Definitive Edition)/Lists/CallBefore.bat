@echo off
title DiskSpan GUI Compressor
setlocal EnableDelayedExpansion EnableExtensions

cd /D "%~dp0"
if "%~3" NEQ "" ( for /F "tokens=* delims=" %%a in ("%~3") do ( set "GameDir=%%~fa" && set "BackupDir=%%~fa (Backup)") ) else ( endlocal && exit /B )


:BenchmarkFile
cls
echo.
echo.----------------------------------------------------------------------
echo. Do you want to keep the Benchmark.arch06 file? [Y/N]
echo. This file is only neccessary for the ingame hardware benchmark test.
echo. The game works fine without this file.
echo.
echo. Backup files will be made here:
echo. !BackupDir!\
echo.----------------------------------------------------------------------
choice /C NY /N
if errorlevel 2 (
	goto LangChoice
) else (
	mkdir "!BackupDir!"
	move /Y "!GameDir!\Benchmark.arch06" "!BackupDir!\"
	TIMEOUT 1
)


:LangChoice
cls
echo.
echo.----------------------------------------------------------------------
echo. Which language you did want to use?
echo.
echo. Backup files will be made here:
echo. !BackupDir!\
echo.----------------------------------------------------------------------
echo. 0 = Do nothing, just compress
echo.
echo. 1 = ENGLISH
echo. 2 = FRENCH
echo. 3 = GERMAN
echo. 4 = ITALIAN
echo. 5 = JAPANESE
echo. 6 = PORTUGUESE (BRAZIL)
echo. 7 = SPANISH (SPAIN)
echo. 8 = SPANISH (MEXICO)
echo.

set /P "LangChoice="
if "!LangChoice!" EQU "" goto LangChoice
if "!LangChoice!" EQU "0" goto EndLang
if "!LangChoice!" EQU "1" goto English
if "!LangChoice!" EQU "2" goto French
if "!LangChoice!" EQU "3" goto German
if "!LangChoice!" EQU "4" goto Italian
if "!LangChoice!" EQU "5" goto Japanese
if "!LangChoice!" EQU "6" goto PortugueseBrazil
if "!LangChoice!" EQU "7" goto SpanishSpain
if "!LangChoice!" EQU "8" goto SpanishMexico


:English
mkdir "!BackupDir!\game\sound"
move /Y "!GameDir!\game\sound\FrenchFrance" "!BackupDir!\game\sound\FrenchFrance"
move /Y "!GameDir!\game\sound\German" "!BackupDir!\game\sound\German"
move /Y "!GameDir!\game\sound\Italian" "!BackupDir!\game\sound\Italian"
move /Y "!GameDir!\game\sound\Japanese" "!BackupDir!\game\sound\Japanese"
move /Y "!GameDir!\game\sound\PortugueseBrazil" "!BackupDir!\game\sound\PortugueseBrazil"
move /Y "!GameDir!\game\sound\SpanishSpain" "!BackupDir!\game\sound\SpanishSpain"
move /Y "!GameDir!\game\sound\SpanishMexico" "!BackupDir!\game\sound\SpanishMexico"
move /Y "!GameDir!\presentations_fr.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_de.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_it.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_ja.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_ptbr.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_eses.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_esla.arch06" "!BackupDir!\"
goto EndLang


:French
mkdir "!BackupDir!\game\sound"
move /Y "!GameDir!\game\sound\EnglishUS" "!BackupDir!\game\sound\EnglishUS"
move /Y "!GameDir!\game\sound\German" "!BackupDir!\game\sound\German"
move /Y "!GameDir!\game\sound\Italian" "!BackupDir!\game\sound\Italian"
move /Y "!GameDir!\game\sound\Japanese" "!BackupDir!\game\sound\Japanese"
move /Y "!GameDir!\game\sound\PortugueseBrazil" "!BackupDir!\game\sound\PortugueseBrazil"
move /Y "!GameDir!\game\sound\SpanishSpain" "!BackupDir!\game\sound\SpanishSpain"
move /Y "!GameDir!\game\sound\SpanishMexico" "!BackupDir!\game\sound\SpanishMexico"
move /Y "!GameDir!\presentations_en.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_de.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_it.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_ja.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_ptbr.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_eses.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_esla.arch06" "!BackupDir!\"
goto EndLang


:German
mkdir "!BackupDir!\game\sound"
move /Y "!GameDir!\game\sound\EnglishUS" "!BackupDir!\game\sound\EnglishUS"
move /Y "!GameDir!\game\sound\FrenchFrance" "!BackupDir!\game\sound\FrenchFrance"
move /Y "!GameDir!\game\sound\Italian" "!BackupDir!\game\sound\Italian"
move /Y "!GameDir!\game\sound\Japanese" "!BackupDir!\game\sound\Japanese"
move /Y "!GameDir!\game\sound\PortugueseBrazil" "!BackupDir!\game\sound\PortugueseBrazil"
move /Y "!GameDir!\game\sound\SpanishSpain" "!BackupDir!\game\sound\SpanishSpain"
move /Y "!GameDir!\game\sound\SpanishMexico" "!BackupDir!\game\sound\SpanishMexico"
move /Y "!GameDir!\presentations_en.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_fr.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_it.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_ja.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_ptbr.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_eses.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_esla.arch06" "!BackupDir!\"
goto EndLang


:Italian
mkdir "!BackupDir!\game\sound"
move /Y "!GameDir!\game\sound\EnglishUS" "!BackupDir!\game\sound\EnglishUS"
move /Y "!GameDir!\game\sound\FrenchFrance" "!BackupDir!\game\sound\FrenchFrance"
move /Y "!GameDir!\game\sound\German" "!BackupDir!\game\sound\German"
move /Y "!GameDir!\game\sound\Japanese" "!BackupDir!\game\sound\Japanese"
move /Y "!GameDir!\game\sound\PortugueseBrazil" "!BackupDir!\game\sound\PortugueseBrazil"
move /Y "!GameDir!\game\sound\SpanishSpain" "!BackupDir!\game\sound\SpanishSpain"
move /Y "!GameDir!\game\sound\SpanishMexico" "!BackupDir!\game\sound\SpanishMexico"
move /Y "!GameDir!\presentations_en.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_fr.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_de.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_ja.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_ptbr.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_eses.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_esla.arch06" "!BackupDir!\"
goto EndLang


:Japanese
mkdir "!BackupDir!\game\sound"
move /Y "!GameDir!\game\sound\EnglishUS" "!BackupDir!\game\sound\EnglishUS"
move /Y "!GameDir!\game\sound\FrenchFrance" "!BackupDir!\game\sound\FrenchFrance"
move /Y "!GameDir!\game\sound\German" "!BackupDir!\game\sound\German"
move /Y "!GameDir!\game\sound\Italian" "!BackupDir!\game\sound\Italian"
move /Y "!GameDir!\game\sound\PortugueseBrazil" "!BackupDir!\game\sound\PortugueseBrazil"
move /Y "!GameDir!\game\sound\SpanishSpain" "!BackupDir!\game\sound\SpanishSpain"
move /Y "!GameDir!\game\sound\SpanishMexico" "!BackupDir!\game\sound\SpanishMexico"
move /Y "!GameDir!\presentations_en.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_fr.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_de.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_it.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_ptbr.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_eses.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_esla.arch06" "!BackupDir!\"
goto EndLang


:PortugueseBrazil
mkdir "!BackupDir!\game\sound"
move /Y "!GameDir!\game\sound\EnglishUS" "!BackupDir!\game\sound\EnglishUS"
move /Y "!GameDir!\game\sound\FrenchFrance" "!BackupDir!\game\sound\FrenchFrance"
move /Y "!GameDir!\game\sound\German" "!BackupDir!\game\sound\German"
move /Y "!GameDir!\game\sound\Italian" "!BackupDir!\game\sound\Italian"
move /Y "!GameDir!\game\sound\Japanese" "!BackupDir!\game\sound\Japanese"
move /Y "!GameDir!\game\sound\SpanishSpain" "!BackupDir!\game\sound\SpanishSpain"
move /Y "!GameDir!\game\sound\SpanishMexico" "!BackupDir!\game\sound\SpanishMexico"
move /Y "!GameDir!\presentations_en.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_fr.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_de.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_it.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_ja.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_eses.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_esla.arch06" "!BackupDir!\"
goto EndLang


:SpanishSpain
mkdir "!BackupDir!\game\sound"
move /Y "!GameDir!\game\sound\EnglishUS" "!BackupDir!\game\sound\EnglishUS"
move /Y "!GameDir!\game\sound\FrenchFrance" "!BackupDir!\game\sound\FrenchFrance"
move /Y "!GameDir!\game\sound\German" "!BackupDir!\game\sound\German"
move /Y "!GameDir!\game\sound\Italian" "!BackupDir!\game\sound\Italian"
move /Y "!GameDir!\game\sound\Japanese" "!BackupDir!\game\sound\Japanese"
move /Y "!GameDir!\game\sound\PortugueseBrazil" "!BackupDir!\game\sound\PortugueseBrazil"
move /Y "!GameDir!\game\sound\SpanishMexico" "!BackupDir!\game\sound\SpanishMexico"
move /Y "!GameDir!\presentations_en.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_fr.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_de.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_it.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_ja.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_ptbr.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_esla.arch06" "!BackupDir!\"
goto EndLang


:SpanishMexico
mkdir "!BackupDir!\game\sound"
move /Y "!GameDir!\game\sound\EnglishUS" "!BackupDir!\game\sound\EnglishUS"
move /Y "!GameDir!\game\sound\FrenchFrance" "!BackupDir!\game\sound\FrenchFrance"
move /Y "!GameDir!\game\sound\German" "!BackupDir!\game\sound\German"
move /Y "!GameDir!\game\sound\Italian" "!BackupDir!\game\sound\Italian"
move /Y "!GameDir!\game\sound\Japanese" "!BackupDir!\game\sound\Japanese"
move /Y "!GameDir!\game\sound\PortugueseBrazil" "!BackupDir!\game\sound\PortugueseBrazil"
move /Y "!GameDir!\game\sound\SpanishSpain" "!BackupDir!\game\sound\SpanishSpain"
move /Y "!GameDir!\presentations_en.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_fr.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_de.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_it.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_ja.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_ptbr.arch06" "!BackupDir!\"
move /Y "!GameDir!\presentations_eses.arch06" "!BackupDir!\"
goto EndLang


:EndLang
endlocal
exit /B