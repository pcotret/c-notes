## Here is a simple Makefile for a basic LaTeX flow with a bibliography
## make help:
##     print this menu
## make all:
##     compile the stuff
## make clean:
##     remove temporary files
## make clean_pdf:
##     remove the output PDF file
## make clean_all:
##     remove EVERYTHING
# Variables
FILENAME=mainfile
BIBNAME=mainfile

help:
	@grep -e "^##" Makefile;
all:
	pdflatex ${FILENAME}.tex
	bibtex ${BIBNAME}
	pdflatex ${FILENAME}.tex
	pdflatex ${FILENAME}.tex
clean:
	rm *.aux *.bbl *.blg *.log *.gz *.tns *.out
clean_pdf:
	rm *.pdf
clean_all: clean clean_pdf
