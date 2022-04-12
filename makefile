CC      = arm-none-eabi-gcc
MACH    = cortex-m4
CFLAGS  = -c -mcpu=$(MACH) -mthumb -std=gnu11 -Wall 
#-Wall all Warnings
LDFLAGS = -T Stm32f4_ls.ld -nostdlib -Wl,-Map=final.map
SYMBOL  = arm-none-eabi-nm 
GDB= arm-none-eabi-gdb


main.o: main.c
	#$(CC) $(CFLAGS) main.c -o main.o 
	#or
	$(CC) $(CFLAGS) $^ -o $@ 
GPIO_prog.o: GPIO_prog.c
	$(CC) $(CFLAGS) $^ -o $@
	
RCC_prog.o: RCC_prog.c
	$(CC) $(CFLAGS) $^ -o $@ 
	
Stm32f4_startup.o: Stm32f4_startup.c
	$(CC) $(CFLAGS) $^ -o $@

clean: 
	rm -rf *.o *.elf
	
final.elf: main.o GPIO_prog.o RCC_prog.o Stm32f4_startup.o
	$(CC) $(LDFLAGS) $^ -o $@

st: final.elf
	$(SYMBOL) $^ -o $@
	
all: main.o GPIO_prog.o RCC_prog.o Stm32f4_startup.o final.elf final.hex
	
load:
	openocd -f board/st_nucleo_f4.cfg	
gdb:
	$(GDB) $^ -o $@