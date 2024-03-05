build:
	@nasm -felf64 main.asm && ld -o stars main.o

clean:
	@rm *.o stars
