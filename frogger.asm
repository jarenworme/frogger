############################################################################
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
#
# features: displays lives remaining
#	    game over screen with retry or quit options
#	    death animation when the frog loses a life
#	    have objects in different rows move at different speeds.
#	    make frog point in the direction it is travelling
# 	    displays score (pts) on the top of the screen	
#
# gameplay notes/comments:
#	game set up so thatfrog dies after three collisions, but wins if he reaches the goal 5 times
#	points are displayed as white pixels that appear every time the frog reaches the goal
#	the three differently colored pixels next to "LIFE" are the three lives displayed
#       white rectangles are cars on road, brown rectangles are logs on water
.data
	displayAddress: .word 0x10008000
	
	frog_loc: .word	50 # location of top left frog pixel
	frog_dir: .word 119 # 119 being 'w', frog direction starts up
	
	life_count: .word 50
	pts_count: .word 50
	
	# initialise arrays
	CAR_B: .space 512 # space for bottom row of cars
	CAR_T: .space 512 # space for top row of cars
	WATER_B: .space 512 # space for bottom row of logs
	WATER_T: .space 512 # space for top row of logs
.text
main:
########################################
# set life and points values in memory
########################################
	lw $t0, displayAddress
	addi $t1, $t0, 172
	sw $t1, life_count
	
	addi $t1, $t0, 236
	sw $t1, pts_count
	
	
###############################
# fill initial arrays for road
##############################
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

################################
# fill initial arrays for water
###############################

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

level:
#########################
# draw screen default
#########################
	lw $t0, displayAddress
	jal drawstats
	jal drawend
	jal drawwaterarr
	jal drawsafe
	jal drawroadarr
	jal drawstart
	
	# set pixels for lives
	li $t2, 0x000000
	li $t1, 0xff0000
	li $t3, 0xffffff
	li $t4, 0xff80ff
	li $t5, 0x8080ff
	lw $t0, displayAddress
	sw $t3, 172($t0)
	sw $t4, 176($t0)
	sw $t5, 180($t0)
	sw $t2, 236($t0)
	sw $t2, 240($t0)
	sw $t2, 244($t0)
	sw $t2, 248($t0)
	
	# set initial location for frog
	lw $t0, displayAddress
	addi $t0, $t0, 3640
	sw $t0, frog_loc
	
	jal drawfrog
	

# done initialising screen


##########################
# Start game loop
##########################
gameloop:
	
	# get value of key pressed
	lw $t3, 0xffff0004
	
	# determine which keyboard press is made
	beq	$t3, 100, rightmove	# if key press = 'd' branch to moveright
	beq	$t3, 97, leftmove	# else if key press = 'a' branch to moveLeft
	beq	$t3, 119, upmove	# if key press = 'w' branch to moveUp
	beq	$t3, 115, downmove	# else if key press = 's' branch to moveDown
	
	j turnphase2
	
rightmove:
	# read frog coordinate
	lw $t0, frog_loc
	sw $t3, frog_dir
	
	# use coordinate to draw over background
	jal determine_loc_to_redraw
	
	lw $t0, frog_loc
	# add 16 to frog coordinate
	addi $t0, $t0, 16
	sw $t0, frog_loc
	# draw frog to new coordinate
	jal drawfrogd
	
	j turnphase2
	
leftmove:
	# read frog coordinate
	lw $t0, frog_loc
	sw $t3, frog_dir
	
	# use coordinate to draw over background
	jal determine_loc_to_redraw
	
	lw $t0, frog_loc
 	# subtract 16 to frog coordinae
 	sub $t0, $t0, 16
 	sw $t0, frog_loc
 	# draw frog to new coordinate
 	jal drawfroga	
 	
 	j turnphase2

downmove:
	# read frog coordinate
	lw $t0, frog_loc
	sw $t3, frog_dir
	
	# use coordinate to draw over background
	jal determine_loc_to_redraw
	
	lw $t0, frog_loc
	# add 512 to frog coordinate
	addi $t0, $t0, 512
	sw $t0, frog_loc
	# draw frog to new coordinate
	jal drawfrogs
	
	j turnphase2


upmove:
	# read frog coordinate
	lw $t0, frog_loc
	sw $t3, frog_dir
	
	# use coordinate to draw over background
	jal determine_loc_to_redraw
	
	lw $t0, frog_loc
	# subtract 512 to frog coordinate
	sub $t0, $t0, 512
 	sw $t0, frog_loc
	# draw frog to new coordinate
	jal drawfrog
	
	j turnphase2

turnphase2: 

######################################################################
# check for keyboard input and redraw screen as is if no key pressed
######################################################################

	# if ready bit is 0, repeat phase 2. If not, then it means it's
	# received another input and we go back to gameloop
	lw $t9, 0xffff0000
	beq $t9, 1, backtoloop
	
	# update location of logs etc(change array)
	
	
	# redraw screen and frog in curr location
	lw $t0, displayAddress
	jal drawstats
	jal drawend
	jal shiftwaterb
	jal shiftwaterb #s hift twice to get water b twice the speed of t
	jal shiftwatert
	jal drawwaterarr
	jal drawsafe
	jal shiftcart
	jal shiftcart
	jal shiftcarb
	jal drawroadarr
	jal drawstart
	lw $t0, frog_loc
	jal drawfrog_choose
	
	
	jal checkwin
	# sleep call
	li $v0, 32
	li $a0, 66
	syscall
	
	
	j turnphase2 # back to top of phase 2
	
backtoloop:
	
	j gameloop

###################
# end of non-function code
################### 

back_to:
	lw 	$ra, 0($sp)	# load caller's return address
	##lw 	$fp, 0($sp)	# restores caller's frame pointer
	addi 	$sp, $sp, 4	# restores caller's stack pointer
	jr 	$ra

