-- Optimized: Map number keys to arrow keys and disable others
-- 8/2/4/6 = Up/Down/Left/Right
-- 7, 9, 5, 1, 3, 0 = Disabled

local arrowKeys = {
    [91] = "up",     -- 8
    [19] = "down",   -- 2 (number row)
    [84] = "down",   -- 2 (keypad backup)
    [86] = "left",   -- 4
    [88] = "right",  -- 6
}

local disabledKeys = {
    [89] = true,  -- 7
    [92] = true,  -- 9
    [87] = true,  -- 5
    [83] = true,  -- 1
    [85] = true,  -- 3
    [82] = true,  -- 0
}

hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    local keyCode = event:getKeyCode()
    
    -- Check arrow keys first (most common)
    local arrow = arrowKeys[keyCode]
    if arrow then
        hs.eventtap.keyStroke({}, arrow, 0)  -- 0 delay
        return true
    end
    
    -- Check disabled keys
    if disabledKeys[keyCode] then
        return true
    end
    
    -- All other keys pass through immediately
    return false
end):start()

hs.alert.show("Numpad ready!")