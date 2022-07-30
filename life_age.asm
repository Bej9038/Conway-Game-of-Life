#
# FILE:         life_age.asm
# AUTHOR:       Ben Jordan, bej9038
# DESCRIPTION:
#	Runs Conway's Game of Life With Age for CSCI250 project 1
#
# INPUT:
# 	The board size, the number of generations to run,
#	the number of starting cells, and the starting cell
#	locations
#
# OUTPUT:
#	A game banner along with generations 0 through n of cells
#
#-------------------------------

#
# NUMERIC CONSTANTS
#
PRINT_INT = 1
PRINT_STRING = 4
PRINT_CHAR = 11
READ_INT = 5
READ_STRING = 8
ARRAY_SIZE = 900
A_ASCII = 65
MAX_BSIZE = 30
MAX_GENS = 20
OFFSET = 4


#
# DATA
#
	.data
	.align 2

# the game board
cell_array:
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#100
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#200
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#300
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#400
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#500
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#600
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#700
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#800
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#900

# the temporary board
temp_array:
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#100
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#200
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#300
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#400
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#500
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#600
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#700
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#800
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	
	#900

	.align 0

newline:
	.asciiz "\n"
equals:
	.asciiz "===="
space4:
	.asciiz "    "
gen_banner:
	.asciiz "GENERATION "
banner1:
	.asciiz "*************************************\n"
banner2:
	.asciiz "****    Game of Life with Age    ****\n"
size_prompt:
	.asciiz "Enter board size: "
gen_prompt:
	.asciiz "Enter number of generations to run: "
cell_prompt:
	.asciiz "Enter number of live cells: "
loc_prompt:
	.asciiz "Start entering locations"
board_size_error:
	.asciiz "WARNING: illegal board size, try again: "
gen_num_error:
	.asciiz "WARNING: illegal number of generations, try again: "
cell_num_error:
	.asciiz "WARNING: illegal number of live cells, try again: "
location_error:
	.asciiz "\nERROR: illegal point location\n"

#
# CODE
#
	.text
	.align	2

	.globl main
	.globl print_board
	.globl update_board
	.globl reset_cells


# Name: main
#
main:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)

	la	$a3, temp_array
	jal	reset_cells
	la	$a3, cell_array
	jal	reset_cells

	jal 	print_banner		# print prog banner
	
	jal 	prompt_boardsize	# prompt for boardsize
	move	$a1, $v0		# a1 = boardsize

	jal 	prompt_gennum		# prompt for num of gens
	move	$s0, $v0		# s0 = number of gens
	
	jal 	prompt_cells		# prompt for num of cells
	move	$a2, $v0		# a2 = number of cells

	jal 	prompt_loc		# prompt for cell locs
	beq	$v0, $zero, main_done	# if prompt_loc returns 0, terminate
	
	li	$s1, 0			# print gens index
	addi	$s2, $s0, 1		# gens entered + 1
	la	$a2, temp_array		# a2 = temp array address

print_gens:
	slt	$t0, $s1, $s2
	beq	$t0, $zero, main_done

	li	$v0, PRINT_STRING	# prinnt gen banner
	la	$a0, newline
		syscall
	la	$a0, equals
		syscall
	la	$a0, space4
		syscall
	la	$a0, gen_banner
		syscall
	li	$v0, PRINT_INT
	move	$a0, $s1
		syscall
	li	$v0, PRINT_STRING
	la	$a0, space4
		syscall
	la	$a0, equals
		syscall

	jal 	print_board		# print board

	jal	update_board		# update the board for next gen
	#jal	print_array
	
	addi	$s1, $s1, 1		# move onto next gen
	j	print_gens

main_done:
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	jr 	$ra


# Name:		prompt_loc
# Description:	Prompts user for locations of live cells and saves them.
# Arguments:    a1: The board size
#		a2: The number of live cells
#		a3: Cell arry address
# Returns:      v0: 0 on failure, 1 on success
# Destroys:     t0, t1, t2, t3, t4, t5, t6, t7, v0, a0
#
prompt_loc:
	li	$v0, PRINT_STRING
	la	$a0, loc_prompt		# print prompt
		syscall
l_prompt:
	li	$t0, 0			# loop index
	li	$v0, PRINT_STRING
	la	$a0, newline
		syscall	
