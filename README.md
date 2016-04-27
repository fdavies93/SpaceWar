#Introduction

This project provides the framework for a top-down 2D space exploration game similar to SPAZ (Space Pirates and Zombies) or many older entries in the genre. It is written in the Haxe language using the HaxeFlixel libraries, and was developed using FlashDevelop. The current version is set up as a very simple example: feel free to experiment with the code to get the results you want. The code is 'very' object-oriented, so it might take a little getting used to.

It's released under the GNU GPL documentation; I'm not planning on making any money off it and wanted to share the code with others for them to get what they like out of it.

#Known Issues / Suggested Improvements

##General

* Physics does not work with versions of HaxeFlixel after 3.3.8; it's unclear whether this is my fault or due to a breaking change in the HaxeFlixel library. The relevant code can be found in the core NewtonianSprite.hx class file, and relates to use of the FlxVector class.
* Looks terrible when compiled to non-Flash targets.

##Code

* SpacialGrid class not fully implemented; this will improve the efficiency of the game greatly when complete, and is to be preferred to the native QuadTree because it works better with large numbers of moving (i.e. physics) objects.
* Animations need to be added.
* At the moment the background stars either hog memory or need a very slow movement speed; tiling them would solve this problem.
* Physics code sucks, and can be improved in terms of both performance and feel (e.g. mass does not effect angular rotation speed).
* Various other inefficiencies and bad code.

##Graphics

* Generally terrible graphics quality (programmer art!).
* Asteroid object needs a replacement graphic.
* Animations would improve game feel a lot.

##Features

* Navigation UI can be greatly improved.
* Vast number of possible AI improvements, the most obvious being navigation taking into account the position of gravity wells.
* Menus etc. would probably be a good thing to add.
