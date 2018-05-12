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

	# %rax is distance from (k,l) to (k, l+1) imgptr

	movq	8(%rsp), %rax
	imulq	(%rsp)
	subq	%rcx, %rax
	subq	%rcx, %rax
	subq	%rcx, %rax
	#leaq	(%rcx, %rcx, 2), %rax	# rax = -(height - 1) * rax + 3 * gap
	#leaq	(%rax, %rax, 2), %rax

	pushq	%rax

	# %rax is a a distance from (n,top + 1) to (n+1,bottom) imgptr

	#################################################
	#												#
	#  width - height - vertical bits - next height	#
	#												#
	#################################################

	movq	16(%rsp), %rdx # %rdx = height

/*
.L2:
	movl	$0x0000, (%rdi)
	movb	$0xff, 2(%rdi)	# *imgptr = (0, 0, 255)
	addq	8(%rsp), %rdi
	decq	%rdx
	cmpq	$0, %rdx
	jg		.L2

	subq	(%rsp), %rdi
*/

	movq	24(%rsp), %rdx # %rdx = height

.L2:
	movq	16(%rsp), %rdx # %rdx = height

.L3:
	movl	$0x0000, (%rdi)
	movb	$0xff, 2(%rdi)	# *imgptr = (0, 0, 255)
	addq	8(%rsp), %rdi
	decq	%rdx
	cmpq	$0, %rdx
	jg		.L3

	subq	(%rsp), %rdi
	subq	%rcx, %rsi
	cmpq	$0, %rsi
	jg		.L2


	#################################################
	#	여기 밑에부터 수정하고 합시다 ^~^			#
	#################################################


	addq	(%rsp), %rdi
	addq	%rsi, %rdi
	addq	%rcx, %rdi
	subq	$0x03, %rdi

	movl	$0x0000, (%rdi)
	movb	$0xff, 2(%rdi)	# *imgptr = (0, 0, 255)

	popq	%rax
	popq	%rax
	popq	%rdx
	popq	%rsi

	#------------------------------------------------------------

	ret