determine_loc_to_redraw:#to erase frog, this one is section redraw_end implicitly
	
	addiu 	$sp, $sp, -4	# allocate 4 bytes for stack because the stack grows towards memory location 0 WOWWWWWW
	sw 	$ra, 0($sp)	# store caller's return address
	##addi 	$fp, $sp, 20	# setup updateSnake frame pointer
	# address already in $t0
	#load first address to $t8
	lw $t8, displayAddress
	#coordinate stored in $t9
	sub $t7, $t0, $t8
	addi $t5, $zero, 4096
	sub $t9, $t5, $t7
	bge $t9, 1024, redraw_water
	
	jal drawend
	
	j back_to
	
	
	redraw_water:
	bge $t9, 2048, redraw_safe
	
	jal drawwaterarr
	
	j back_to
	
	
	redraw_safe:
	bge $t9, 2560, redraw_road
	
	jal drawsafe
	
	j back_to
	
	redraw_road:
	bge $t9, 3584, redraw_start
	
	jal drawroadarr
	
	j back_to
	
	redraw_start:
	jal drawstart
	
	j back_to
		


#############################################
# determine which drawfrog function to go to
#############################################
drawfrog_choose:
	lw $t3, frog_dir
	addi $t4, $zero, 100
	beq $t4, $t3, drawfrogd 
	addi $t4, $zero, 97
	beq $t4, $t3, drawfroga
	addi $t4, $zero, 119
	beq $t4, $t3, drawfrog
	addi $t4, $zero, 115
	beq $t4, $t3, drawfrogs




##########################
# draw frog 'w' (default)
##########################
drawfrog:
	# frog color
	li $t2, 0xff7f50
	lw $t0, frog_loc 
		
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
	
	jr $ra
	
################
# draw frog 'd'
################
drawfrogd:
	# frog color
	li $t2, 0xff7f50
	lw $t0, frog_loc 
		
	# draw frog by updating certain coordinates given the current value of coordinate $t0
	sw $t2, ($t0)
	addi $t0, $t0, 8
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 116
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 120
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 120
	sw $t2, ($t0)
	addi $t0, $t0, 8
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
		
	jr $ra
	
################
# draw frog 'a'
################
drawfroga:
	# frog color
	li $t2, 0xff7f50
	lw $t0, frog_loc 
		
	# draw frog by updating certain coordinates given the current value of coordinate $t0
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 8
	sw $t2, ($t0)
	addi $t0, $t0, 120
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 120
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 116
	sw $t2, ($t0)
	addi $t0, $t0, 4
	sw $t2, ($t0)
	addi $t0, $t0, 8
	sw $t2, ($t0)
		
	jr $ra
	
###############
# draw frog s
##############
drawfrogs:
	# frog color
	li $t2, 0xff7f50
	lw $t0, frog_loc 
		
	# draw frog by updating certain coordinates given the current value of coordinate $t0
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
	addi $t0, $t0, 116
	sw $t2, ($t0)
	addi $t0, $t0, 12
	sw $t2, ($t0)
	
	jr $ra
	
	
	
###############################
# display road arrays
###############################
drawroadarr:

	addiu $sp, $sp, -4 # allocate 4 bytes for stack 
	sw $ra, 0($sp)	# store caller's return address
	lw $t0, displayAddress
	addi $t8, $zero, 2560
	addi $t9, $zero, 2688
	la $t6, CAR_T # $t6 holds address of array CAR_ T
	la $t7, CAR_B # $t7 holds address of array CAR_B
	add $t0, $t0, $t8	
	lw $t3, frog_loc #load frog location to $t3
		
START_DRAW_ROADA: 
	beq $t8, $t9, EXIT_DRAW_ROADA
	sub $t2, $t8, 2560
	sll $t4, $t2, 2 # offset of 4
	add $t1, $t6, $t4
	lw $t5, ($t1)
	sw $t5, ($t0)
	
	# check if the frog's locationis the same as the current location
	jal checkfrogcdr
					
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
	
	jal checkfrogcdr
		
	addi $t0, $t0, 4 
UPDATE_DRAW_ROADb:
	addi $t8, $t8, 1
	j START_DRAW_ROADb
EXIT_DRAW_ROADb:

	lw 	$ra, 0($sp)	# load caller's return address
	##lw 	$fp, 0($sp)	# restores caller's frame pointer
	addi 	$sp, $sp, 4	# restores caller's stack pointer
	jr 	$ra
	
#####################
# display water array
#####################
drawwaterarr:

	addiu $sp, $sp, -4	# allocate 4 bytes for stack because the stack grows towards memory location 0 WOWWWWWW
	sw $ra, 0($sp)	# store caller's return address
	lw $t0, displayAddress
	addi $t8, $zero, 1024
	addi $t9, $zero, 1152
	la $t6, WATER_T # $t6 holds address 
	la $t7, WATER_B # $t7 holds address 
	add $t0, $t0, $t8	
	lw $t3, frog_loc #load frog location to $t3
	
		
START_DRAW_WATERA: 
	beq $t8, $t9, EXIT_DRAW_WATERA
	sub $t2, $t8, 1024
	sll $t4, $t2, 2 # offset of 4
	add $t1, $t6, $t4
	lw $t5, ($t1)
	sw $t5, ($t0)
	
	jal checkfrogcdw
	
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
	
	jal checkfrogcdw
	
	addi $t0, $t0, 4 
UPDATE_DRAW_WATER:
	addi $t8, $t8, 1
	j START_DRAW_WATERB
EXIT_DRAW_WATERB:

	lw 	$ra, 0($sp)	# load caller's return address
	##lw 	$fp, 0($sp)	# restores caller's frame pointer
	addi 	$sp, $sp, 4	# restores caller's stack pointer
	jr 	$ra
	
################
drawend:
	li $t2, 0x00ff00
	addi $t8, $zero, 512
	addi $t9, $zero, 1024
	lw $t6, displayAddress
	add $t0, $t6, $t8
START_DRAW_END: 
	beq $t8, $t9, EXIT_DRAW_END
	sw $t2, ($t0)
	addi $t0, $t0, 4 
UPDATE_DRAW_END:
	addi $t8, $t8, 4
	j START_DRAW_END
