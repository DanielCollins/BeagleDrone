ARMGNU_PREFIX=arm-none-eabi
ARM_TOOLS_DIR=$(HOME)/Tools/toolchains/arm-cs-tools

CFLAGS=-mcpu=cortex-a8 -Dgcc -Wall -Werror -O2 -I. -fdata-sections -funsigned-char -ffunction-sections
CC=$(ARMGNU_PREFIX)-gcc
LDFLAGS=-static -e Entry -u Entry -u __aeabi_uidiv -u __aeabi_idiv -nostartfiles --gc-sections
LD_LIBS=-L$(ARM_TOOLS_DIR)/lib/gcc/arm-none-eabi/4.6.3 -lgcc -L$(ARM_TOOLS_DIR)/arm-none-eabi/lib -lg -lc -lm


OBJS=kernel/boot/startup.o\
	kernel/boot/init.o\
	kernel/boot/isr.o\
    kernel/platform/dmtimer.o\
    kernel/platform/uart.o\
	kernel/drivers/cp15.o\
    kernel/drivers/uart_irda_cir.o\
	kernel/drivers/dmtimer.o\
	kernel/cpu.o\
	kernel/interrupt.o\
    kernel/sysdelay.o\
    utils/uartConsole.o\
    utils/uartStdio.o\
    utils/delay.o\
    app/crc16.o\
    app/afproto.o\
    app/communication.o\
    app/command.o\
    app/log.o\
    app/main.o

all: boot.bin

%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

boot.bin: $(OBJS)
	$(ARMGNU_PREFIX)-ld $(LDFLAGS) -T kernel/boot/linker.ld $(OBJS) -o boot.elf $(LD_LIBS)
	$(ARMGNU_PREFIX)-objcopy boot.elf -O srec boot.srec
	$(ARMGNU_PREFIX)-objcopy boot.elf -O binary boot.bin

clean:
	rm $(OBJS) boot.elf boot.srec boot.bin
