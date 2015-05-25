#  Data Area
.data

welcome:
	.asciiz " \n\n Main Menu:"

option1:
	.asciiz " \n 1 - Area of a circle"
	
option2:
	.asciiz " \n 2 - Circumference of a Circle"
	
option3:
	.asciiz " \n 3 - Area of a Rectangle"

option4:
	.asciiz " \n 4 - Perimeter of Rectangle"
	
option5:
	.asciiz " \n 5 - Exit"
	
prompt: 
	.asciiz " \n\n Enter the task number you wish to perform: "
	
radius:
	.asciiz " \n Enter a number (for the radius): "
	
area:
	.asciiz " \n The area is: "
	
circumference:
	.asciiz " \n The circumference is: "
	
length:
	.asciiz " \n Enter a number (for the length): "
	
width:
	.asciiz " \n Enter a number (for the width): "
	
perimeter:
	.asciiz " \n The perimeter is: "

pi:
	.float 3.1415926
	
exit:
	.asciiz " \n Exitting program"
	
error:
	.asciiz " \n Invalid input"

#Text Area (i.e. instructions)
.text

main:
    addi	$v0, $0, 4			# System call code: print string
	la		$a0, welcome		# Label welcome is printed
	syscall
	la		$a0, option1		# Label option1 is loaded and printed
	syscall
	la		$a0, option2		# Label option2 is loaded and printed
	syscall
	la		$a0, option3		# Label option3 is loaded and printed
	syscall
	la		$a0, option4		# Label option4 is loaded and printed
	syscall
	la		$a0, option5		# Label option5 is loaded and printed
	syscall
	la		$a0, prompt			# Label prompt is loaded and printed
	syscall
	addi	$v0, $0, 5			# System call code: read integer
	syscall
	
	addi	$t0, $0, 1			# $t0 = 1
	addi	$t1, $0, 2			# $t1 = 2
	addi	$t2, $0, 3			# $t2 = 3
	addi	$t3, $0, 4			# $t3 = 4
	addi	$t4, $0, 5			# $t4 = 5
	beq     $v0, $t0, AREA		# if (user input == 1)
	beq     $v0, $t1, CIRCUMF	# if (user input == 2)
	beq		$v0, $t2, AREC		# if (user input == 3)
	beq     $v0, $t3, PREC		# if (user input == 4)
	beq     $v0, $t4, EXIT		# if (user input == 5)
	blt		$v0, $t1, PRINTERROR
	bgt		$v0, $t4, PRINTERROR
	
	j		main

PRINTERROR:
	addi	$v0, $0, 4			# System call code: print string
	la		$a0, error			# Label error is loaded and printed
	syscall
	j		main

AREA:
	addi	$v0, $0, 4			# System call code: print string
	la		$a0, option1		# Label option1 is loaded and printed
	syscall
	la		$a0, radius			# Label radius is loaded and printed
	syscall
	addi	$v0, $0, 6			# System call code: read float
	syscall
	mul.s	$f12, $f0, $f0		# $f4 = radius * radius
	l.s		$f4, pi				# $f6 = pi
	mul.s	$f12, $f12, $f4		# $f12 = pi * radius * radius
	addi	$v0, $0, 4			# System call code: print string
	la		$a0, area			# Label area is loaded and printed
	syscall
	addi	$v0, $0, 2			# System call code: print float
	syscall
	
	j		main

CIRCUMF:
	addi	$v0, $0, 4			# System call code: print string
	la		$a0, option2		# Label option2 is loaded and printed
	syscall
	la		$a0, radius			# Label radius is loaded and printed
	syscall
	addi	$v0, $0, 6			# System call code: read float
	syscall
	l.s		$f4, pi				# $f4 = pi
	mul.s	$f12, $f0, $f4		# $f12 = radius * pi
	add.s	$f12, $f12, $f12	# $f12 = 2(radius * pi)
	addi	$v0, $0, 4			# System call code: print string
	la		$a0, circumference	# Label area is loaded and printed
	syscall
	addi	$v0, $0, 2			# System call code: print float
	syscall
	
	j		main
	
AREC:
	addi	$v0, $0, 4			# System call code: print string
	la		$a0, option3		# Label option3 is loaded and printed
	syscall
	la		$a0, length			# Label length is loaded and printed
	syscall
	addi	$v0, $0, 7			# System call code: read double
	syscall
	
	mov.d	$f12, $f0			# $f12 = length
	
	addi	$v0, $0, 4			# System call code: print string
	la		$a0, width			# Label width is loaded and printed
	syscall
	addi	$v0, $0, 7			# System call code: read double
	syscall
	
	mul.d	$f12, $f12, $f0		# $f12 = length * width
	
	addi	$v0, $0, 4			# System call code: print string
	la		$a0, area			# Label area is loaded and printed
	syscall
	addi	$v0, $0, 3			# System call code: print double
	syscall
	
	j		main
	
PREC:
	addi	$v0, $0, 4			# System call code: print string
	la		$a0, option4		# Label option4 is loaded and printed
	syscall
	la		$a0, length			# Label length is loaded and printed
	syscall
	addi	$v0, $0, 7			# System call code: read double
	syscall
	
	add.d	$f12, $f0, $f0		# $f12 = length + length
	
	addi	$v0, $0, 4			# System call code: print string
	la		$a0, width			# Label width is loaded and printed
	syscall
	addi	$v0, $0, 7			# System call code: read double
	syscall
	
	add.d	$f0, $f0, $f0		# $f0 = width + width
	add.d	$f12, , $f12, $f0	# $f12 = length + length + width + width
	
	addi	$v0, $0, 4			# System call code: print string
	la		$a0, perimeter		# Label perimeter is loaded and printed
	syscall
	addi	$v0, $0, 3			# System call code: print double
	syscall
	
	j		main
	
EXIT:
	addi	$v0, $0, 4			# System call code: print string
	la		$a0, exit			# Label exit is loaded and printed
	syscall
	addi	$v0, , $0, 10		# Exit
	syscall