EXIT_DRAW_END:

	jr 	$ra
##################
drawlake:	# not used
	li $t2, 0x0000ff
	addi $t8, $zero, 1024
	addi $t9, $zero, 2048
	lw $t6, displayAddress
	add $t0, $t6, $t8
	
START_DRAW_LAKE: 
	beq $t8, $t9, EXIT_DRAW_LAKE	
	sw $t2, ($t0)
	addi $t0, $t0, 4 
UPDATE_DRAW_LAKE:
	addi $t8, $t8, 4
	j START_DRAW_LAKE
EXIT_DRAW_LAKE:

	jr 	$ra
################
drawsafe:
	li $t2, 0x00ff00
	addi $t8, $zero, 2048
	addi $t9, $zero, 2560
	lw $t6, displayAddress
	add $t0, $t6, $t8
START_DRAW_SAFE: 
	beq $t8, $t9, EXIT_DRAW_SAFE
	sw $t2, ($t0)
	addi $t0, $t0, 4 
UPDATE_DRAW_SAFE:
	addi $t8, $t8, 4
	j START_DRAW_SAFE
EXIT_DRAW_SAFE:

	jr 	$ra

############
drawroad:	# not used
	li $t2, 0x808080
	addi $t8, $zero, 2560
	addi $t9, $zero, 3584
	lw $t6, displayAddress
	add $t0, $t6, $t8
START_DRAW_ROAD: 
	beq $t8, $t9, EXIT_DRAW_ROAD
	sw $t2, ($t0)
	addi $t0, $t0, 4 
UPDATE_DRAW_ROAD:
	addi $t8, $t8, 4
	j START_DRAW_ROAD
EXIT_DRAW_ROAD:

	jr 	$ra

#################
drawstart:
	li $t2, 0x00ff00
	addi $t8, $zero, 3584
	addi $t9, $zero, 4096
	lw $t6, displayAddress
	add $t0, $t6, $t8
START_DRAW_START: 
	beq $t8, $t9, EXIT_DRAW_START
	sw $t2, ($t0)
	addi $t0, $t0, 4 
UPDATE_DRAW_START:
	addi $t8, $t8, 4
	j START_DRAW_START
EXIT_DRAW_START:

	jr 	$ra
	
#####################
# shift road arrays
####################
shiftcart:
	#set values
	la $t0, CAR_T # $t0 holds address of 
	add $t8, $zero, $zero # i
	addi $t9, $zero, 127 # end val
	## get first address element
	sll $t1, $t8, 2 # offset
	add $t2, $t1, $t0 # address of i
	lw $t6, ($t2) # arr[i]
START_SHIFTCART:
	beq $t8, $t9, EXIT_SHIFTCART
	sll $t1, $t8, 2 # offset
	add $t2, $t1, $t0 # address of i
	addi $t3, $t2, 4 # add 4 to address i to get  address[i+1] to hold so it wont get overwritten
	
	lw $t7, ($t3) #arr[i+1]
	
	sw $t6, ($t3) # set arr[i+1] to i's value
	add $t6, $zero, $t7

UPDATE_SHIFTCART:
	addi $t8, $t8, 1
	j START_SHIFTCART
EXIT_SHIFTCART:
	sw $t6 ($t0) # wrap around
	jr $ra
	
#############
shiftcarb:
	#set values
	la $t0, CAR_B # $t0 holds address of 
	add $t8, $zero, $zero # i
	addi $t9, $zero, 127 # end val
	## get first address element
	sll $t1, $t8, 2 # offset
	add $t2, $t1, $t0 # address of i
	lw $t6, ($t2) # arr[i]
START_SHIFTCARB:
	beq $t8, $t9, EXIT_SHIFTCARB
	sll $t1, $t8, 2 # offset
	add $t2, $t1, $t0 # address of i
	addi $t3, $t2, 4 # add 4 to address i to get  address[i+1] to hold so it wont get overwritten
	
	lw $t7, ($t3) #arr[i+1]
	
	sw $t6, ($t3) 
	add $t6, $zero, $t7

UPDATE_SHIFTCARB:
	addi $t8, $t8, 1
	j START_SHIFTCARB
EXIT_SHIFTCARB:
	sw $t6 ($t0) # wrap around
	jr $ra
	
#########################
# shift water arrays
#########################
shiftwatert:
	#set values
	la $t0, WATER_T # $t0 holds address of 
	add $t8, $zero, $zero # i
	addi $t9, $zero, 127 # end val
	## get first address element
	sll $t1, $t8, 2 # offset
	add $t2, $t1, $t0 # address of i
	lw $t6, ($t2) # arr[i]
START_SHIFTWATERT:
	beq $t8, $t9, EXIT_SHIFTWATERT
	sll $t1, $t8, 2 # offset
	add $t2, $t1, $t0 # address of i
	addi $t3, $t2, 4 # add 4 to address i to get  address[i+1] to hold so it wont get overwritten
	
	lw $t7, ($t3) #arr[i+1]
	
	sw $t6, ($t3) # set arr[i+1] to i's value
	add $t6, $zero, $t7

UPDATE_SHIFTWATERT:
	addi $t8, $t8, 1
	j START_SHIFTWATERT
EXIT_SHIFTWATERT:
	sw $t6 ($t0) # wrap around
	jr $ra
	
##############
shiftwaterb:
	#set values
	la $t0, WATER_B # $t0 holds address of 
	add $t8, $zero, $zero # i
	addi $t9, $zero, 127 # end val
	## get first address element
	sll $t1, $t8, 2 # offset
	add $t2, $t1, $t0 # address of i
	lw $t6, ($t2) # arr[i]
START_SHIFTWATERB:
	beq $t8, $t9, EXIT_SHIFTWATERB
	sll $t1, $t8, 2 # offset
	add $t2, $t1, $t0 # address of i
	addi $t3, $t2, 4 # add 4 to address i to get  address[i+1] to hold so it wont get overwritten
	
	lw $t7, ($t3) #arr[i+1]
	
	sw $t6, ($t3) # set arr[i+1] to i's value
	add $t6, $zero, $t7

