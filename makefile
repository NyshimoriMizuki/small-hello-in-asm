tiny.exe: tiny.s
	@gcc -nostdlib -s -o $@ $< -lkernel32
