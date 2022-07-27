.data
	image_D: .asciiz "                      \n **************       \n *222222222222222*    \n *22222******222222*  \n *22222*      *22222* \n *22222*       *22222*\n *22222*       *22222*\n *22222*       *22222*\n *22222*      *222222*\n *22222*******222222* \n *2222222222222222*   \n ***************      \n       ---            \n     / o o \\          \n     \\   > /          \n      -----           \n?"
	image_C: .asciiz "                    \n                    \n                    \n                    \n                    \n      ************* \n    **11111*****111*\n  **1111**       ** \n  *1111*            \n *11111*            \n *11111*            \n *11111*            \n  *1111**           \n   *1111****   *****\n    **111111***111* \n      ***********   \n?"
	image_E: .asciiz "  ************* \n *3333333333333*\n *33333******** \n *33333*        \n *33333******** \n *3333333333333*\n *33333******** \n *33333*        \n *33333******** \n *3333333333333*\n  ************* \n                \n                \n                \n                \n dce.hust.edu.vn\n?"	
	
	color_D: .asciiz "\nmau cua D : "
	color_C: .asciiz "\nmau cua C : "
	color_E: .asciiz "\nmau cua E : "
	
	row_D: .space 100
	row_C: .space 100
	row_E: .space 100
	
	title: .asciiz "\n\n----------------MENU-----------------------------------\n"
	option1: .asciiz "1. Hien thi hinh anh len giao dien console.\n"
	option2: .asciiz "2. Hien thi hinh anh DCE chi con vien, khong con mau.\n"
	option3: .asciiz "3. Hien thi hinh anh ECD (duoc hoan doi tu DCE).\n"
	option4: .asciiz "4. Nhap mau cho D, C, E roi hien thi voi mau vua nhap.\n"
	option5: .asciiz "5. Thoat.\n"
	title_end:	.asciiz  "-------------------------------------------------------\n"
	choose: .asciiz "Lua chon: "
	error: .asciiz "\nMau khong ton tai!\n"
	
		
				
# --------------------------------------------------------------------------
# s0 : lua chon tu menu
# s1 = address(image_D)
# s2 = address(image_C)
# s3 = address(image_E)
# s4 = address(row_D)
# s5 = address(row_C)
# s6 = address(row_E)
# s7 : mau cua D
# t8 : mau cua C
# t9 : mau cua E

# D: 22 ky tu ; C: 20 ky tu; E : 16 ky tu
# --------------------------------------------------------------------------
	
.text

# tao menu de de dang test chuong trinh
menu:
	li $v0, 4
	la $a0, title
	syscall
	
	li $v0, 4
	la $a0, option1
	syscall
	
	li $v0, 4
	la $a0, option2
	syscall
	
	li $v0, 4
	la $a0, option3
	syscall
	
	li $v0, 4
	la $a0, option4
	syscall
	
	li $v0, 4
	la $a0, option5
	syscall
	
	li $v0, 4
	la $a0, title_end
	syscall
	
# gan mot so bien co ban trong chuong trinh
prepare_var:
	la $s1, image_D		# s1 = address(image_D)
	la $s4, row_D		# s4 = address(row_D)

	la $s2, image_C		# s1 = address(image_C)
	la $s5, row_C		# s5 = address(row_C)	
	
	la $s3, image_E		# s1 = address(image_E)
	la $s6, row_E		# s6 = address(row_E)	

# lua chon trong menu
input_menu:
	li $v0, 4
	la $a0, choose
	syscall
	
	li $v0, 5
	syscall
	
	add $s0, $v0, $zero
	
# nhay den chuong trinh lua chon yeu cau
	beq $s0, 1, main_1
	beq $s0, 2, main_2
	beq $s0, 3, main_3
	beq $s0, 4, main_4
	beq $s0, 5, exit_pro
	j input_menu


	
# -------------------------------------------------------------------------
# MAIN 1: GACH DAU DONG THU 1
# -------------------------------------------------------------------------
main_1:

# Display D
DD_loop_1:
	lb $t1, 0($s1)		# t1 = ky tu tai dia chi s1
	addi $s1, $s1, 1	# tang den dia chi ky tu tiep theo
	beq $t1, '\n', back_row_D_1	# neu la ky tu ket thuc dong thi in chuoi ra man hinh
	beq $t1, '?', complete	# hoan thanh in chuoi neu gap ky tu ?
	sb $t1, 0($s4)		# luu ky tu vao bien row_D
	addi $s4, $s4, 1	# tang den vi tri ky tu tiep theo
	j DD_loop_1
