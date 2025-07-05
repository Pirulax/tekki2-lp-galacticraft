local pretty = require "cc.pretty"
local strings = require "cc.strings"


local function find_item_slot(req_item)
    -- Find the slot of the item in the turtle inventory
    for i = 1, 16 do
        local item = turtle.getItemDetail(i)
        if item and item.name == req_item.id then
            if not req_item.data or req_item.data == item.damage then
                return i
            end
        end
    end

    -- If the item is not found, return nil
    return nil
end


local function get_or_wait_for_item(item)
    while true do
        -- Check if the item is already in the inventory
        local slot = find_item_slot(item)
        if slot then
            return slot
        end

        -- Wait for the item to be added to the inventory
        print("Waiting for item: " .. item.id)
        os.pullEvent("turtle_inventory")
    end
end

-- Args are the recipe slot items in format `item_id:data`
-- Example: `minecraft:stone` for stone, `galacticraftcore:basic_item/1` for a specific data value (`1` in this case)
-- Each arg is a different slot (in order)
local args = {...}

-- Parse recipe arguments
local recipe = {}
for k, v in ipairs(args) do
    -- <item id>/<data value (optional)>, eg `galacticraftcore:basic_item/11`
    local id, data = v:match("([^/]+)%/?(.*)")    
    recipe[k] = {
        item = {
            id = id,
            data = data and tonumber(data)
        },
        count = 1
    }
end
print("Recipe is ", pretty.pretty(recipe))

-- Main process loop
while true do
    -- Push recipe into the machine
    for i, recipe_slot in ipairs(recipe) do
        local slot = get_or_wait_for_item(recipe_slot.item)
        turtle.select(slot)
        print("Selected slot " .. slot .. " for item: " .. recipe_slot.item.id)
        turtle.drop() -- Drop the item into the machine
    end

    -- Wait for the machine to finish processing
    print("Waiting for machine to finish processing...")
    print("event details", os.pullEvent("redstone"))
end
