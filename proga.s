# babby's 1st demo for risc-v
# .i pixra lo nu la .vynk. cu zgana lo cunso pe'a vidni

.eqv	traji_vidnysle	131072

.text
top:
init:
lupe:
	li	a7,	30
	ecall
	li	a7,	41
	ecall
	mv	s0,	a0
	beq	a0,	x0,	ciska_v4
	li	t0,	1
	beq	a0,	t0,	ciska_x1
	li	t0,	2
	beq	a0,	t0,	ciska_x2
ciska_cunso:
	li	t1,	traji_vidnysle
	li	t0,	4
	mul	t1,	t1,	t0
	li	t0,	0x10040000
	add	t1,	t1,	t0	

	li	t0,	0x1003fffc
ciska_cunso_l:
	mv	a0,	s0
	addi	t0,	t0,	4
	li	a7,	41
	ecall
	sw	a0,	(t0)
	addi	s0,	s0,	1
	ble	t0,	t1,	ciska_cunso_l
fanmo:
	li	a0,	20
	li	a7,	32
	ecall
	j	lupe

ciska_v4:
	# ??
	j	fanmo

ciska_x1:
	# ??
	j	fanmo

ciska_x2:
	# ??
	j	fanmo
