CFLAGS =  -O3 -Wall -mavx512f
all: main

main: main.o movq.o
	gcc -o main main.o movq.o

# zero.o: zero.asm
# 	nasm -f elf64 zero.asm -o zero.o

movq.o: movq.S
	gcc -c $< $(CFLAGS) -o $@

main.o: main.c
	gcc -c $< $(CFLAGS) -m64 -mxsavec -o $@

clean:
	rm -f main *.o