l_while:
	slt	$t1, $t0, $a2
	beq	$t1, $zero, l_done	

	li	$v0, READ_INT
		syscall			# read row
	move	$t2, $v0
	li	$v0, READ_INT
		syscall			# read col
	move	$t3, $v0

	mul	$t6, $t3, $a1		# map 2d row and col to 1d array index		
	add	$t6, $t6, $t2		# index = row + width * col

	mul	$t6, $t6, OFFSET	# indexing offset = i * 4
	add	$t6, $t6, $a3 
	lw	$t7, 0($t6)

	bne	$t7, $zero, l_err

	slt	$t4, $t2, $zero		# check row
	bne	$t4, $zero, l_err
	slt	$t4, $a1, $t2
	bne	$t4, $zero, l_err
	slt	$t5, $t3, $zero		# check col
	bne	$t5, $zero, l_err
	slt	$t5, $a1, $t3
	bne	$t5, $zero, l_err

	li	$t7, A_ASCII		# load A and save in cell
	sw	$t7, 0($t6)

	addi	$t0, $t0, 1
	j	l_while

	li	$v0, PRINT_STRING
	la	$a0, newline
		syscall	
l_done:
	li 	$v0, 1
	jr	$ra
l_err:
	li	$v0, PRINT_STRING	# invalid location
	la	$a0, location_error	
		syscall
	li	$v0, 0
	jr 	$ra


# Name:		prompt_cells
# Description:	Prompts user for number of live cells.
# Arguments:    a1: The board size
# Returns:      v0: The number of live cells
# Destroys:     t0, t1, t2, v0, a0
#
prompt_cells:
	li	$v0, PRINT_STRING
	la	$a0, cell_prompt	# print prompt
		syscall
c_prompt:
	li	$v0, READ_INT
		syscall			# read cell number
	move	$t1, $v0

	li	$v0, PRINT_STRING
	la	$a0, newline
		syscall
	
	mul	$t0, $a1, $a1		# check cell number
	slt	$t2, $t1, $zero
	bne	$t2, $zero, c_err
	slt	$t2, $t0, $t1
	bne	$t2, $zero, c_err

	move	$v0, $t1
	jr	$ra
c_err:
	li	$v0, PRINT_STRING	# invalid number of cells
	la	$a0, cell_num_error	
		syscall
	j c_prompt


# Name:		prompt_gennum
# Description:	Prompts user for number of generations to run.
# Arguments:    none
# Returns:      v0: The number of generations
# Destroys:     t0, t1, t2, v0, a0
#
prompt_gennum:
	li	$t0, MAX_GENS
	li	$v0, PRINT_STRING
	la	$a0, gen_prompt
		syscall			# print prompt

g_prompt:
	li	$v0, READ_INT
		syscall			# read gens
	move	$t1, $v0

	li	$v0, PRINT_STRING
	la	$a0, newline
		syscall
	
	slt	$t2, $t1, $zero		# check gens
	bne	$t2, $zero, g_err
	slt	$t2, $t0, $t1
	bne	$t2, $zero, g_err

	move	$v0, $t1
	jr	$ra
g_err:
	li	$v0, PRINT_STRING	# invalid number of gens
	la	$a0, gen_num_error	
		syscall
	j g_prompt


# Name:		prompt_boardsize
# Description:	Prompts user for board size.
# Arguments:    none
# Returns:      v0: The board size
# Destroys:     t0, t1, t2, v0, a0
#
prompt_boardsize:
	
	li	$v0, PRINT_STRING
	la	$a0, size_prompt
		syscall 		# print prompt
b_prompt:
	li	$t0, MAX_BSIZE
	li	$v0, READ_INT		
		syscall			# read boardsize
	move	$t1, $v0

	li	$v0, PRINT_STRING
	la	$a0, newline
		syscall
	
	slti	$t2, $t1, OFFSET	# check boardsize
	bne	$t2, $zero, b_err
	slt	$t2, $t0, $t1
	bne	$t2, $zero, b_err 	 

	move	$v0, $t1
	jr	$ra

b_err:
	li	$v0, PRINT_STRING	# invalid boardsize
	la	$a0, board_size_error
		syscall
	j b_prompt


# Name:		print_banner
# Description:	Prints the program banner.
# Arguments:    none
# Returns:      none
# Destroys:     v0, a0
#
print_banner: 

	li	$v0, PRINT_STRING
	la	$a0, newline
		syscall
	la	$a0, banner1
		syscall
	la	$a0, banner2
		syscall
	la	$a0, banner1
		syscall
	la	$a0, newline
		syscall
	jr	$ra


# Name:		print_array
# Description:	Used to print the contents of the temp or cell array for
#		testing purposes.
# Arguments:    none
# Returns:      none
# Destroys:     t0, t1, t2, t3, t4, a0, v0
#
print_array:
	li	$t0, 0
	la	$t1, cell_array
	la	$t2, temp_array
print_while:
	slti	$t3, $t0, ARRAY_SIZE
	beq	$t3, $zero, print_done
	
	
	mul	$t4, $t0, OFFSET
	add	$t4, $t4, $t2		# $t1 to test main, $t2 to test temp
	lw	$t5, 0($t4)
	li	$v0, PRINT_CHAR
	move	$a0, $t5
		syscall
	
	addi	$t0, $t0, 1
	j	print_while
print_done:
	jr	$ra
