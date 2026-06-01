# babby's 1st quasi-demo for risc-v
# .i pixra lo nu la .vynk. cu zgana lo cunso pe'a vidni
# .i la .varik. cu djuno le du'u fegli fa le velcki  .i la .varik. cu jivni le du'u cumki fa lo nu lo se lidne cu zmadu fi le ka ce'u melbi  .i pa moi lo'i co'e je ke se zbasu be la .varik.

.eqv	traji_vidnysle	131072
.eqv	heap	0x10040000
.eqv	vartisyboi_x:	15
.eqv	vartisyboi_y:	28
.eqv	vartisyboi_pamoi:	269221892
.eqv	vartisyboi_romoi:	269223572

.data
dv1:	.asciz	"dembak.bmp"
dv_vartisyboi:	.asciz	"vartisyboi.bmp"
vartisyboi_se_zvati:	.word	-1,	-1,	0	#posX, posY, lo jei .akti

.text
top:
init:
	la	a0,	dv1
	li	a1,	0
	li	a7,	1024
	ecall
	li	a7,	63
	li	a1,	heap
	li	a2,	524288	# 512 * 256 * 4
	ecall
	
	la	a0,	dv_vartisyboi
	li	a1,	0
	li	a7,	1024
	ecall
	li	a7,	63
	li	a1,	269221892
	li	a2,	1680	# 15 * 28 * 4
	ecall
	
lupe:
	li	a7,	30
	ecall
	li	a7,	41
	ecall
	mv	s0,	a0
ciska_cunso:
	li	t1,	40	# ni rajycla
	
	li	s0,	heap
	li	t0,	56164	# pa moi
	add	s0,	s0,	t0	# .i banzuka le ka ce'u barda
	
	li	a7,	30
	ecall
	li	a7,	41
	ecall
	mv	s1,	a0	# .i jai filri'a tu'a lo cunso pe'a
ciska_cunso_row:
	addi	t2,	s0,	352	# 4 * ni barda fa lo vidni me'oi .row.
ciska_cunso_row_l_vidnysle_l:
	addi	s1,	s1,	1
	mv	a1,	s1
	li	a7,	41
	ecall
	andi	a0,	a0,	0xff
	sb	a0,	(s0)
	sb	a0,	1(s0)
	sb	a0,	2(s0)
	#sb	a0,	3(s0)	# klina
	
	addi	s0,	s0,	4
	ble	s0,	t2,	ciska_cunso_row_l_vidnysle_l
	
	addi	t1,	t1,	-1
	addi	s0,	s0,	1692	# se lidne
	bgt	t1,	x0,	ciska_cunso_row
ciska_xx:
	beq	a0,	x0,	ciska_v4
	li	t0,	1
	beq	a0,	t0,	ciska_x1
	li	t0,	2
	beq	a0,	t0,	ciska_x2
fanmo:
	j	vartisyboi
fanmo_vartisyboi_selidne:
	li	a0,	200
	li	a7,	32
	ecall
	j	lupe

ciska_v4:
	# ??
	j	fanmo

# ni'o rinka lo pa moi be lo'i vartisyboi fasnu
ciska_x1:
	la	t0,	vartisyboi_se_zvati
	lw	t1,	8(t0)
	bnez	t1,	fanmo

	li	t1,	305
	sw	t1,	(t0)

	andi	t1,	s1,	31
	addi	t1,	t1,	40
	sw	t1,	4(t0)

	li	t1,	1
	sw	t1,	8(t0)
	j	fanmo

ciska_x2:
	# ??
	j	fanmo

vartisyboi:
	la	t0,	vartisyboi_se_zvati
	lw	t1,	8(t0)
	beqz	t1,	vartisyboi_fanmo

	lw	t1,	(t0)
	lw	t2,	4(t0)
vartisyboi_incr:
	addi	t1,	t1,	-1
	li	t3,	202	# 217 - 15; le selsumji be zo'e pe le pa moi be lo'i vidnysle pe le vidni ge'u bei le ni ganro

	blt	t1,	t3,	vartisyboi_tolcru

	andi	t3,	s1,	3
	sub	t2,	t2,	t3
	addi	t2,	t2,	1

	sw	t1,	(t0)
	sw	t2,	4(t0)
vartisyboi_cusku:
	li	t3,	512
	mul	a0,	t2,	t3
	add	a0,	a0,	t1
	li	t3,	4
	mul	a0,	a0,	t3

	li	t3,	heap
	add	a0,	a0,	t3

	li	t4,	0	# idx co pixra
	li	t5,	269221892	# +1
vartisyboi_cusku_row:
	li	t6,	0

	li	t3,	15
	div	a2,	t4,	t3
	add	a2,	a2,	t2
	li	t3,	27
	blt	a2,	t3,	vartisyboi_cusku_row_post_2
	li	t3,	66
	bgt	a2,	t3,	vartisyboi_cusku_row_post_2
vartisyboi_cusku_row_l:	# ni'o rinka lo nu cusku pe'a lo se du'u lo pa vidnysle cu mo kau
	li	t3,	15
	rem	a2,	t4,	t3
	add	a2,	a2,	t1
	li	t3,	217
	blt	a2,	t3,	vartisyboi_cusku_row_l_selidne
	li	t3,	304
	bgt	a2,	t3,	vartisyboi_cusku_row_l_selidne
	lb	a1,	(t5)
	beqz	a1,	vartisyboi_cusku_row_l_selidne

	li	a1,	0xc0c0c0c0
	sw	a1,	(a0)
vartisyboi_cusku_row_l_selidne:
	addi	t4,	t4,	1
	addi	t5,	t5,	4
	addi	t6,	t6,	1
	addi	a0,	a0,	4
	li	t3,	15
	blt	t6,	t3,	vartisyboi_cusku_row_l
vartisyboi_cusku_row_post:
	addi	a0,	a0,	1988	# se lidne; 4 ? 512 - 15
	li	t3,	420	# ni barda fa le vartisyboi pixra
	blt	t4,	t3,	vartisyboi_cusku_row
vartisyboi_fanmo:
	j	fanmo_vartisyboi_selidne
# .i pilno ki'u tu'a la'oi .vartisyboi_cusku_row.
vartisyboi_cusku_row_post_2:
	# .i co'e ja sarcu fa lo nu jifyjunxu'a pe'a lo du'u cfari
	addi	t4,	t4,	15
	addi	t5,	t5,	60	# 15 ? 4
	addi	a0,	a0,	60
	j	vartisyboi_cusku_row_post
vartisyboi_tolcru:
	sw	x0,	8(t0)
	j	vartisyboi_fanmo

# je ne vois qu'infini par toutes les fen\^etres
