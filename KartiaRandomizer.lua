settings = {

seed = 0, -- Set this to 0 for random seed. Otherwise, use any number.

lacrymaGodEquipment = 1, -- Allows the God equipment on level 2 to be shuffled in (note: this chest is always destroyed)

randomizeLocations = 0, -- Simple mode, just shuffle within the same level. 
randomizeLevels = 1, -- Shuffle all chests across all levels

-- randomizeStartingTexts = 0, -- Not implemented
-- randomizeNewContents = 0, -- Not implemented
-- randomizeLevelClear = 0, -- Not implemented
};

------------------------------------------------------------
-- Written by Meerkov
-- Edit the settings above this line to change the behavior. 
-- You don't need to look at anything below this.
------------------------------------------------------------

function randomizeSeed()
  settings.seed = os.clock();
end

if(settings.seed == 0) then
 randomizeSeed();
end

ToxaChestStart = 0x78A58 
ToxaNumItems =  { 2, 7, 4, 8, 8, 5, 7, 9, 7, 8, 5,10, 7, 8, 7, 9, 9, 4}
LacrymaChestStart = 0x79C58 
LacrymaNumItems = { 5, 5, 4, 3, 8, 3, 9, 6, 4, 7, 9,10,10,10,10,12, 8, 0}


print("Seed: "..settings.seed);

function FYShuffle( tInput )
    local tReturn = {}
    for i = #tInput, 1, -1 do
        local j = math.random(i)
        tInput[i], tInput[j] = tInput[j], tInput[i]
        table.insert(tReturn, tInput[i])
    end
    return tReturn
end

function randomAssignment(items, locations)
  print("randomly assigning dummy");
end

function writeItemsToLocation(items, location)
  newtable = {}
  --print(items);
  for idx,item in pairs(items) do
    --print(idx,item);
	newtable[location+idx]=item;
  end
  --print(newtable);
  --print(memory.getmemorydomainsize());
  for key,value in pairs(newtable) do
    memory.writebyte(key, value);
  end
  --memory.writebyterange(newtable);
end

function collectAllItemsFromLevels(collectedItems, locationOutput, ChestStart, NumItems )
  for i, num in pairs(NumItems) do
	location = (i-1)*0x100+ChestStart;
	--print(location);
    collectedItems = collectItems(collectedItems, locationOutput, location, num);
  end
  return collectedItems, locationOutput;
end

function collectItems(container, locationOutput, location, num)
	--print(location);
    for chest = 1,num do
      itemLoc = location + (chest-1)*0x10;
	  --print(itemLoc);
	  item = memory.readbyterange(itemLoc,16);
      --print(item);
	  table.insert(container, item);
	  table.insert(locationOutput, itemLoc);
    end
	return container;
end

function randomizeEachLevel(NumItems, ChestStart)
  for i, num in pairs(NumItems) do
    collectedItems = {}
	locationOutput = {}
	location = (i-1)*0x100+ChestStart;
	--print(location);
    collectedItems = collectItems(collectedItems, locationOutput, location, num);
	
    FYShuffle(collectedItems);
	--print(collectedItems);
	for chest = 1,num do
	  writeItemsToLocation(collectedItems[chest], locationOutput[chest]);
    end
  end
end

function writeAllItems(items, locations)
	for key, itemLoc in pairs(locations) do
	  --print(collectedItems[chest]);
	  writeItemsToLocation(collectedItems[key], itemLoc);
	end

end

math.randomseed(settings.seed);
if(settings.lacrymaGodEquipment == 1) then
  LacrymaNumItems[2]=6;
end

if(settings.randomizeLocations == 1) then
	randomizeEachLevel(ToxaNumItems, ToxaChestStart);
	randomizeEachLevel(LacrymaNumItems, LacrymaChestStart);
end

if(settings.randomizeLevels == 1) then
	collectedItems, locations = collectAllItemsFromLevels({}, {}, ToxaChestStart, ToxaNumItems);
    FYShuffle(collectedItems);
	writeAllItems(collectedItems, locations);
	
	collectedItems, locations = collectAllItemsFromLevels({}, {}, LacrymaChestStart, LacrymaNumItems);
    FYShuffle(collectedItems);
	writeAllItems(collectedItems, locations);
end
