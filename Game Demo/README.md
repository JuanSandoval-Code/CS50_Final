# Untitled Game Demo
#### Video Demo:  <URL HERE>
#### Description:
This is my submission for the final project in CS50. It is a simple proof of concept for a side scrolling video game made with lua, love2d, and Tiled. I have always loved video games and figured it would be a good idea to learn some of the mechanincs and workings of video games for my own knowledge and possibly as side projects in the future. Whether or not I will continue to work on this in the future remains to be seen but the more experience I have with coding in the future will increase the likelyhood of that happening. Below are brief descriptions of the files in my project.
<br><br>
Camera-Simply put, this file allows the camera to follow our player character and employ the side scrolling aspect of the game.
<br><br>
Conf-Sets the dimensions of the game and other miscellaneous information.
<br><br>
Enemy-This file incorporates our enemy in this demo. It includes things you would expect from an enemy character such as how their physics interact with our player character, the amount of damage they deal and the method of animating their movements.
<br><br>
GUI-This stands for Graphical User Interface and currently only has a display of our characters current health points. In the future this is where I would put other information such as equipment, potions, money, etc.
<br><br>
Main-The main file which loads, updates, and draws the other files, etc.
<br><br>
Player-Holds the information of our player character and how they interact with the game world as a whole. Has things similar to the enemy file such as the physics, interactions, and animation functions. It also has interactions such as the keeping track of player health, how the jumping and gravity effects our character, and other aspects you might expect from a video game main character.
<br><br>
Spike-Includes a negative obstacle for the player and has the interaction when the player interacts with it. In this case it deals damage to the player when it comes into contact with the player.
<br><br>
All assets were taken from free sources on Itch.io and do not require credit but will likely add in the future since I liked the assets and will want to use them in future projects.