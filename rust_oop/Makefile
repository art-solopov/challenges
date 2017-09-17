outfile = $(shell basename `pwd`)

$(outfile) : *.rs
	rustc -o $(outfile) main.rs

run: $(outfile)
	./$(outfile)
