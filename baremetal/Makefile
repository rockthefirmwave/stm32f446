# Toolchain
CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
CFLAGS = -mcpu=cortex-m4 -mthumb -std=c11 -Wall -O2 \
         -ffreestanding -nostdlib -Icmsis -Isrc \
		 -Wl,-Map=out.map
		 
#LDFLAGS = -T../ld/STM32F446RETX_FLASH.ld -nostartfiles
LDFLAGS = -T../ld/stm32f446_minimal.ld -nostartfiles

# Files
SRCS = main.c
#OBJS = $(SRCS:.c=.o) ../startup/startup_stm32f446xx.o
OBJS = $(SRCS:.c=.o) ../startup/startup_stm32f446_minimal.o
all: main.bin

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

../startup/%.o: ../startup/%.s
	$(CC) $(CFLAGS) -c $< -o $@

main.elf: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@


clean:
	rm -f *.o ../startup/*.o *.elf *.bin out.map