UPDATE_SHIFTWATERB:
	addi $t8, $t8, 1
	j START_SHIFTWATERB
EXIT_SHIFTWATERB:
	sw $t6 ($t0) # wrap around
	jr $ra

	
##############################################
# check frog location for collision detection
#############################################
	
checkfrogcdr:
	li $t4, 0xffffff # store car color to compare for collision detection
	# from before, $t5 stores color from array
	beq $t4, $t5, checkfrogcdrloc # go to froghit if colors match, else go back to loop
	
	jr $ra
	
checkfrogcdrloc:
	# $t3 is already the location of the frog from the function
	# $t0 is the curr location
	beq $t3, $t0, froghit
	
	jr $ra
	
checkfrogcdw:
	li $t4, 0x0000ff # store car color to compare for collision detection
	# from before, $t5 stores color from array
	beq $t4, $t5, checkfrogcdrloc # go to froghit if colors match, else go back to loop
	
	jr $ra
	
checkfrogcdwloc:
	# $t3 is already the location of the frog from the function
	# $t0 is the curr location
	beq $t3, $t0, froghit
	
	jr $ra
	
	
##########################################
# check to see if frog is in safe zone
##########################################
checkwin:
	#addiu $sp, $sp, -4 # allocate 4 bytes for stack 
	#sw $ra, 0($sp)	# store caller's return address
	lw $t9, frog_loc
	lw $t0, displayAddress
	sub $t8, $t9, $t0
	blt $t8, 1028, frogatend # collission detection for end goal
	#lw $ra, 0($sp)	# load caller's return address
	#addi $sp, $sp, 4	# restores caller's stack pointer
	
	jr $ra
	
####################################################
# frog reaches other side, go back to loop
####################################################
frogatend:
	lw $t0, displayAddress
	jal drawend
	jal drawwaterarr
	jal drawsafe
	jal drawroadarr
	jal drawstart
	
	# add one point
	lw $t1, pts_count
	li $t2, 0xffffff
	sw $t2, ($t1)
	addi $t1, $t1, 4
	sw $t1, pts_count
	lw $t0, displayAddress
	addi $t9, $t0, 256
	beq $t9, $t1, gamewin
	
	
	lw $t0, displayAddress
	addi $t0, $t0, 3640
	sw $t0, frog_loc
	
	jal drawfrog
		
	j turnphase2
	
####################################################
# frog dies, go back to loop
####################################################
froghit:
	lw $t0, displayAddress
	jal drawend
	#jal drawwaterarr
	jal drawsafe
	#jal drawroadarr
	jal drawstart
	
	lw $t1, life_count
	li $t2, 0x000000
	sw $t2, ($t1)
	addi $t1, $t1, 4
	sw $t1, life_count
	
# animation when frog gets hit: print screen black then white twice
	li $t2, 0xffffff
	lw $t0, displayAddress
	add $t8, $zero, $zero
	addi $t9, $zero, 4096
START_ANI_W1: 
	beq $t8, $t9, EXIT_ANI_W1
	sw $t2, 512($t0)
	addi $t0, $t0, 4 
UPDATE_ANI_W1:
	addi $t8, $t8, 4
	j START_ANI_W1
EXIT_ANI_W1:
	
	# sleep call
	li $v0, 32
	li $a0, 100
	syscall

	li $t2, 0x000000
	lw $t0, displayAddress
	add $t8, $zero, $zero
	addi $t9, $zero, 4096
START_ANI_B1: 
	beq $t8, $t9, EXIT_ANI_B1
	sw $t2, 512($t0)
	addi $t0, $t0, 4 
UPDATE_ANI_B1:
	addi $t8, $t8, 4
	j START_ANI_B1
EXIT_ANI_B1:

	# sleep call
	li $v0, 32
	li $a0, 100
	syscall
	
	li $t2, 0xffffff
	lw $t0, displayAddress
	add $t8, $zero, $zero
	addi $t9, $zero, 4096
START_ANI_W2: 
	beq $t8, $t9, EXIT_ANI_W2
	sw $t2, 512($t0)
	addi $t0, $t0, 4 
UPDATE_ANI_W2:
	addi $t8, $t8, 4
	j START_ANI_W2
EXIT_ANI_W2:

	# sleep call
	li $v0, 32
	li $a0, 100
	syscall

	li $t2, 0x000000
	lw $t0, displayAddress
	add $t8, $zero, $zero
	addi $t9, $zero, 4096
START_ANI_B2: 
	beq $t8, $t9, EXIT_ANI_B2
	sw $t2, 512($t0)
	addi $t0, $t0, 4 
UPDATE_ANI_B2:
	addi $t8, $t8, 4
	j START_ANI_B2
EXIT_ANI_B2:

	# sleep call
	li $v0, 32
	li $a0, 100
	syscall
	
	# check no lives left
	lw $t0, displayAddress
	addi $t9, $t0, 184
	beq $t1, $t9, gameover
	
	lw $t0, displayAddress
	addi $t0, $t0, 3640
	sw $t0, frog_loc
	
	jal drawfrog
	
	j turnphase2
	
	
