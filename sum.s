	.file	"sum.c"
	.text
	.p2align 5,,31
	.globl	check_ip_header_sum
	.type	check_ip_header_sum, @function
check_ip_header_sum:
.LFB22:
	.cfi_startproc
	movl	4(%rdi), %edx
	movl	(%rdi), %eax
	shrq	$2, %rsi
	addq	%rdx, %rax
	movl	8(%rdi), %edx
	addq	%rdx, %rax
	movl	12(%rdi), %edx
	addq	%rdx, %rax
	movl	16(%rdi), %edx
	addq	%rdx, %rax
	cmpq	$5, %rsi
	jbe	.L15
	leaq	20(%rdi), %rdx
	leaq	-5(%rsi), %r8
	andl	$15, %edx
	movq	%r8, %rcx
	shrq	$2, %rdx
	negq	%rdx
	andl	$3, %edx
	cmpq	%r8, %rdx
	cmova	%r8, %rdx
	cmpq	$6, %r8
	ja	.L28
.L3:
	movl	20(%rdi), %edx
	addq	%rdx, %rax
	cmpq	$1, %rcx
	jbe	.L18
	movl	24(%rdi), %edx
	addq	%rdx, %rax
	cmpq	$2, %rcx
	jbe	.L19
	movl	28(%rdi), %edx
	addq	%rdx, %rax
	cmpq	$3, %rcx
	jbe	.L20
	movl	32(%rdi), %edx
	addq	%rdx, %rax
	cmpq	$4, %rcx
	jbe	.L21
	movl	36(%rdi), %edx
	addq	%rdx, %rax
	cmpq	$5, %rcx
	jbe	.L22
	movl	40(%rdi), %edx
	addq	%rdx, %rax
	movl	$11, %edx
.L5:
	cmpq	%r8, %rcx
	je	.L15
.L4:
	subq	%rcx, %r8
	movq	%r8, %r10
	shrq	$2, %r10
	leaq	0(,%r10,4), %r11
	testq	%r11, %r11
	je	.L7
	pxor	%xmm0, %xmm0
	leaq	20(%rdi,%rcx,4), %r9
	xorl	%ecx, %ecx
.L13:
	movdqa	(%r9), %xmm2
	addq	$1, %rcx
	addq	$16, %r9
	cmpq	%rcx, %r10
	pmovzxdq	%xmm2, %xmm1
	psrldq	$8, %xmm2
	paddq	%xmm0, %xmm1
	pmovzxdq	%xmm2, %xmm0
	paddq	%xmm1, %xmm0
	ja	.L13
	movdqa	%xmm0, %xmm3
	addq	%r11, %rdx
	psrldq	$8, %xmm3
	paddq	%xmm3, %xmm0
	pextrq	$0, %xmm0, %rcx
	addq	%rcx, %rax
	cmpq	%r8, %r11
	je	.L15
.L7:
	movl	(%rdi,%rdx,4), %ecx
	addq	%rcx, %rax
	leaq	1(%rdx), %rcx
	cmpq	%rsi, %rcx
	jae	.L15
	movl	(%rdi,%rcx,4), %ecx
	addq	$2, %rdx
	addq	%rcx, %rax
	cmpq	%rdx, %rsi
	jbe	.L15
	movl	(%rdi,%rdx,4), %edx
	addq	%rdx, %rax
	.p2align 5
.L15:
	movzwl	%ax, %edx
	shrq	$16, %rax
	addq	%rdx, %rax
	movq	%rax, %rdx
	xorw	%dx, %dx
	testq	%rdx, %rdx
	jne	.L15
	cmpq	$65535, %rax
	sete	%al
	ret
	.p2align 4,,10
	.p2align 3
.L28:
	testq	%rdx, %rdx
	jne	.L29
	xorl	%ecx, %ecx
	movl	$5, %edx
	jmp	.L4
.L18:
	movl	$6, %edx
	jmp	.L5
.L19:
	movl	$7, %edx
	jmp	.L5
.L20:
	movl	$8, %edx
	jmp	.L5
.L21:
	movl	$9, %edx
	jmp	.L5
.L22:
	movl	$10, %edx
	jmp	.L5
.L29:
	movq	%rdx, %rcx
	jmp	.L3
	.cfi_endproc
.LFE22:
	.size	check_ip_header_sum, .-check_ip_header_sum
	.p2align 5,,31
	.globl	sum
	.type	sum, @function
sum:
.LFB23:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L43
	movq	%rdi, %rax
	movq	%rsi, %rdx
	andl	$15, %eax
	shrq	$2, %rax
	negq	%rax
	andl	$3, %eax
	cmpq	%rsi, %rax
	cmova	%rsi, %rax
	cmpq	$6, %rsi
	ja	.L55
