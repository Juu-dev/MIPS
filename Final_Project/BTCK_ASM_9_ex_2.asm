.data
	image_D: .asciiz "                      \n **************       \n *222222222222222*    \n *22222******222222*  \n *22222*      *22222* \n *22222*       *22222*\n *22222*       *22222*\n *22222*       *22222*\n *22222*      *222222*\n *22222*******222222* \n *2222222222222222*   \n ***************      \n       ---            \n     / o o \\          \n     \\   > /          \n      -----           \n?"
	image_C: .asciiz "                    \n                    \n                    \n                    \n                    \n      ************* \n    **11111*****111*\n  **1111**       ** \n  *1111*            \n *11111*            \n *11111*            \n *11111*            \n  *1111**           \n   *1111****   *****\n    **111111***111* \n      ***********   \n?"
	image_E: .asciiz "  ************* \n *3333333333333*\n *33333******** \n *33333*        \n *33333******** \n *3333333333333*\n *33333******** \n *33333*        \n *33333******** \n *3333333333333*\n  ************* \n                \n                \n                \n                \n dce.hust.edu.vn\n?"	
	
	row_D: .space 100
	row_C: .space 100
	row_E: .space 100
	
# --------------------------------------------------------------------------
# s1 = address(image_D)
# s2 = address(image_C)
# s3 = address(image_E)
# s4 = address(row_D)
# s5 = address(row_C)
# s6 = address(row_E)

# D: 22 ky tu ; C: 20 ky tu; E : 16 ky tu
# --------------------------------------------------------------------------
	
.text


main_3:
	la $s1, image_D		# s1 = address(image_D)
	la $s4, row_D		# s4 = address(row_D)

	la $s2, image_C		# s1 = address(image_C)
	la $s5, row_C		# s5 = address(row_C)	
	
	la $s3, image_E		# s1 = address(image_E)
	la $s6, row_E		# s6 = address(row_E)
	
# Display E
DE_loop_3:
	lb $t1, 0($s3)		# t1 = ky tu tai dia chi s3
	addi $s3, $s3, 1	# tang den dia chi ky tu tiep theo
	beq $t1, '\n', back_row_E	# neu la ky tu ket thuc dong thi in chuoi ra man hinh
	beq $t1, '?', complete	# hoan thanh in chuoi neu gap ky tu ?	
	sb $t1, 0($s6)		# luu ky tu vao bien row_E
	addi $s6, $s6, 1	# tang den vi tri ky tu tiep theo
	j DE_loop
back_row_E_3:
	addi $s6, $s6, -16	# tro lai vi tri dia chi ky tu dau tien cua bien row E
	addi $a0, $s6, 0	# a0 = s6
	jal print_row
	

# Display C
DC_loop_3:
	lb $t1, 0($s2)		# t1 = ky tu tai dia chi s2
	addi $s2, $s2, 1	# tang den dia chi ky tu tiep theo
	beq $t1, '\n', back_row_C	# neu la ky tu ket thuc dong thi in chuoi ra man hinh
	sb $t1, 0($s5)		# luu ky tu vao bien row_C
	addi $s5, $s5, 1	# tang den vi tri ky tu tiep theo
	j DC_loop
back_row_C_3:
	addi $s5, $s5, -20	# tro lai vi tri dia chi ky tu dau tien cua bien row C
	addi $a0, $s5, 0	# a0 = s5
	jal print_row	

# Display D
DD_loop_3:
	lb $t1, 0($s1)		# t1 = ky tu tai dia chi s1
	addi $s1, $s1, 1	# tang den dia chi ky tu tiep theo
	beq $t1, '\n', back_row_D	# neu la ky tu ket thuc dong thi in chuoi ra man hinh
	sb $t1, 0($s4)		# luu ky tu vao bien row_D
	addi $s4, $s4, 1	# tang den vi tri ky tu tiep theo
	j DD_loop
back_row_D_3:
	addi $s4, $s4, -22	# tro lai vi tri dia chi ky tu dau tien cua bien row D
	addi $a0, $s4, 0	# a0 = s4
	jal print_row
	nop
	jal print_endl
	nop
	j DE_loop

	
convert_space_3:
	li $t1, ' '
	jr $ra

	
print_endl:
	li $v0, 11
	li $a0, '\n'
	syscall	
	
	nop
	jr $ra

print_row:
	li $v0, 4 
	syscall
	
	nop
	jr $ra
	
complete:
	li $v0, 10
	syscall
	

	

	

	