###################################
# draw top bar to display stats
###################################
drawstats:
	li $t2, 0x000000
	li $t1, 0xff0000
	li $t3, 0xffffff
	li $t4, 0xff80ff
	li $t5, 0x8080ff
	lw $t0, displayAddress
	
	sw $t1, 0($t0)
	sw $t2, 4($t0)
	sw $t2, 8($t0)
	sw $t1, 12($t0)
	sw $t2, 16($t0)
	sw $t1, 20($t0)
	sw $t1, 24($t0)
	sw $t2, 28($t0)
	sw $t1, 32($t0)
	sw $t1, 36($t0)
	sw $t2, 40($t0)
	sw $t2, 44($t0)
	sw $t2, 48($t0)
	sw $t2, 52($t0)
	sw $t2, 56($t0)
	sw $t1, 60($t0)
	sw $t1, 64($t0)
	sw $t1, 68($t0)
	sw $t2, 72($t0)
	sw $t1, 76($t0)
	sw $t1, 80($t0)
	sw $t1, 84($t0)
	sw $t2, 88($t0)
	sw $t1, 92($t0)
	sw $t1, 96($t0)
	sw $t1, 100($t0)
	sw $t2, 104($t0)
	sw $t2, 108($t0)
	sw $t2, 112($t0)
	sw $t2, 116($t0)
	sw $t2, 120($t0)
	sw $t2, 124($t0)
	sw $t1, 128($t0)
	sw $t2, 132($t0)
	sw $t2, 136($t0)
	sw $t1, 140($t0)
	sw $t2, 144($t0)
	sw $t1, 148($t0)
	sw $t2, 152($t0)
	sw $t2, 156($t0)
	sw $t1, 160($t0)
	sw $t1, 164($t0)
	sw $t2, 168($t0)
	
	sw $t2, 184($t0)
	sw $t1, 188($t0)
	sw $t2, 192($t0)
	sw $t1, 196($t0)
	sw $t2, 200($t0)
	sw $t2, 204($t0)
	sw $t1, 208($t0)
	sw $t2, 212($t0)
	sw $t2, 216($t0)
	sw $t1, 220($t0)
	sw $t2, 224($t0)
	sw $t2, 228($t0)
	sw $t2, 232($t0)
	
	sw $t2, 252($t0)
	sw $t1, 256($t0)
	sw $t2, 260($t0)
	sw $t2, 264($t0)
	sw $t1, 268($t0)
	sw $t2, 272($t0)
	sw $t1, 276($t0)
	sw $t1, 280($t0)
	sw $t2, 284($t0)
	sw $t1, 288($t0)
	sw $t2, 292($t0)
	sw $t2, 296($t0)
	sw $t2, 300($t0)
	sw $t2, 304($t0)
	sw $t2, 308($t0)
	sw $t2, 312($t0)
	sw $t1, 316($t0)
	sw $t1, 320($t0)
	sw $t1, 324($t0)
	sw $t2, 328($t0)
	sw $t2, 332($t0)
	sw $t1, 336($t0)
	sw $t2, 340($t0)
	sw $t2, 344($t0)
	sw $t2, 348($t0)
	sw $t1, 352($t0)
	sw $t1, 356($t0)
	sw $t2, 360($t0)
	sw $t2, 364($t0)
	sw $t2, 368($t0)
	sw $t2, 372($t0)
	sw $t2, 376($t0)
	sw $t2, 380($t0)
	sw $t1, 384($t0)
	sw $t1, 388($t0)
	sw $t2, 392($t0)
	sw $t1, 396($t0)
	sw $t2, 400($t0)
	sw $t1, 404($t0)
	sw $t2, 408($t0)
	sw $t2, 412($t0)
	sw $t1, 416($t0)
	sw $t1, 420($t0)
	sw $t2, 424($t0)
	sw $t2, 428($t0)
	sw $t2, 432($t0)
	sw $t2, 436($t0)
	sw $t2, 440($t0)
	sw $t1, 444($t0)
	sw $t2, 448($t0)
	sw $t2, 452($t0)
	sw $t2, 456($t0)
	sw $t2, 460($t0)
	sw $t1, 464($t0)
	sw $t2, 468($t0)
	sw $t2, 472($t0)
	sw $t1, 476($t0)
	sw $t1, 480($t0)
	sw $t1, 484($t0)
	sw $t2, 488($t0)
	sw $t2, 492($t0)
	sw $t2, 496($t0)
	sw $t2, 500($t0)
	sw $t2, 504($t0)
	sw $t2, 508($t0)
	
	
	jr $ra

#####################################################
# game over: print screen white and display options
# if key press is A, restart. if D, end
#####################################################

# first print the whole screen white
gameover:
	li $t2, 0xffffff
	lw $t0, displayAddress
	add $t8, $zero, $zero
	addi $t9, $zero, 4096
START_DRAW_GAME_OVER: 
	beq $t8, $t9, EXIT_DRAW_GAME_OVER
	sw $t2, ($t0)
	
	addi $t0, $t0, 4 
UPDATE_DRAW_GAME_OVER:
	addi $t8, $t8, 4
	j START_DRAW_GAME_OVER
EXIT_DRAW_GAME_OVER:

# then print custom info

	# first 'fin'
	li $t2, 0xff0000
	lw $t0, displayAddress
	addi $t1, $zero, 512
	add $t3, $t0, $t1
	
	sw $t2, 48($t3)
	sw $t2, 172($t3)
	sw $t2, 180($t3)
	sw $t2, 188($t3)
	sw $t2, 300($t3)
	sw $t2, 324($t3)
	sw $t2, 328($t3)
	sw $t2, 424($t3)
	sw $t2, 428($t3)
	sw $t2, 432($t3)
	sw $t2, 444($t3)
	sw $t2, 452($t3)
	sw $t2, 460($t3)
	sw $t2, 556($t3)
	sw $t2, 572($t3)
	sw $t2, 580($t3)
	sw $t2, 588($t3)
	
	# lines
	# top
	li $t2, 0x000000
	lw $t0, displayAddress
	
	sw $t2, 0($t0)
	sw $t2, 4($t0)
	sw $t2, 8($t0)
	sw $t2, 12($t0)
	sw $t2, 16($t0)
	sw $t2, 20($t0)
	sw $t2, 24($t0)
	sw $t2, 28($t0)
	sw $t2, 32($t0)
	sw $t2, 36($t0)
	sw $t2, 40($t0)
	sw $t2, 44($t0)
	sw $t2, 48($t0)
	sw $t2, 52($t0)
	sw $t2, 56($t0)
	sw $t2, 60($t0)
	sw $t2, 64($t0)
	sw $t2, 68($t0)
	sw $t2, 72($t0)
	sw $t2, 76($t0)
	sw $t2, 80($t0)
	sw $t2, 84($t0)
	sw $t2, 88($t0)
	sw $t2, 92($t0)
	sw $t2, 96($t0)
	sw $t2, 100($t0)
	sw $t2, 104($t0)
	sw $t2, 108($t0)
	sw $t2, 112($t0)
	sw $t2, 116($t0)
	sw $t2, 120($t0)
	sw $t2, 124($t0)
	
	# middle
	li $t2, 0x000000
	lw $t0, displayAddress
	addi $t1, $zero, 1920
	add $t3, $t0, $t1
	add $t0, $t3, $zero
	
	sw $t2, 0($t0)
	sw $t2, 4($t0)
	sw $t2, 8($t0)
	sw $t2, 12($t0)
	sw $t2, 16($t0)
	sw $t2, 20($t0)
	sw $t2, 24($t0)
	sw $t2, 28($t0)
	sw $t2, 32($t0)
	sw $t2, 36($t0)
	sw $t2, 40($t0)
	sw $t2, 44($t0)
	sw $t2, 48($t0)
	sw $t2, 52($t0)
	sw $t2, 56($t0)
	sw $t2, 60($t0)
	sw $t2, 64($t0)
	sw $t2, 68($t0)
	sw $t2, 72($t0)
	sw $t2, 76($t0)
	sw $t2, 80($t0)
	sw $t2, 84($t0)
	sw $t2, 88($t0)
	sw $t2, 92($t0)
	sw $t2, 96($t0)
	sw $t2, 100($t0)
	sw $t2, 104($t0)
	sw $t2, 108($t0)
	sw $t2, 112($t0)
	sw $t2, 116($t0)
	sw $t2, 120($t0)
	sw $t2, 124($t0)
	
	# bottom
	li $t2, 0x000000
	lw $t0, displayAddress
	addi $t1, $zero, 3968
	add $t3, $t0, $t1
	add $t0, $t3, $zero
	
	sw $t2, 0($t0)
	sw $t2, 4($t0)
	sw $t2, 8($t0)
	sw $t2, 12($t0)
	sw $t2, 16($t0)
	sw $t2, 20($t0)
	sw $t2, 24($t0)
	sw $t2, 28($t0)
	sw $t2, 32($t0)
	sw $t2, 36($t0)
	sw $t2, 40($t0)
	sw $t2, 44($t0)
	sw $t2, 48($t0)
	sw $t2, 52($t0)
	sw $t2, 56($t0)
	sw $t2, 60($t0)
	sw $t2, 64($t0)
	sw $t2, 68($t0)
	sw $t2, 72($t0)
	sw $t2, 76($t0)
	sw $t2, 80($t0)
	sw $t2, 84($t0)
	sw $t2, 88($t0)
	sw $t2, 92($t0)
	sw $t2, 96($t0)
	sw $t2, 100($t0)
	sw $t2, 104($t0)
	sw $t2, 108($t0)
	sw $t2, 112($t0)
	sw $t2, 116($t0)
	sw $t2, 120($t0)
	sw $t2, 124($t0)
	
	
	# 'PLAY - A'
	li $t2, 0x4fe2ff
	lw $t0, displayAddress
	addi $t1, $zero, 2432
	add $t3, $t0, $t1
	
	sw $t2, 8($t3)
	sw $t2, 12($t3)
	sw $t2, 16($t3)
	sw $t2, 24($t3)
	sw $t2, 36($t3)
	sw $t2, 40($t3)
	sw $t2, 44($t3)
	sw $t2, 52($t3)
	sw $t2, 60($t3)
	sw $t2, 96($t3)
	sw $t2, 100($t3)
	sw $t2, 104($t3)
	sw $t2, 136($t3)
	sw $t2, 144($t3)
	sw $t2, 152($t3)
	sw $t2, 164($t3)
	sw $t2, 172($t3)
	sw $t2, 180($t3)
	sw $t2, 188($t3)
	sw $t2, 224($t3)
	sw $t2, 232($t3)
	sw $t2, 264($t3)
	sw $t2, 268($t3)
	sw $t2, 272($t3)
	sw $t2, 280($t3)
	sw $t2, 292($t3)
	sw $t2, 296($t3)
	sw $t2, 300($t3)
	sw $t2, 312($t3)
	sw $t2, 328($t3)
	sw $t2, 332($t3)
	sw $t2, 336($t3)
	sw $t2, 352($t3)
	sw $t2, 356($t3)
	sw $t2, 360($t3)
	sw $t2, 392($t3)
	sw $t2, 408($t3)
	sw $t2, 412($t3)
	sw $t2, 420($t3)
	sw $t2, 428($t3)
	sw $t2, 440($t3)
	sw $t2, 480($t3)
	sw $t2, 488($t3)
	
	# 'END - D'
	li $t2, 0x4fe2ff
	lw $t0, displayAddress
	addi $t1, $zero, 3072
	add $t3, $t0, $t1
	
	sw $t2, 8($t3)
	sw $t2, 12($t3)
	sw $t2, 16($t3)
	sw $t2, 24($t3)
	sw $t2, 40($t3)
	sw $t2, 48($t3)
	sw $t2, 52($t3)
	sw $t2, 56($t3)
	sw $t2, 92($t3)
	sw $t2, 96($t3)
	sw $t2, 100($t3)
	sw $t2, 136($t3)
	sw $t2, 152($t3)
	sw $t2, 156($t3)
	sw $t2, 168($t3)
	sw $t2, 176($t3)
	sw $t2, 188($t3)
	sw $t2, 220($t3)
	sw $t2, 232($t3)
	sw $t2, 264($t3)
	sw $t2, 268($t3)
	sw $t2, 272($t3)
	sw $t2, 280($t3)
	sw $t2, 288($t3)
	sw $t2, 296($t3)
	sw $t2, 304($t3)
	sw $t2, 316($t3)
	sw $t2, 328($t3)
	sw $t2, 332($t3)
	sw $t2, 336($t3)
	sw $t2, 348($t3)
	sw $t2, 360($t3)
	sw $t2, 392($t3)
	sw $t2, 408($t3)
	sw $t2, 420($t3)
	sw $t2, 424($t3)
	sw $t2, 432($t3)
	sw $t2, 444($t3)
	sw $t2, 476($t3)
	sw $t2, 488($t3)
	sw $t2, 520($t3)
	sw $t2, 524($t3)
	sw $t2, 528($t3)
	sw $t2, 536($t3)
	sw $t2, 552($t3)
	sw $t2, 560($t3)
	sw $t2, 564($t3)
	sw $t2, 568($t3)
	sw $t2, 604($t3)
	sw $t2, 608($t3)
	sw $t2, 612($t3)
	
	# then check for keyboard input
	lw $t9, 0xffff0000
	beq $t9, 1, replaydecider
	
	#if no keyboard input, keep redrawing the screen
	li $v0, 32
	li $a0, 800
	syscall
	
	j gameover
	