.L32:
	cmpq	$1, %rdx
	movl	(%rdi), %eax
	jbe	.L46
	movl	4(%rdi), %ecx
	addq	%rcx, %rax
	cmpq	$2, %rdx
	jbe	.L47
	movl	8(%rdi), %ecx
	addq	%rcx, %rax
	cmpq	$3, %rdx
	jbe	.L48
	movl	12(%rdi), %ecx
	addq	%rcx, %rax
	cmpq	$4, %rdx
	jbe	.L49
	movl	16(%rdi), %ecx
	addq	%rcx, %rax
	cmpq	$5, %rdx
	jbe	.L50
	movl	20(%rdi), %ecx
	addq	%rcx, %rax
	movl	$6, %ecx
.L34:
	cmpq	%rdx, %rsi
	je	.L56
.L33:
	movq	%rsi, %r11
	subq	%rdx, %r11
	movq	%r11, %r9
	shrq	$2, %r9
	leaq	0(,%r9,4), %r10
	testq	%r10, %r10
	je	.L36
	pxor	%xmm0, %xmm0
	leaq	(%rdi,%rdx,4), %r8
	xorl	%edx, %edx
.L42:
	movdqa	(%r8), %xmm2
	addq	$1, %rdx
	addq	$16, %r8
	cmpq	%rdx, %r9
	pmovzxdq	%xmm2, %xmm1
	psrldq	$8, %xmm2
	paddq	%xmm0, %xmm1
	pmovzxdq	%xmm2, %xmm0
	paddq	%xmm1, %xmm0
	ja	.L42
	movdqa	%xmm0, %xmm3
	addq	%r10, %rcx
	psrldq	$8, %xmm3
	paddq	%xmm3, %xmm0
	pextrq	$0, %xmm0, %rdx
	addq	%rdx, %rax
	cmpq	%r10, %r11
	je	.L31
.L36:
	movl	(%rdi,%rcx,4), %edx
	addq	%rdx, %rax
	leaq	1(%rcx), %rdx
	cmpq	%rdx, %rsi
	jbe	.L31
	movl	(%rdi,%rdx,4), %edx
	addq	$2, %rcx
	addq	%rdx, %rax
	cmpq	%rcx, %rsi
	jbe	.L57
	movl	(%rdi,%rcx,4), %edx
	addq	%rdx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L43:
	xorl	%eax, %eax
.L31:
	rep ret
	.p2align 4,,10
	.p2align 3
.L56:
	rep ret
	.p2align 4,,10
	.p2align 3
.L55:
	testq	%rax, %rax
	jne	.L58
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	.p2align 4,,2
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L57:
	rep ret
	.p2align 4,,10
	.p2align 3
.L47:
	movl	$2, %ecx
	jmp	.L34
	.p2align 4,,10
	.p2align 3
.L48:
	movl	$3, %ecx
	jmp	.L34
	.p2align 4,,10
	.p2align 3
.L49:
	movl	$4, %ecx
	jmp	.L34
	.p2align 4,,10
	.p2align 3
.L50:
	movl	$5, %ecx
	jmp	.L34
	.p2align 4,,10
	.p2align 3
.L46:
	movl	$1, %ecx
	jmp	.L34
.L58:
	movq	%rax, %rdx
	jmp	.L32
	.cfi_endproc
.LFE23:
	.size	sum, .-sum
	.p2align 5,,31
	.globl	sum0
	.type	sum0, @function
sum0:
.LFB24:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L72
	movq	%rdi, %rax
	movq	%rsi, %rdx
	andl	$15, %eax
	shrq	$2, %rax
	negq	%rax
	andl	$3, %eax
	cmpq	%rsi, %rax
	cmova	%rsi, %rax
	cmpq	$6, %rsi
	ja	.L84
.L61:
	cmpq	$1, %rdx
	movl	(%rdi), %eax
	jbe	.L75
	movl	4(%rdi), %ecx
	addq	%rcx, %rax
	cmpq	$2, %rdx
	jbe	.L76
	movl	8(%rdi), %ecx
	addq	%rcx, %rax
	cmpq	$3, %rdx
	jbe	.L77
	movl	12(%rdi), %ecx
	addq	%rcx, %rax
	cmpq	$4, %rdx
	jbe	.L78
	movl	16(%rdi), %ecx
	addq	%rcx, %rax
	cmpq	$5, %rdx
	jbe	.L79
	movl	20(%rdi), %ecx
	addq	%rcx, %rax
	movl	$6, %ecx
.L63:
	cmpq	%rdx, %rsi
	je	.L85
.L62:
	movq	%rsi, %r11
	subq	%rdx, %r11
	movq	%r11, %r9
	shrq	$2, %r9
	leaq	0(,%r9,4), %r10
	testq	%r10, %r10
	je	.L65
	pxor	%xmm0, %xmm0
	leaq	(%rdi,%rdx,4), %r8
	xorl	%edx, %edx
.L71:
	movdqa	(%r8), %xmm2
	addq	$1, %rdx
	addq	$16, %r8
	cmpq	%rdx, %r9
	pmovzxdq	%xmm2, %xmm1
	psrldq	$8, %xmm2
	paddq	%xmm0, %xmm1
	pmovzxdq	%xmm2, %xmm0
	paddq	%xmm1, %xmm0
	ja	.L71
	movdqa	%xmm0, %xmm3
	addq	%r10, %rcx
	psrldq	$8, %xmm3
	paddq	%xmm3, %xmm0
	pextrq	$0, %xmm0, %rdx
	addq	%rdx, %rax
	cmpq	%r10, %r11
	je	.L60
