rm -f *.aux chapters/*.aux appendices/*.aux
xelatex -interaction=nonstopmode Main.tex
xelatex -interaction=nonstopmode Main.tex