###################################################
# logic to determine whether to start over or end
###################################################
replaydecider:
	# first read input from user
	# keep $t3 as the keyboard press
	lw $t3, 0xffff0004
	
	# determine which keyboard press is made
	beq	$t3, 100, endgame# if key press = 'a' branch to startover
	beq	$t3, 97, startover # else if key press = 'd' branch to endgame
	
	j gameover
	
	
##########	
startover:
	j main
	
###########	
endgame:
	# first print the whole screen white
	li $t2, 0xffffff
	lw $t0, displayAddress
	add $t8, $zero, $zero
	addi $t9, $zero, 4096
START_DRAW_ENDGAME: 
	beq $t8, $t9, EXIT_DRAW_ENDGAME
	sw $t2, ($t0)
	
	addi $t0, $t0, 4 
UPDATE_DRAW_ENDGAME:
	addi $t8, $t8, 4
	j START_DRAW_ENDGAME
EXIT_DRAW_ENDGAME:

# then print custom info

	# first 'fin'
	li $t2, 0xff0000
	lw $t0, displayAddress
	addi $t1, $zero, 512
	add $t3, $t0, $t1
	
	sw $t2, 48($t3)
	sw $t2, 172($t3)
	sw $t2, 180($t3)
	sw $t2, 188($t3)
	sw $t2, 300($t3)
	sw $t2, 324($t3)
	sw $t2, 328($t3)
	sw $t2, 424($t3)
	sw $t2, 428($t3)
	sw $t2, 432($t3)
	sw $t2, 444($t3)
	sw $t2, 452($t3)
	sw $t2, 460($t3)
	sw $t2, 556($t3)
	sw $t2, 572($t3)
	sw $t2, 580($t3)
	sw $t2, 588($t3)
	
	# lines
	# top
	li $t2, 0x000000
	lw $t0, displayAddress
	
	sw $t2, 0($t0)
	sw $t2, 4($t0)
	sw $t2, 8($t0)
	sw $t2, 12($t0)
	sw $t2, 16($t0)
	sw $t2, 20($t0)
	sw $t2, 24($t0)
	sw $t2, 28($t0)
	sw $t2, 32($t0)
	sw $t2, 36($t0)
	sw $t2, 40($t0)
	sw $t2, 44($t0)
	sw $t2, 48($t0)
	sw $t2, 52($t0)
	sw $t2, 56($t0)
	sw $t2, 60($t0)
	sw $t2, 64($t0)
	sw $t2, 68($t0)
	sw $t2, 72($t0)
	sw $t2, 76($t0)
	sw $t2, 80($t0)
	sw $t2, 84($t0)
	sw $t2, 88($t0)
	sw $t2, 92($t0)
	sw $t2, 96($t0)
	sw $t2, 100($t0)
	sw $t2, 104($t0)
	sw $t2, 108($t0)
	sw $t2, 112($t0)
	sw $t2, 116($t0)
	sw $t2, 120($t0)
	sw $t2, 124($t0)
	
	# middle
	li $t2, 0x000000
	lw $t0, displayAddress
	addi $t1, $zero, 1920
	add $t3, $t0, $t1
	add $t0, $t3, $zero
	
	sw $t2, 0($t0)
	sw $t2, 4($t0)
	sw $t2, 8($t0)
	sw $t2, 12($t0)
	sw $t2, 16($t0)
	sw $t2, 20($t0)
	sw $t2, 24($t0)
	sw $t2, 28($t0)
	sw $t2, 32($t0)
	sw $t2, 36($t0)
	sw $t2, 40($t0)
	sw $t2, 44($t0)
	sw $t2, 48($t0)
	sw $t2, 52($t0)
	sw $t2, 56($t0)
	sw $t2, 60($t0)
	sw $t2, 64($t0)
	sw $t2, 68($t0)
	sw $t2, 72($t0)
	sw $t2, 76($t0)
	sw $t2, 80($t0)
	sw $t2, 84($t0)
	sw $t2, 88($t0)
	sw $t2, 92($t0)
	sw $t2, 96($t0)
	sw $t2, 100($t0)
	sw $t2, 104($t0)
	sw $t2, 108($t0)
	sw $t2, 112($t0)
	sw $t2, 116($t0)
	sw $t2, 120($t0)
	sw $t2, 124($t0)
	
	# bottom
	li $t2, 0x000000
	lw $t0, displayAddress
	addi $t1, $zero, 3968
	add $t3, $t0, $t1
	add $t0, $t3, $zero
	
	sw $t2, 0($t0)
	sw $t2, 4($t0)
	sw $t2, 8($t0)
	sw $t2, 12($t0)
	sw $t2, 16($t0)
	sw $t2, 20($t0)
	sw $t2, 24($t0)
	sw $t2, 28($t0)
	sw $t2, 32($t0)
	sw $t2, 36($t0)
	sw $t2, 40($t0)
	sw $t2, 44($t0)
	sw $t2, 48($t0)
	sw $t2, 52($t0)
	sw $t2, 56($t0)
	sw $t2, 60($t0)
	sw $t2, 64($t0)
	sw $t2, 68($t0)
	sw $t2, 72($t0)
	sw $t2, 76($t0)
	sw $t2, 80($t0)
	sw $t2, 84($t0)
	sw $t2, 88($t0)
	sw $t2, 92($t0)
	sw $t2, 96($t0)
	sw $t2, 100($t0)
	sw $t2, 104($t0)
	sw $t2, 108($t0)
	sw $t2, 112($t0)
	sw $t2, 116($t0)
	sw $t2, 120($t0)
	sw $t2, 124($t0)

	li $v0, 10 # terminate the program gracefully
	syscall
	
