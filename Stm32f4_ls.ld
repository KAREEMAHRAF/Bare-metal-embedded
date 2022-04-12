ENTRY(Reset_Handler)

MEMORY
{
	FLASH(rx) : ORIGIN = 0x08000000 , LENGTH = 512k
	SRAM(rwx) : ORIGIN = 0x20000000 , LENGTH = 128k
}

SECTIONS
{
	.text : 
	{
		*(.isr_vector) 	/*Name in startup code*/
		
		*(.text)
		*(.rodata)
		. = ALIGN(4);
		_etext = .; 	/* counter in flash (lma)*/
	}>FLASH 
						/*
						* >(vma)AT>(lma)
						* you can write >FLASH AT> FLASH
						* as vma = lma
						*/
	
	.data :
	{
		_sdata = .; 	/* counter in sram (vma)*/
		*(.data)
		_edata = .; 	/* counter in sram (vma)*/
	}>SRAM AT> FLASH 	/* >(vma)AT>(lma)*/
	
	.bss :
	{
		_sbss = .;
		*(.bss)
		_ebss = .;
	}>SRAM 				/* Only in SRAM*/


}