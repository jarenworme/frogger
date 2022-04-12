# frogger
This project is an attempt to recreate the arcade game 'Frogger' from scratch, using the MIPS assembly language.
I use the MARS 4.5 ISA and anyone wanting to download and test my code can do so! I have outlined the dimensions for the bitmap display in the initial preamble of the .asm file.

There are some features implemented that takes it closer to the original arcade game, including:
- Displaying lives remaining
- Showing a game over svreen when the frog dies, with the option to then quit or restart
- Showing a winning screen when the frog gets 5 points
- Produces a short death animation every time a frog dies
- Objects in different rows move at different speeds
- Frog points in the direction it is travelling
- enters a second, harder, cutom level if player wins level 1

Additionally:
- Game set up so that frog dies after three collisions, but wins if it reaches the goal 5 times
- Points are displayed as white pixels (to the right of "PTS") that appear every time the frog reaches the goal
- The three differently colored pixels next to "LIFE" are the three lives displayed
- White rectangles are cars on road, brown rectangles are logs on water
- Game runs at 60fps, but gets slightly slower the longer it runs (something to do with MARS)

To download mars, use the MARS file in the repo code (NOT CREATED BY ME, I PUT IT HERE FOR CONVENIENCE)

If your pc does not allow you to open it, you can use the following command in the windows command line

java -jar "C:\Users\<yourusername>\downloads\Mars_Updated.jar"

enjoy!
~Jaren