.L65:
	movl	(%rdi,%rcx,4), %edx
	addq	%rdx, %rax
	leaq	1(%rcx), %rdx
	cmpq	%rdx, %rsi
	jbe	.L60
	movl	(%rdi,%rdx,4), %edx
	addq	$2, %rcx
	addq	%rdx, %rax
	cmpq	%rcx, %rsi
	jbe	.L86
	movl	(%rdi,%rcx,4), %edx
	addq	%rdx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L72:
	xorl	%eax, %eax
.L60:
	rep ret
	.p2align 4,,10
	.p2align 3
.L85:
	rep ret
	.p2align 4,,10
	.p2align 3
.L84:
	testq	%rax, %rax
	jne	.L87
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	.p2align 4,,2
	jmp	.L62
	.p2align 4,,10
	.p2align 3
.L86:
	rep ret
	.p2align 4,,10
	.p2align 3
.L76:
	movl	$2, %ecx
	jmp	.L63
	.p2align 4,,10
	.p2align 3
.L77:
	movl	$3, %ecx
	jmp	.L63
	.p2align 4,,10
	.p2align 3
.L78:
	movl	$4, %ecx
	jmp	.L63
	.p2align 4,,10
	.p2align 3
.L79:
	movl	$5, %ecx
	jmp	.L63
	.p2align 4,,10
	.p2align 3
.L75:
	movl	$1, %ecx
	jmp	.L63
.L87:
	movq	%rax, %rdx
	jmp	.L61
	.cfi_endproc
.LFE24:
	.size	sum0, .-sum0
	.p2align 5,,31
	.globl	sum1
	.type	sum1, @function
sum1:
.LFB25:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L91
	leaq	(%rdi,%rsi,4), %rcx
	xorl	%eax, %eax
	.p2align 5
.L90:
	movl	(%rdi), %edx
	addq	$4, %rdi
	addq	%rdx, %rax
	cmpq	%rcx, %rdi
	jne	.L90
	rep ret
.L91:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE25:
	.size	sum1, .-sum1
	.p2align 5,,31
	.globl	sum2
	.type	sum2, @function
sum2:
.LFB26:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L101
	movq	%rsi, %rcx
	shrq	$2, %rcx
	leaq	0(,%rcx,4), %rdx
	testq	%rdx, %rdx
	je	.L102
	cmpq	$4, %rsi
	jbe	.L102
	pxor	%xmm0, %xmm0
	xorl	%eax, %eax
.L100:
	movq	%rax, %r8
	addq	$1, %rax
	salq	$4, %r8
	cmpq	%rax, %rcx
	movdqu	(%rdi,%r8), %xmm2
	pmovzxdq	%xmm2, %xmm1
	psrldq	$8, %xmm2
	paddq	%xmm0, %xmm1
	pmovzxdq	%xmm2, %xmm0
	paddq	%xmm1, %xmm0
	ja	.L100
	movdqa	%xmm0, %xmm3
	cmpq	%rdx, %rsi
	psrldq	$8, %xmm3
	paddq	%xmm3, %xmm0
	pextrq	$0, %xmm0, %rax
	je	.L104
.L94:
	movl	(%rdi,%rdx,4), %ecx
	addq	%rcx, %rax
	leaq	1(%rdx), %rcx
	cmpq	%rcx, %rsi
	jbe	.L93
	movl	(%rdi,%rcx,4), %ecx
	addq	%rcx, %rax
	leaq	2(%rdx), %rcx
	cmpq	%rcx, %rsi
	jbe	.L93
	movl	(%rdi,%rcx,4), %ecx
	addq	$3, %rdx
	addq	%rcx, %rax
	cmpq	%rdx, %rsi
	jbe	.L105
	movl	(%rdi,%rdx,4), %edx
	addq	%rdx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L101:
	xorl	%eax, %eax
.L93:
	rep ret
	.p2align 4,,10
	.p2align 3
.L102:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L94
	.p2align 4,,10
	.p2align 3
.L104:
	rep ret
	.p2align 4,,10
	.p2align 3
.L105:
	rep ret
	.cfi_endproc
.LFE26:
	.size	sum2, .-sum2
	.p2align 5,,31
	.globl	sum3
	.type	sum3, @function
sum3:
.LFB27:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L109
	leaq	(%rdi,%rsi,4), %rcx
	xorl	%eax, %eax
	.p2align 5
.L108:
	movl	(%rdi), %edx
	addq	$4, %rdi
	addq	%rdx, %rax
	cmpq	%rcx, %rdi
	jne	.L108
	rep ret
.L109:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE27:
	.size	sum3, .-sum3
	.ident	"GCC: (GNU) 4.8.3 20140911 (Red Hat 4.8.3-7)"
	.section	.note.GNU-stack,"",@progbits