back_row_D_1:
	addi $s4, $s4, -22	# tro lai vi tri dia chi ky tu dau tien cua bien row D
	addi $a0, $s4, 0	# a0 = s4
	jal print_row

# Display C
DC_loop_1:
	lb $t1, 0($s2)		# t1 = ky tu tai dia chi s2
	addi $s2, $s2, 1	# tang den dia chi ky tu tiep theo
	beq $t1, '\n', back_row_C_1	# neu la ky tu ket thuc dong thi in chuoi ra man hinh
	sb $t1, 0($s5)		# luu ky tu vao bien row_C
	addi $s5, $s5, 1	# tang den vi tri ky tu tiep theo
	j DC_loop_1
back_row_C_1:
	addi $s5, $s5, -20	# tro lai vi tri dia chi ky tu dau tien cua bien row C
	addi $a0, $s5, 0	# a0 = s5
	jal print_row	


# Display E
DE_loop_1:
	lb $t1, 0($s3)		# t1 = ky tu tai dia chi s3
	addi $s3, $s3, 1	# tang den dia chi ky tu tiep theo
	beq $t1, '\n', back_row_E_1	# neu la ky tu ket thuc dong thi in chuoi ra man hinh
	sb $t1, 0($s6)		# luu ky tu vao bien row_E
	addi $s6, $s6, 1	# tang den vi tri ky tu tiep theo
	j DE_loop_1
back_row_E_1:
	addi $s6, $s6, -16	# tro lai vi tri dia chi ky tu dau tien cua bien row E
	addi $a0, $s6, 0	# a0 = s6
	jal print_row
	nop
	jal print_endl
	nop
	j DD_loop_1
	
	
# -------------------------------------------------------------------------
# MAIN 2: GACH DAU DONG THU 2
# -------------------------------------------------------------------------
main_2:

# Display D
DD_loop_2:
	lb $t1, 0($s1)		# t1 = ky tu tai dia chi s1
	addi $s1, $s1, 1	# tang den dia chi ky tu tiep theo
	beq $t1, '\n', back_row_D_2	# neu la ky tu ket thuc dong thi in chuoi ra man hinh
	beq $t1, '?', complete	# hoan thanh in chuoi neu gap ky tu ?
	
	jal check_int_2
	
	sb $t1, 0($s4)		# luu ky tu vao bien row_D
	addi $s4, $s4, 1	# tang den vi tri ky tu tiep theo
	j DD_loop_2
back_row_D_2:
	addi $s4, $s4, -22	# tro lai vi tri dia chi ky tu dau tien cua bien row D
	addi $a0, $s4, 0	# a0 = s4
	jal print_row

# Display C
DC_loop_2:
	lb $t1, 0($s2)		# t1 = ky tu tai dia chi s2
	addi $s2, $s2, 1	# tang den dia chi ky tu tiep theo
	beq $t1, '\n', back_row_C_2	# neu la ky tu ket thuc dong thi in chuoi ra man hinh
	
	jal check_int_2
	
	   
	sb $t1, 0($s5)		# luu ky tu vao bien row_C
	addi $s5, $s5, 1	# tang den vi tri ky tu tiep theo
	j DC_loop_2
back_row_C_2:
	addi $s5, $s5, -20	# tro lai vi tri dia chi ky tu dau tien cua bien row C
	addi $a0, $s5, 0	# a0 = s5
	jal print_row	


# Display E
DE_loop_2:
	lb $t1, 0($s3)		# t1 = ky tu tai dia chi s3
	addi $s3, $s3, 1	# tang den dia chi ky tu tiep theo
	beq $t1, '\n', back_row_E_2	# neu la ky tu ket thuc dong thi in chuoi ra man hinh
	
	jal check_int_2
	
	sb $t1, 0($s6)		# luu ky tu vao bien row_E
	addi $s6, $s6, 1	# tang den vi tri ky tu tiep theo
	j DE_loop_2
back_row_E_2:
	addi $s6, $s6, -16	# tro lai vi tri dia chi ky tu dau tien cua bien row E
	addi $a0, $s6, 0	# a0 = s6
	jal print_row
	nop
	jal print_endl
	nop
	j DD_loop_2
	
