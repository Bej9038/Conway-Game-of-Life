#
# FILE:         board.asm
# AUTHOR:       Ben Jordan, bej9038
# DESCRIPTION:
#	Responsible for printing the board, updaating the bord,
#	copying the cell arrays representing the board, and reseting
#	the cell arrays
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
OFFSET = 4

#
# DATA
#
	.data
	.align 0

star:
	.asciiz "*"
equals:
	.asciiz "="
board_corner:
	.asciiz "+"
board_line_h:
	.asciiz "-"
board_line_v:
	.asciiz "|"
blank:
	.asciiz " "
newline:
	.asciiz "\n"	

#
# CODE
#
	.text
	.align 2
	.globl print_board
	.globl update_board
	.globl reset_cells


# Name:		print_board
# Description:	Prints the board for one generation.
# Arguments:    a1: The board size
#		a3: The address of cell location array
# Returns:      none
# Destroys:	t0, t1, t2, a0, v0
#
print_board:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	li	$v0, PRINT_STRING
	la	$a0, newline
		syscall	
	jal 	print_t_and_b

	li	$t0, 0			# col index
print_rows:
	slt	$t1, $t0, $a1
	beq	$t1, $zero, print_board_done

new_row:
	li	$t1, 0			# row index
	la	$a0, board_line_v
		syscall
print_row_cells:	
	slt	$t2, $t1, $a1
	beq	$t2, $zero, new_row_done
	
	mul	$t2, $a1, $t1
	add	$t2, $t2, $t0		# i = row + width * col	
	mul	$t2, $t2, OFFSET
	add	$t2, $t2, $a3		
	lw	$t3, 0($t2)		# load cell, if alive print char
	bne	$t3, $zero, is_alive		
	
	la	$a0, blank		# print dead cell
		syscall
	j	skip_print

is_alive:
	li	$v0, PRINT_CHAR
	move	$a0, $t3
		syscall
	li	$v0, PRINT_STRING
skip_print:
	addi	$t1, $t1, 1		# row++
	j	print_row_cells

new_row_done:
	la	$a0, board_line_v
		syscall
	la	$a0, newline
		syscall	
	addi	$t0, $t0, 1		# col++
	j	print_rows
print_board_done:

	jal	print_t_and_b	
	lw	$ra, 0($sp)	
	addi	$sp, $sp, 4
	jr 	$ra


# Name:		update_board
# Description:	Updates the cells on the board based on the rules
#		before the generation is printed. Writes the new cells
#		into the temp arry to avoid messing up the current gen
#		and then copies the temp into the main array for next gen.
#		Then resets the temp array for next update.
# Arguments:    a1: The board size
#		a2: The temp array address
#		a3: The cell array address
# Returns:      none
# Destroys:	t0, t1, t2, t3, t4, t5, t6, t7
#
update_board:
	addi	$sp, $sp, -20
	sw	$ra, 16($sp)
	sw	$s3, 12($sp)
	sw	$s2, 8($sp)
	sw	$s1, 4($sp)
	sw	$s0, 0($sp)
	
	li	$s3, 0		# index			
itr_board:
	slti	$t1, $s3, ARRAY_SIZE	
	beq	$t1, $zero, itr_done
	
	# calculate neighbors
	li	$s7, 0		# num neighbors
	li	$t7, -1
	div	$s3, $a1	
	mfhi	$s0		# row = index % width
	mflo	$s1		# col = index / width	

# check nbr 1

nbr1:
	addi	$t2, $s0, -1  	# row - 1
	addi	$t3, $s1, -1	# col -1
	# check boundries
	beq	$t2, $t7, bad_row1
	j	good_row1	
bad_row1:
	addi	$t2, $a1, -1
good_row1:	
	beq	$t3, $t7, bad_col1
	j	good_col1
bad_col1:
	addi	$t3, $a1, -1
good_col1:	
	# load value
	mul	$t4, $t3, $a1	
	add	$t4, $t4, $t2	# find index
	mul	$t4, $t4, OFFSET
	add	$t4, $t4, $a3	# add offset to main arr address
	
	lw	$t5, 0($t4)	# load neighbor
	beq	$t5, $zero, nbr2# if neighbor isnt dead, neighbors++
	addi	$s7, $s7, 1

# check nbr 2

