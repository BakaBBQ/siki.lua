=================
siki.lua
=================

.. image:: http://bakabbq.github.io/siki.lua/images/screenshot.jpg

a hitbox editor using

+ Love2d
+ LoveFrames by Kenny Shields (aka Nikolai Resokav)
+ dkjson.lua
+ lume + lurker

Licensed under MIT

The tool itself is declared finished, yet it is likely to have undiscovered bugs
that will be fixed after discovered in future use.

Tool itself is only intended for personal usage. Nonetheless, issues, PRs (if any)
and suggestions are indeedly welcomed.

Format
-----------------------------

after saving, the output will be saved into a JSON file named frames.json


Boxes
--------------------------

in penance for my poor language skills, lets call the frame's depicting character OWNER
and the opponent, well... OPPONENT

- Hurtbox aka GreenBox

  - if the OPPONENT's hitbox touches the OWNER's hurtbox, OWNER gets hurt

- Hitbox aka RedBox

  - if the OPPONENT's hurtbox touches the OWNER's hitbox, OPPONENT gets hurt

- Whitebox aka Collisionbox

  - honestly I don't know how those guys think of character collision different from character hurtbox...
  - the only factor that determines how actors react when pushed together
  - how the players interact...


Missing Features
-------------------------

- ox, oy editing
