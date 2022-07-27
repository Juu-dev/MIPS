.data
	title1: .asciiz  "Input name of first students: "
	title2: .asciiz  "Input name of second students: "
	title3: .asciiz  "Ket qua: \n"
	title4: .asciiz  "\n"

	space: .ascii " "
	End: .ascii  "\n"
	Result: .space 100 
	name1: .space 100
	name2: .space 100

#------------------------effects of variables-------------
# 	s1 = address(X[0])
# 	s3 = address(X[n])
# 	s4 = space
# 	s5 = /0
# 	s6 = address(X[wall])
# 	s7 = address(Result)
#---------------------------------------------------------

.text 	
	# input first name
 	li $v0, 4
 	la $a0, title1
 	syscall
 	
 	li $v0, 8
 	la $a0, name1
 	addi $a1, $zero, 100
 	syscall
 	
 	li $v0, 4
 	la $a0, title4
 	syscall
 	
 	# input second name
	li $v0, 4
 	la $a0, title2
 	syscall
 	
 	li $v0, 8
 	la $a0, name2
 	addi $a1, $zero, 100
 	syscall
 	
 	li $v0, 4
 	la $a0, title4
 	syscall

	# output
	li $v0, 4
 	la $a0, title3
 	syscall

jal ProName1
jal ProName2
j EndProgram

# Thuc thi chuong trinh voi ten hoc sinh thu nhat
ProName1: 
	la $t1, name1
	j Initial
	
# Thuc thi chuong trinh voi ten hoc sinh thu hai
ProName2:
	la $t1, name2
	j Initial

# Ket thuc chuong trinh
EndProgram:
	li $v0, 10
 	syscall


# Buoc chuan bi
Initial:
	add $s1, $t1, $zero	# s1 = address(X)

 	
 	la $t0, End		# t0 = address(End)
 	lb $s5, 0($t0)		# s5 = End
 	
 	la $s7, Result		# t0 = address(Result)
 	
	la $t0, space		# t4 = address(space)
	lb $s4, 0($t0)		# s4 = space
	

# PBat dau thuc thi thuat toan
Start:
	add $s0, $zero, $zero	# s0 = i = 0	

Loop: 
	add $t0, $s0, $s1	# t0 = address(X[i])
	nop
	lb $t1, 0($t0)		# t1 = X[i]
	nop
	beq $t1, $s5, Change	# if X[i] == "/n", exit Loop
	addi $s0, $s0, 1 	#s0 = s0 + 1 <-> i = i + 1
	j Loop


# Tim kiem space
Change:
	add $s3, $t0, $zero 	# s3 = address(X[n])
	addi $s0, $zero, 1	# s0 = i = 1
	
LoopChange:
	sub $t2, $s3, $s0	# t2 = address(X[n-i])
	
	lb $t1, 0($t2)		# t1 = X[n-i]
	beq $t1, $s4, Exe1	# if X[n-i] == ' ', exit LoopChange
	beq $t2, $s1, Nospace	# if there is no space, goto Nospace
	addi $s0, $s0, 1 	# s0 = s0 + 1 <-> i = i + 1
	j LoopChange


# Sao chep Ten
Exe1:	
	add $s6, $t2, $zero	# s6 = address(X[wall])

LoopExe1:
	addi $t2, $t2, 1 	# t2 = address(X[wall + i])
	lb $t3, 0($t2) 		# t3 = X[wall + i]
	
	beq $t3, $s5, Exe2	# if X[wall + i] == "/n", exit Loop
	sb $t3, 0($s7)		# Result[i-1] = X[wall + i]
	addi $s7, $s7, 1	# s7 = address(Result[i])

	j LoopExe1 		#next character
	nop


# Sao chep ho
Exe2:
	sb $s4, 0($s7)
	add $t1, $s1, $zero	# t1 = address(X[i])
	
LoopExe2:
	beq $t1, $s6, EndChange # if address(X[i]) == address(X[wall]), exit LoopExe2
	lb $t2, 0($t1) 		# t2 = X[i]
	
	addi $s7, $s7, 1 	# s7 = Result[k + i]
	sb $t2, 0($s7) 		# Result[k + i]= X[i]
	
	addi $t1, $t1, 1	# address(X[i + 1])
	
	nop
	j LoopExe2 		# next character

# In ra ket qua
EndChange:
	addi $s7, $s7, 1	# s7 = Result[End]
	sb $s5, 0($s7) 		#  Ket thuc xau
	
	li $v0, 4
	la $a0, Result
	syscall
	
	jr $ra
	

# In ra ten
Nospace:
	li $v0, 4
	add $a0, $s1, $0
	syscall
	
	jr $ra
	
	

	