nbr2:
	addi	$t2, $s0, -1  	# row - 1
	move	$t3, $s1	# col
	# check boundries
	beq	$t2, $t7, bad_row2
	j	good_row2	
bad_row2:
	addi	$t2, $a1, -1
good_row2:	
	# load value
	mul	$t4, $t3, $a1	
	add	$t4, $t4, $t2	# find index
	mul	$t4, $t4, OFFSET
	add	$t4, $t4, $a3	# add offset to main arr address
	
	lw	$t5, 0($t4)	# load neighbor
	beq	$t5, $zero, nbr3# if neighbor isnt dead, neighbors++
	addi	$s7, $s7, 1

# check nbr 3

nbr3:
	addi	$t2, $s0, -1  	# row - 1
	addi	$t3, $s1, 1	# col + 1
	# check boundries
	beq	$t2, $t7, bad_row3
	j	good_row3	
bad_row3:
	addi	$t2, $a1, -1
good_row3:	
	beq	$t3, $a1, bad_col3
	j	good_col3
bad_col3:
	move	$t3, $zero
good_col3:	
	# load value
	mul	$t4, $t3, $a1	
	add	$t4, $t4, $t2	# find index
	mul	$t4, $t4, OFFSET
	add	$t4, $t4, $a3	# add offset to main arr address
	
	lw	$t5, 0($t4)	# load neighbor
	beq	$t5, $zero, nbr4# if neighbor isnt dead, neighbors++
	addi	$s7, $s7, 1

# check nbr 4

nbr4:
	move	$t2, $s0  	# row
	addi	$t3, $s1, -1	# col - 1
	# check boundries	
	beq	$t3, $t7, bad_col4
	j	good_col4
bad_col4:
	addi	$t3, $a1, -1
good_col4:	
	# load value
	mul	$t4, $t3, $a1	
	add	$t4, $t4, $t2	# find index
	mul	$t4, $t4, OFFSET
	add	$t4, $t4, $a3	# add offset to main arr address
	
	lw	$t5, 0($t4)	# load neighbor
	beq	$t5, $zero, nbr5# if neighbor isnt dead, neighbors++
	addi	$s7, $s7, 1

# check nbr 5

nbr5:
	move	$t2, $s0  	# row
	addi	$t3, $s1, 1	# col + 1
	# check boundries
	beq	$t3, $a1, bad_col5
	j	good_col5
bad_col5:
	move	$t3, $zero
good_col5:	
	# load value
	mul	$t4, $t3, $a1	
	add	$t4, $t4, $t2	# find index
	mul	$t4, $t4, OFFSET
	add	$t4, $t4, $a3	# add offset to main arr address
	
	lw	$t5, 0($t4)	# load neighbor
	beq	$t5, $zero, nbr6# if neighbor isnt dead, neighbors++
	addi	$s7, $s7, 1

# check nbr 6

nbr6:
	addi	$t2, $s0, 1  	# row + 1
	addi	$t3, $s1, -1	# col - 1
	# check boundries
	beq	$t2, $a1, bad_row6
	j	good_row6	
bad_row6:
	move	$t2, $zero
good_row6:	
	beq	$t3, $t7, bad_col6
	j	good_col6
bad_col6:
	addi	$t3, $a1, -1
good_col6:	
	# load value
	mul	$t4, $t3, $a1	
	add	$t4, $t4, $t2	# find index
	mul	$t4, $t4, OFFSET
	add	$t4, $t4, $a3	# add offset to main arr address
	
	lw	$t5, 0($t4)	# load neighbor
	beq	$t5, $zero, nbr7# if neighbor isnt dead, neighbors++
	addi	$s7, $s7, 1

# check nbr 7

nbr7:
	addi	$t2, $s0, 1  	# row + 1
	move	$t3, $s1	# col
	# check boundries
	beq	$t2, $a1, bad_row7
	j	good_row7	
bad_row7:
	move	$t2, $zero
good_row7:	
	# load value
	mul	$t4, $t3, $a1	
	add	$t4, $t4, $t2	# find index
	mul	$t4, $t4, OFFSET
	add	$t4, $t4, $a3	# add offset to main arr address
	
	lw	$t5, 0($t4)	# load neighbor
	beq	$t5, $zero, nbr8# if neighbor isnt dead, neighbors++
	addi	$s7, $s7, 1

