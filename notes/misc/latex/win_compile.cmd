set FILENAME=filename
set BIBNAME=filename
	
@echo off
cls
:question
echo HardBlare LaTeX tool v1.0
echo -------------------------
echo.
echo 1. Compile the document
echo 2. Clean everything but keep the PDF
echo 3. Really clean EVERYTHING
set /p choix=What do you want to do (1/2/3)? :
 
if /I "%choix%"=="1" (goto :compile)
if /I "%choix%"=="2" (goto :clean)
if /I "%choix%"=="3" (goto :clean_all)
goto question
 
:compile
pdflatex %FILENAME%.tex
bibtex %BIBNAME%
pdflatex %FILENAME%.tex
pdflatex %FILENAME%.tex
goto end
 
:clean
del %FILENAME%.aux
del %BIBNAME%.bbl
del %BIBNAME%.blg
del %FILENAME%.log
goto end
 
:clean_all
del %FILENAME%.aux
del %BIBNAME%.bbl
del %BIBNAME%.blg
del %FILENAME%.log
del %FILENAME%.pdf
goto end

:end
echo Thanks for using this tool :)
