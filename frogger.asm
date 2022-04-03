# Demo for painting
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# CSC258H5S Winter 2022 Assembly Final Project
# University of Toronto, St. George
#
# Student: Jaren Worme 1007302287
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1
.data
	displayAddress: .word 0x10008000
	
	# initialise arrays
	CAR_B: .space 512 # space for bottom row of cars
	CAR_T: .space 512 # space for top row of cars
	WATER_B: .space 512 # space for bottom row of logs
	WATER_T: .space 512 # space for top row of logs
.text
	lw $t0, displayAddress # $t0 stores the base address for display
	li $t1, 0xff0000 # $t1 stores the red colour code
	li $t2, 0x00ff00 # $t2 stores the green colour code
	li $t3, 0x0000ff # $t3 stores the blue colour code
	# sw $t1, 0($t0) # paint the first (top-left) unit red.
	# sw $t2, 4($t0) # paint the second unit on the first row green. Why $t0+4?
	# sw $t3, 128($t0) # paint the first unit on the second row blue. Why +128?
	
main:	
###########################
# fill arrays for road
##########################
	li $t2, 0x808080 # road color
	li $t3, 0xffffff # car color
	la $t6, CAR_T # $t6 holds address of array CAR_ T
	la $t7, CAR_B # $t7 holds address of array CAR_B
	
# car color loop
	add $t8, $zero, $zero # variable
	addi $t9, $zero, 127 # stop condition
