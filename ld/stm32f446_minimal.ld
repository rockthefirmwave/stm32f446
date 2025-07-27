MEMORY
{
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 512k
    DRUM  (rw) : ORIGIN = 0x20000000, LENGTH = 128k
}

/* stack grows "down" in many architectures */
_estack = ORIGIN(DRUM) + LENGTH(DRUM);

ENTRY (Reset_Handler);

SECTIONS
{
  .isr_vector :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector))
    . = ALIGN(4);
  } > FLASH

  .text :
  {
    . = ALIGN(4);
    *(.text*)
    *(.rodata*)
    . = ALIGN(4);
  } > FLASH

  .data : AT (ADDR(.text) + SIZEOF(.text))
  {
    . = ALIGN(4);
    _sdata = .;
    *(.data)
    _edata = .;
    . = ALIGN(4);
  } > DRUM

  .bss :
  {
    . = ALIGN(4);
    _sbss = .;
    *(.bss)
    _ebss = .;
    . = ALIGN(4);  
  } > DRUM
}

/* Used by the startup to initialize data */
  _sidata = LOADADDR(.data);