# kiem tra xem ky tu vua doc co phai ky tu mau hay khong
check_int_2:
	slti $t2, $t1, ':'	# t2 =1 neu t1 < '9'
	li $t4, '/'
	slt $t3, $t4, $t1	# t3 =1 neu t1 > '0'
	add $t4, $t2, $t3	
	beq $t4, 2, convert_space_2
	jr $ra

# thay mau = ky tu space
convert_space_2:
	li $t1, ' '
	jr $ra


	
# -------------------------------------------------------------------------
# MAIN 3: GACH DAU DONG THU 3
# -------------------------------------------------------------------------
main_3:
# Display E
DE_loop_3:
	lb $t1, 0($s3)		# t1 = ky tu tai dia chi s3
	addi $s3, $s3, 1	# tang den dia chi ky tu tiep theo
	beq $t1, '\n', back_row_E_3	# neu la ky tu ket thuc dong thi in chuoi ra man hinh
	beq $t1, '?', complete	# hoan thanh in chuoi neu gap ky tu ?	
	sb $t1, 0($s6)		# luu ky tu vao bien row_E
	addi $s6, $s6, 1	# tang den vi tri ky tu tiep theo
	j DE_loop_3
back_row_E_3:
	addi $s6, $s6, -16	# tro lai vi tri dia chi ky tu dau tien cua bien row E
	addi $a0, $s6, 0	# a0 = s6
	jal print_row
	

# Display C
DC_loop_3:
	lb $t1, 0($s2)		# t1 = ky tu tai dia chi s2
	addi $s2, $s2, 1	# tang den dia chi ky tu tiep theo
	beq $t1, '\n', back_row_C_3	# neu la ky tu ket thuc dong thi in chuoi ra man hinh
	sb $t1, 0($s5)		# luu ky tu vao bien row_C
	addi $s5, $s5, 1	# tang den vi tri ky tu tiep theo
	j DC_loop_3
back_row_C_3:
	addi $s5, $s5, -20	# tro lai vi tri dia chi ky tu dau tien cua bien row C
	addi $a0, $s5, 0	# a0 = s5
	jal print_row	

# Display D
DD_loop_3:
	lb $t1, 0($s1)		# t1 = ky tu tai dia chi s1
	addi $s1, $s1, 1	# tang den dia chi ky tu tiep theo
	beq $t1, '\n', back_row_D_3	# neu la ky tu ket thuc dong thi in chuoi ra man hinh
	sb $t1, 0($s4)		# luu ky tu vao bien row_D
	addi $s4, $s4, 1	# tang den vi tri ky tu tiep theo
	j DD_loop_3
back_row_D_3:
	addi $s4, $s4, -22	# tro lai vi tri dia chi	 ky tu dau tien cua bien row D
	addi $a0, $s4, 0	# a0 = s4
	jal print_row
	nop
	jal print_endl
	nop
	j DE_loop_3


	
# -------------------------------------------------------------------------
# MAIN 4: GACH DAU DONG THU 4
# -------------------------------------------------------------------------
main_4:
	
# mau cua D
	# title
color_D_4:
	li $v0, 4
	la $a0, color_D
	syscall
	
	nop 
	nop
	nop
	
	# doc mau tu ban phim
	li $v0, 12
	syscall
	#kiem tra mau vua nhap co hop le hay khong 
	li $t6, 0
	jal check_color_4     
	
	add $s7, $v0, $zero

# mau cua C
	# title
color_C_4:
	li $v0, 4
	la $a0, color_C
	syscall
	
	nop 
	nop
	nop
	
	# doc mau tu ban phim
	li $v0, 12
	syscall
	#kiem tra mau vua nhap co hop le hay khong 
	li $t6, 1
	jal check_color_4
	
	add $t8, $v0, $zero
	
# mau cua E
	# title
color_E_4:
	li $v0, 4
	la $a0, color_E
	syscall
	
	nop 
	nop
	nop
	
	# doc mau tu ban phim
	li $v0, 12
	syscall
	#kiem tra mau vua nhap co hop le hay khong 
	li $t6, 2
	jal check_color_4
	add $t9, $v0, $zero
	
	# xuong dong 
	li $v0, 12
	li $a0, '\n'
	syscall

# sau khi doc xong tu ban phim thi bat dau xu ly