START_CAR_COLOR1: 
	bge $t8, $t9, EXIT_CAR_COLOR1
	sll $t4, $t8, 2 # offset of 4
	add $t0, $t6, $t4
	add $t1, $t7, $t4
	
	sw $t3, 0($t0) # CAR_T[i] = car color
	sw $t3, 0($t1) # CAR_B[i] = car color
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t3, 0($t0) 
	sw $t3, 0($t1) 	
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t3, 0($t0) 
	sw $t3, 0($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t3, 0($t0) 
	sw $t3, 0($t1) 	
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t3, 0($t0) 
	sw $t3, 0($t1) 	
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t3, 0($t0) 
	sw $t3, 0($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t3, 0($t0) 
	sw $t3, 0($t1)
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t3, 0($t0) 
	sw $t3, 0($t1) 	
		
	sub $t1, $t1, 12
	sub $t0, $t0, 12
UPDATE_CAR_COLOR1:
	addi $t8, $t8, 16
	j START_CAR_COLOR1
EXIT_CAR_COLOR1:
	
# road color loop
	add $t8, $zero, $zero
	addi $t9, $zero, 127 # stop condition
START_ROAD_COLOR1: 
	bge $t8, $t9, EXIT_ROAD_COLOR1
	sll $t4, $t8, 2 # offset of 4
	add $t0, $t6, $t4
	add $t1, $t7, $t4
	sw $t2, 32($t0) # CAR_T[i] = road color
	sw $t2, 32($t1) # CAR_B[i] = road color	
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t2, 32($t0) 
	sw $t2, 32($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t2, 32($t0)
	sw $t2, 32($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t2, 32($t0) 
	sw $t2, 32($t1) 	
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t2, 32($t0) 
	sw $t2, 32($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t2, 32($t0)
	sw $t2, 32($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t2, 32($t0) 
	sw $t2, 32($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t2, 32($t0)
	sw $t2, 32($t1) 
	
	sub $t0, $t0, 12
	sub $t1, $t1, 12
UPDATE_ROAD_COLOR1:
	addi $t8, $t8, 16
	j START_ROAD_COLOR1
EXIT_ROAD_COLOR1:

##############################
# fill arrays for water
#############################

	li $t2, 0x804000 # log color
	li $t3, 0x0000ff # water color
	la $t6, WATER_T # $t6 holds address 
	la $t7, WATER_B # $t7 holds address 
	
# water color loop
	add $t8, $zero, $zero # variable
	addi $t9, $zero, 127 # stop condition
START_WATER_COLOR1: 
	bge $t8, $t9, EXIT_WATER_COLOR1
	sll $t4, $t8, 2 # offset of 4
	add $t0, $t6, $t4
	add $t1, $t7, $t4
	
	sw $t3, 0($t0) 
	sw $t3, 0($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t3, 0($t0) 
	sw $t3, 0($t1) 	
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t3, 0($t0) 
	sw $t3, 0($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t3, 0($t0) 
	sw $t3, 0($t1) 	
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t3, 0($t0) 
	sw $t3, 0($t1) 	
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t3, 0($t0) 
	sw $t3, 0($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t3, 0($t0) 
	sw $t3, 0($t1)
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t3, 0($t0) 
	sw $t3, 0($t1) 	
		
	sub $t1, $t1, 12
	sub $t0, $t0, 12
UPDATE_WATER_COLOR1:
	addi $t8, $t8, 16
	j START_WATER_COLOR1
EXIT_WATER_COLOR1:
	
# log color loop
	add $t8, $zero, $zero
	addi $t9, $zero, 127 # stop condition
START_LOG_COLOR1: 
	bge $t8, $t9, EXIT_LOG_COLOR1
	sll $t4, $t8, 2 # offset of 4
	add $t0, $t6, $t4
	add $t1, $t7, $t4
	sw $t2, 32($t0) 
	sw $t2, 32($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t2, 32($t0) 
	sw $t2, 32($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t2, 32($t0)
	sw $t2, 32($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t2, 32($t0) 
	sw $t2, 32($t1) 	
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t2, 32($t0) 
	sw $t2, 32($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t2, 32($t0)
	sw $t2, 32($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t2, 32($t0) 
	sw $t2, 32($t1) 
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	sw $t2, 32($t0)
	sw $t2, 32($t1) 
	
	sub $t0, $t0, 12
	sub $t1, $t1, 12
UPDATE_LOG_COLOR1:
	addi $t8, $t8, 16
	j START_LOG_COLOR1
EXIT_LOG_COLOR1:

##############################
#draw screen default
############################
	lw $t0, displayAddress
	li $t2, 0x00ff00
	add $t8, $zero, $zero
	addi $t9, $zero, 1024
START_DRAW_END: 
	beq $t8, $t9, EXIT_DRAW_END
	sw $t2, ($t0)
	addi $t0, $t0, 4 
UPDATE_DRAW_END:
	addi $t8, $t8, 4
	j START_DRAW_END
EXIT_DRAW_END:
	
	li $t2, 0x0000ff
	addi $t8, $zero, 1024
	addi $t9, $zero, 2048
START_DRAW_LAKE: 
	beq $t8, $t9, EXIT_DRAW_LAKE	
	sw $t2, ($t0)
	addi $t0, $t0, 4 
UPDATE_DRAW_LAKE:
	addi $t8, $t8, 4
	j START_DRAW_LAKE
EXIT_DRAW_LAKE:
	
	li $t2, 0x00ff00
	addi $t8, $zero, 2048
	addi $t9, $zero, 2560
START_DRAW_SAFE: 
	beq $t8, $t9, EXIT_DRAW_SAFE
	sw $t2, ($t0)
	addi $t0, $t0, 4 
UPDATE_DRAW_SAFE:
	addi $t8, $t8, 4
	j START_DRAW_SAFE
EXIT_DRAW_SAFE:

	li $t2, 0x808080
	addi $t8, $zero, 2560
	addi $t9, $zero, 3584
START_DRAW_ROAD: 
	beq $t8, $t9, EXIT_DRAW_ROAD
	sw $t2, ($t0)
	addi $t0, $t0, 4 
UPDATE_DRAW_ROAD:
	addi $t8, $t8, 4
	j START_DRAW_ROAD
EXIT_DRAW_ROAD:

	li $t2, 0x00ff00
	addi $t8, $zero, 3584
	addi $t9, $zero, 4096
START_DRAW_START: 
	beq $t8, $t9, EXIT_DRAW_START
	sw $t2, ($t0)
	addi $t0, $t0, 4 
UPDATE_DRAW_START:
	addi $t8, $t8, 4
	j START_DRAW_START
EXIT_DRAW_START:

# done initialising board










#reset coordinante in $t0 to top left

	lw $t0, displayAddress
	li $t2, 0xff7f50
	addi $t0, $t0, 3640
	sw $t2, ($t0)

#####################
# draw frog
#####################
DRAW_FROG:
	# frog color
	li $t2, 0xff7f50
	
	# draw frog by updating certain coordinates given the current value of coordinate $t0
	sw $t2, ($t0)
	addi $t0, $t0, 12
	sw $t2, ($t0)
	addi $t0, $t0, 116
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 120
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 120
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	
###############################
# display road arrays
###############################
	
	lw $t0, displayAddress
	addi $t8, $zero, 2560
	addi $t9, $zero, 2688
	la $t6, CAR_T # $t6 holds address of array CAR_ T
	la $t7, CAR_B # $t7 holds address of array CAR_B
	add $t0, $t0, $t8	
		
START_DRAW_ROADA: 
	beq $t8, $t9, EXIT_DRAW_ROADA
	sub $t2, $t8, 2560
	sll $t4, $t2, 2 # offset of 4
	add $t1, $t6, $t4
	lw $t5, ($t1)
	sw $t5, ($t0)
			
	addi $t0, $t0, 4 
UPDATE_DRAW_ROADA:
	addi $t8, $t8, 1
	j START_DRAW_ROADA
EXIT_DRAW_ROADA:

	lw $t0, displayAddress
	addi $t8, $zero, 3072
	addi $t9, $zero, 3200
	la $t6, CAR_T # $t6 holds address of array CAR_ T
	la $t7, CAR_B # $t7 holds address of array CAR_B
	add $t0, $t0, $t8	
	
START_DRAW_ROADb: 
	beq $t8, $t9, EXIT_DRAW_ROADb
	sub $t2, $t8, 3072
	sll $t4, $t2, 2 # offset of 4
	add $t1, $t7, $t4
	
	lw $t5, ($t1)
	sw $t5, ($t0)
		
	addi $t0, $t0, 4 
UPDATE_DRAW_ROADb:
	addi $t8, $t8, 1
	j START_DRAW_ROADb
EXIT_DRAW_ROADb:
	
#####################
# display water array
#####################

	lw $t0, displayAddress
	addi $t8, $zero, 1024
	addi $t9, $zero, 1152
	la $t6, WATER_T # $t6 holds address 
	la $t7, WATER_B # $t7 holds address 
	add $t0, $t0, $t8	
		
START_DRAW_WATERA: 
	beq $t8, $t9, EXIT_DRAW_WATERA
	sub $t2, $t8, 1024
	sll $t4, $t2, 2 # offset of 4
	add $t1, $t6, $t4
	lw $t5, ($t1)
	sw $t5, ($t0)
	
	addi $t0, $t0, 4 
UPDATE_DRAW_WATERA:
	addi $t8, $t8, 1
	j START_DRAW_WATERA
EXIT_DRAW_WATERA:

	lw $t0, displayAddress
	addi $t8, $zero, 1536
	addi $t9, $zero, 1664
	la $t6, WATER_T # $t6 holds address of
	la $t7, WATER_B # $t7 holds address of
	add $t0, $t0, $t8	
	
START_DRAW_WATERB: 
	beq $t8, $t9, EXIT_DRAW_WATERB
	sub $t2, $t8, 1536
	sll $t4, $t2, 2 # offset of 4
	add $t1, $t7, $t4
	
	lw $t5, ($t1)
	sw $t5, ($t0)
	
	
	addi $t0, $t0, 4 
UPDATE_DRAW_WATER:
	addi $t8, $t8, 1
	j START_DRAW_WATERB
EXIT_DRAW_WATERB:
	
	
li $v0, 32
li $a0, 10000
syscall
j EXIT_LOG_COLOR1


	

	
	li $v0, 10 # terminate the program gracefully
	syscall
