scoreboard players reset @a[scores={LeaveDetect=1}] JoinTimer
scoreboard players reset @a[scores={LeaveDetect=1}] LeaveDetect
execute as @a at @s unless score @s JoinTimer matches 1001 run scoreboard players add @s JoinTimer 1
execute as @a[scores={JoinTimer=81}] at @s run playsound minecraft:audio master @s