# Display D
DD_loop_4:
	lb $t1, 0($s1)		# t1 = ky tu tai dia chi s1
	addi $s1, $s1, 1	# tang den dia chi ky tu tiep theo
	beq $t1, '\n', back_row_D_4	# neu la ky tu ket thuc dong thi in chuoi ra man hinh
	beq $t1, '?', complete	# hoan thanh in chuoi neu gap ky tu ?
	
	jal check_int_4
	
	sb $t1, 0($s4)		# luu ky tu vao bien row_D
	addi $s4, $s4, 1	# tang den vi tri ky tu tiep theo
	j DD_loop_4
back_row_D_4:
	addi $s4, $s4, -22	# tro lai vi tri dia chi ky tu dau tien cua bien row D
	addi $a0, $s4, 0	# a0 = s4
	jal print_row

# Display C
DC_loop_4:
	lb $t1, 0($s2)		# t1 = ky tu tai dia chi s2
	addi $s2, $s2, 1	# tang den dia chi ky tu tiep theo
	beq $t1, '\n', back_row_C_4	# neu la ky tu ket thuc dong thi in chuoi ra man hinh
	
	jal check_int_4
	
	   
	sb $t1, 0($s5)		# luu ky tu vao bien row_C
	addi $s5, $s5, 1	# tang den vi tri ky tu tiep theo
	j DC_loop_4
back_row_C_4:
	addi $s5, $s5, -20	# tro lai vi tri dia chi ky tu dau tien cua bien row C
	addi $a0, $s5, 0	# a0 = s5
	jal print_row	


# Display E
DE_loop_4:
	lb $t1, 0($s3)		# t1 = ky tu tai dia chi s3
	addi $s3, $s3, 1	# tang den dia chi ky tu tiep theo
	beq $t1, '\n', back_row_E_4	# neu la ky tu ket thuc dong thi in chuoi ra man hinh
	
	jal check_int_4
	
	sb $t1, 0($s6)		# luu ky tu vao bien row_E
	addi $s6, $s6, 1	# tang den vi tri ky tu tiep theo
	jal DE_loop_4
back_row_E_4:
	addi $s6, $s6, -16	# tro lai vi tri dia chi ky tu dau tien cua bien row E
	addi $a0, $s6, 0	# a0 = s6
	jal print_row
	nop
	jal print_endl
	nop
	j DD_loop_4
	
# kiem tra xem ky tu vua doc co phai ky tu mau khong
check_int_4:
	slti $t2, $t1, ':'	# t2 =1 neu t1 < '9'
	li $t4, '/'
	slt $t3, $t4, $t1	# t3 =1 neu t1 > '0'
	add $t4, $t2, $t3	
	beq $t4, 2, convert_color_4
	jr $ra

# kiem tra xem ky tu vua doc tu ban phim co phai ky tu mau khong	
check_color_4:
	slti $t2, $v0, ':'	# t2 =1 neu v0 <= '9'
	li $t4, '/'
	slt $t3, $t4, $v0	# t3 =1 neu v0 >= '0'
	add $t4, $t2, $t3	
	bne $t4, 2, error_color
	jr $ra

# Loi mau ky tu
error_color:
	li $v0, 4
	la $a0, error
	syscall
	nop
	nop
	nop 
	beq $t6, 0, color_D_4
	beq $t6, 1, color_C_4
	beq $t6, 2, color_E_4
	

# Xac dinh chu can chuyen mau
convert_color_4:
	beq $t1, '2', convert_color_D_4
	beq $t1, '1', convert_color_C_4
	beq $t1, '3', convert_color_E_4


# chuyen mau cho D
convert_color_D_4:
	add $t1, $s7, $zero
	jr $ra

# chuyen mau cho C
convert_color_C_4:
	add $t1, $t8, $zero
	jr $ra
	
# chuyen mau cho E
convert_color_E_4:
	add $t1, $t9, $zero
	jr $ra

# -------------------------------------------------------------------------
# HAM DUNG CHUNG
# -------------------------------------------------------------------------

# xuong dong
print_endl:
	li $v0, 11
	li $a0, '\n'
	syscall	
	
	nop
	jr $ra

# in dong hien tai
print_row:
	li $v0, 4 
	syscall
	
	nop
	jr $ra
	
# hoan thanh yeu cau
complete:
	j menu
	
# thoat chuong trinh
exit_pro:
	li $v0, 10
	syscall
	