# check nbr 8

nbr8:
	addi	$t2, $s0, 1  	# row + 1
	addi	$t3, $s1, 1	# col + 1
	# check boundries
	beq	$t2, $a1, bad_row8
	j	good_row8
bad_row8:
	move	$t2, $zero
good_row8:	
	beq	$t3, $a1, bad_col8
	j	good_col8
bad_col8:
	move	$t3, $zero
good_col8:	
	# load value 1
	mul	$t4, $t3, $a1	
	add	$t4, $t4, $t2	# find index
	mul	$t4, $t4, OFFSET
	add	$t4, $t4, $a3	# add offset to main arr address
	
	lw	$t5, 0($t4)	# load neighbor
	beq	$t5, $zero, nbrs_done# if neighbor isnt dead, neighbors++
	addi	$s7, $s7, 1

nbrs_done:

	li	$t7, 3
	mul	$t1, $s3, OFFSET
	add	$t2, $t1, $a3	# cell in main arr
	add	$t3, $t1, $a2	# cell in temp arr
	lw	$s2, ($t2)
	beq	$s2, $zero, cell_is_dead	# check if cell is alive
	
	# else if not dead
	slti	$t1, $s7, 2
	bne	$t1, $zero, cell_dies
	slt	$t1, $t7, $s7
	bne	$t1, $zero, cell_dies
	j	cell_ages
		

cell_dies:			# nbrs < 2 or > 3, the cell dies
	j	skip_cell
cell_ages:
	addi	$s2, $s2, 1	# nbrs = 2 or 3 increase age of live cell by 1
	sw	$s2, 0($t3)
	j	skip_cell	
cell_is_dead:
	bne	$s7, $t7, skip_cell	# if nbrs = 3, create new, else skip
	li	$s2, A_ASCII
	sw	$s2, 0($t3)
		
skip_cell:		
	addi	$s3, $s3, 1	# move onto next cell
	j	itr_board
itr_done:
	jal	copy_array	# copy temp into main
	move	$t7, $a3	# change a3 to point to temp
	move	$a3, $a2	
	jal	reset_cells	# reset temp
	move	$a3, $t7	# change a3 back to main
	
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$s3, 12($sp)
	lw	$ra, 16($sp)
	addi	$sp, $sp, 20
	jr	$ra


# Name:		reset_cells
# Description:	Resets cell array to all dead cells. Used to reset the temp
#		array after updating the board and to reset the main array 
#		when needed.
# Arguments:    a3 - cell array address
# Returns:      none
# Destroys:     t0, t1
#
reset_cells: 
	li	$t0, 0			# index

reset_while:
	slti	$t1, $t0, ARRAY_SIZE
	beq	$t1, $zero, reset_done

	mul	$t1, $t0, OFFSET
	add	$t1, $t1, $a3
	sw	$zero, 0($t1) 		# store zero in each cell

	addi	$t0, $t0, 1
	j	reset_while
reset_done:	
	jr	$ra


# Name:		copy_array
# Description:	Copies the temporary array into the main array.
# Arguments:    a3 - cell array address
#		a2 - temp array adress		
# Returns:      none
# Destroys:     t0, t1, t2
#
copy_array:
	li	$t0, 0			# index	

copy_while:
	slti	$t1, $t0, ARRAY_SIZE
	beq	$t1, $zero, copy_done

	mul	$t1, $t0, OFFSET
	add	$t2, $a2, $t1		# temporary array
	add	$t3, $a3, $t1		# main array
	lw	$t4, 0($t2)		# load from temp
	sw	$t4, 0($t3)		# store into main
	
	addi	$t0, $t0, 1
	j	copy_while
copy_done:
	jr	$ra		


# Name:		print_t_and_b
# Description:	Prints the top and bottom border of the board.
# Arguments:    a1: The board size
# Returns:      none
# Destroys:	t0, t1, a0
#
print_t_and_b:	
	la	$a0, board_corner
		syscall
	li	$t0, 0			# index
print_top:
	slt	$t1, $t0, $a1
	beq	$t1, $zero, top_done
	la	$a0, board_line_h
		syscall			# print '-'
	addi	$t0, $t0, 1		# i++	
	j	print_top
top_done:
	la	$a0, board_corner
		syscall
	la	$a0, newline
		syscall

	jr	$ra





