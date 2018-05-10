.PHONY: clean

default: clean build tinycount

clean:
	rm -rf *.pdf *.lol *.aux *.lof *.log *.lot *.fls *.out *.toc *.fmt *.fot *.cb *.cb2 *.tex.bak

build:
	pdflatex -shell-escape -draftmode ml_report.tex -halt-on-error
	biber ml_report
	pdflatex -shell-escape ml_report.tex -halt-on-error

watch:
	make
	while true; do \
		inotifywait --event CLOSE_WRITE -q -r *.tex; \
			make build; \
	make servercount; \
	done

tinycount:
	scripts/texcount.pl -total `find . -name "*.tex" -not -name "Definitions.tex" -not -name "999_Appendix.tex"`

count:
	scripts/texcount.pl `find . -name "*.tex" -not -name "Definitions.tex" -not -name "999_Appendix.tex"`

spellcheck:
	find . -name "*.tex" -not -name "Definitions.tex" -exec aspell --per-conf=aspell.conf --lang=en-gb --home-dir=. --personal=dictionary.txt --mode=tex --dont-tex-check-comments -c "{}" \;