##########################
# print game win screen
##########################
gamewin:
	# first print the whole screen white
	li $t2, 0xffffff
	lw $t0, displayAddress
	add $t8, $zero, $zero
	addi $t9, $zero, 4096
START_DRAW_GAMEWIN: 
	beq $t8, $t9, EXIT_DRAW_GAMEWIN
	sw $t2, ($t0)
	
	addi $t0, $t0, 4 
UPDATE_DRAW_GAMEWIN:
	addi $t8, $t8, 4
	j START_DRAW_GAMEWIN
EXIT_DRAW_GAMEWIN:

	# win message
	li $t2, 0xff0000
	lw $t0, displayAddress
	addi $t1, $zero, 512
	add $t3, $t0, $t1
	
	sw $t2, 60($t3)
	sw $t2, 88($t3)
	sw $t2, 164($t3)
	sw $t2, 172($t3)
	sw $t2, 180($t3)
	sw $t2, 196($t3)
	sw $t2, 200($t3)
	sw $t2, 216($t3)
	sw $t2, 292($t3)
	sw $t2, 300($t3)
	sw $t2, 308($t3)
	sw $t2, 316($t3)
	sw $t2, 324($t3)
	sw $t2, 332($t3)
	sw $t2, 424($t3)
	sw $t2, 432($t3)
	sw $t2, 444($t3)
	sw $t2, 452($t3)
	sw $t2, 460($t3)
	sw $t2, 472($t3)

	# lines
	# top
	li $t2, 0x000000
	lw $t0, displayAddress
	
	sw $t2, 0($t0)
	sw $t2, 4($t0)
	sw $t2, 8($t0)
	sw $t2, 12($t0)
	sw $t2, 16($t0)
	sw $t2, 20($t0)
	sw $t2, 24($t0)
	sw $t2, 28($t0)
	sw $t2, 32($t0)
	sw $t2, 36($t0)
	sw $t2, 40($t0)
	sw $t2, 44($t0)
	sw $t2, 48($t0)
	sw $t2, 52($t0)
	sw $t2, 56($t0)
	sw $t2, 60($t0)
	sw $t2, 64($t0)
	sw $t2, 68($t0)
	sw $t2, 72($t0)
	sw $t2, 76($t0)
	sw $t2, 80($t0)
	sw $t2, 84($t0)
	sw $t2, 88($t0)
	sw $t2, 92($t0)
	sw $t2, 96($t0)
	sw $t2, 100($t0)
	sw $t2, 104($t0)
	sw $t2, 108($t0)
	sw $t2, 112($t0)
	sw $t2, 116($t0)
	sw $t2, 120($t0)
	sw $t2, 124($t0)
	
	# middle
	li $t2, 0x000000
	lw $t0, displayAddress
	addi $t1, $zero, 1920
	add $t3, $t0, $t1
	add $t0, $t3, $zero
	
	sw $t2, 0($t0)
	sw $t2, 4($t0)
	sw $t2, 8($t0)
	sw $t2, 12($t0)
	sw $t2, 16($t0)
	sw $t2, 20($t0)
	sw $t2, 24($t0)
	sw $t2, 28($t0)
	sw $t2, 32($t0)
	sw $t2, 36($t0)
	sw $t2, 40($t0)
	sw $t2, 44($t0)
	sw $t2, 48($t0)
	sw $t2, 52($t0)
	sw $t2, 56($t0)
	sw $t2, 60($t0)
	sw $t2, 64($t0)
	sw $t2, 68($t0)
	sw $t2, 72($t0)
	sw $t2, 76($t0)
	sw $t2, 80($t0)
	sw $t2, 84($t0)
	sw $t2, 88($t0)
	sw $t2, 92($t0)
	sw $t2, 96($t0)
	sw $t2, 100($t0)
	sw $t2, 104($t0)
	sw $t2, 108($t0)
	sw $t2, 112($t0)
	sw $t2, 116($t0)
	sw $t2, 120($t0)
	sw $t2, 124($t0)
	
	# bottom
	li $t2, 0x000000
	lw $t0, displayAddress
	addi $t1, $zero, 3968
	add $t3, $t0, $t1
	add $t0, $t3, $zero
	
	sw $t2, 0($t0)
	sw $t2, 4($t0)
	sw $t2, 8($t0)
	sw $t2, 12($t0)
	sw $t2, 16($t0)
	sw $t2, 20($t0)
	sw $t2, 24($t0)
	sw $t2, 28($t0)
	sw $t2, 32($t0)
	sw $t2, 36($t0)
	sw $t2, 40($t0)
	sw $t2, 44($t0)
	sw $t2, 48($t0)
	sw $t2, 52($t0)
	sw $t2, 56($t0)
	sw $t2, 60($t0)
	sw $t2, 64($t0)
	sw $t2, 68($t0)
	sw $t2, 72($t0)
	sw $t2, 76($t0)
	sw $t2, 80($t0)
	sw $t2, 84($t0)
	sw $t2, 88($t0)
	sw $t2, 92($t0)
	sw $t2, 96($t0)
	sw $t2, 100($t0)
	sw $t2, 104($t0)
	sw $t2, 108($t0)
	sw $t2, 112($t0)
	sw $t2, 116($t0)
	sw $t2, 120($t0)
	sw $t2, 124($t0)

	li $v0, 10 # terminate the program gracefully
	syscall

