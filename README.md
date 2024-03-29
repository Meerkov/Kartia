# Kartia Randomizer
Kartia Randomizer is a tool that can be used with Bizhawk to create a unique Kartia playing experience. You must have a working copy of Kartia for the PSX before using this tool.

# What does it do
There are two modes:

**RandomizeLevels**: It shuffles the chests throughout the game. This may help you get endgame spells early, but you also won't find spells that you would expect to find early.

**RandomizeLocations**: It just shuffles the chests within the same level. The progression of the game is kept the same, but there will just be uncertainty about which chest contains which item.

The chests are only shuffled within the same storyline, so you can be sure you won't get duplicate texts.

"Chests" here refers to all items in chests, boxes, barrels, and buried underground. Items obtained for beating levels, or that are carried by enemies, are untouched. Starting equipment is also unaffected.

# How do I use it

1) First edit the .lua script "Settings" at the top of the file. "0" turns a feature off, and "1" turns a feature on.

2) If you want to use a specific seed for your game, change the "seed" variable to any number other than 0. The default 0 will result in a random seed.

3) Set lacrymaGodEquipment to either 0 or 1. 0 leaves the easter egg where it is (impossible to get) while 1 allows it to be shuffled in with the other treasure (a random treasure will be inaccessible instead).

4) Set either randomizeLocations or randomizeLevels to 1.

5) Use the Bizhawk emulator, and after starting a new game, run the lua script.

That's it!

# Known Issues
On Lacryma's story (I think level 6?), there are 3 treasures burried underground that use the same drop from the item table. This can be confusing, as you may see a notification multiple times for the same treasure. Don't worry, this is working correctly. The game is just programmed to re-use that item multiple times on that level. There might be other levels that use the same drop multiple times, but I'm not sure.

Loading the game from memory card might result in a corrupted save (unconfirmed). Use save-states instead.

The seed mode isn't stable if you close the emulator and restart it. It will shuffle the remaining chests in a different way.
