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

	# %rax is distance from (k,l) to (k,l+1) imgptr

	movq	8(%rsp), %rax
	imulq	(%rsp)
	subq	%rcx, %rax
	subq	%rcx, %rax
	subq	%rcx, %rax
	pushq	%rax

	# %rax is a a distance from (k,top+1) to (k+gap,bottom) imgptr

	#################################################
	#												#
	#  width - height - vertical bits - next height	#
	#												#
	#################################################

	movq	16(%rsp), %rdx	# %rdx = height
	movq	24(%rsp), %rsi	# %rsi = width 

.L2:
	movw	$0x00, (%rdi)
	movb	$0xff, 2(%rdi)	# *imgptr = (0,0,255)
	addq	8(%rsp), %rdi	# (k,l) -> (k,l+1)
	decq	%rdx			# %rdx--
	cmpq	$0, %rdx		# %rdx > 0?
	jg		.L2

	subq	(%rsp), %rdi	# (k,top) -> (k+gap,bottom)
	subq	%rcx, %rsi		# %rsi -= gap
	cmpq	$0, %rsi		# %rsi > 0?
	#cmpq	%rcx, %rsi		# %rsi > 0?
	movq	16(%rsp), %rdx	# %rdx = height
	jg		.L2


	#################################################
	#		여기 밑에부터 밥먹고 합시다 ^~^			#
	#################################################



	addq	(%rsp), %rdi
	subq	8(%rsp), %rdi
	subq	$0x03, %rdi

	addq	%rsi, %rdi
	addq	%rsi, %rdi
	addq	%rsi, %rdi

	addq	%rcx, %rdi
	addq	%rcx, %rdi
	addq	%rcx, %rdi


	movq	8(%rsp), %rax
	imulq	%rcx
	subq	8(%rsp), %rax
	pushq	%rax

	movq	24(%rsp), %rdx	# %rdx = height
	movq	32(%rsp), %rsi	# %rsi = width


.L3:
	movw	$0x00, (%rdi)
	movb	$0xff, 2(%rdi)	# *imgptr = (0,0,255)
	subq	$0x03, %rdi		# (k,l) -> (k-1,l)
	decq	%rsi			# %rsi--
	cmpq	$0, %rsi		# %rsi > 0?
	jg		.L3

	subq	(%rsp), %rdi	# (end,l) -> (end,l-gap)
	subq	%rcx, %rdx		# %rdx -= gap
	cmpq	$0, %rdx		# %rdx > 0?
	movq	32(%rsp), %rsi	# %rsi = width
	jg		.L3


	movq	24(%rsp), %rdx	# %rdx = height


	#------------------------------------------------------------

	popq	%rax
	popq	%rax
	popq	%rax
	popq	%rdx
	popq	%rsi
	ret
