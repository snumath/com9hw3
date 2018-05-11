#---------------------------------------------------------
# 
#  Project #3: Drawing grid lines in an image
#
#  April 30, 2018
#
#  Jin-Soo Kim (jinsoo.kim@snu.ac.kr)
#  Systems Software & Architecture Laboratory
#  Dept. of Computer Science and Engineering
#  Seoul National University
#
#---------------------------------------------------------


.text
	.align 4
.globl bmp_grid
	.type bmp_grid,@function

bmp_grid:
	#------------------------------------------------------------
	# Use %rax, %rbx, %rcx, %rdx, %rsi, and %rdi registers only
	#	imgptr is in %rdi
	#	width  is in %rsi
	#	height is in %rdx
	#   gap	   is in %rcx
	#------------------------------------------------------------

	# --> FILL HERE <--

	pushq	%rsi
	pushq	%rdx

	# width, height is in the stack, %rsi = width, %rdx = height


	leaq	(%rsi, %rsi, 2), %rax
	addq	$0x03, %rax
	and		$0xfffffffffffffffc, %rax
	pushq	%rax

	# %rax is length of vertical bits

	movq	%rdx, %rax
	decq	%rax
	imulq	4(%rsp)


	imulq	$-0x01, %rax
	leaq	(%rcx, %rax,), %rax
	leaq	(%rax, %rax, 2), %rax
	pushq	%rax

	# %rax is a a distance from (n,top) to (n+1,bottom) imgptr

	#################################################
	#												#
	#  width - height - vertical bits - next height	#
	#												#
	#################################################

.L2:
	movq	4(%rsp), %rdx # %rdx = height

.L3:
	movb	$0x00, (%rdi)
	movb	$0x00, 1(%rdi)
	movb	$0xff, 2(%rdi)	# *imgptr = (0, 0, 255)
	addq	%rax, %rdi		# go up 1 step
	decq	%rd
	cmpq	$0, %rdx
	jg		.L3

	addq	%rbx, %rdi
	subq	%rcx, %rsi
	cmpq	$0x00, %rsi
	jg		.L2

	subq	%rcx, %rdi
	popq	%rdx
	popq	%rsi


	#------------------------------------------------------------

	popq	%rax
	popq	%rdx
	popq	%rsi

	ret
