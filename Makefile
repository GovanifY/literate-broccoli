test:
	iverilog -c dependencies.txt && ./a.out

clean:
	rm -f *.log
	rm -f *.aux
	rm -f *.auxlock
	rm -f report/*.log
	rm -f report/*.aux
	rm -f report/*.auxlock

cleanall: clean
	rm -f a.out
	rm -f *.pdf
	rm -f report/*.pdf
	rm -f report/Tikz/*

