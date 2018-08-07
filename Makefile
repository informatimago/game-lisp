all:game

game: *.lisp *.asd
	clisp -q -ansi -norc  generate.lisp


clean:
	-rm -f game *.dx64fsl
