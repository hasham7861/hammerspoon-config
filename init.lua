-- Optimized: Map number keys to arrow keys and disable others
-- 8/2/4/6 = Up/Down/Left/Right
-- 7, 9, 5, 1, 3, 0 = Disabled

local arrowKeys = {
    [91] = "up",     -- 8
    [84] = "down",   -- 2 (number row)
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

numpadTap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    local keyCode = event:getKeyCode()
    -- hs.alert.show("Keycode: " .. keyCode)
    -- print("Keycode pressed: " .. keyCode)
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

-- hs.alert.show("Numpad ready!")

-- F11 = Volume Down, F12 = Volume Up (intercepted before macOS system bindings)
fKeyTap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    local keyCode = event:getKeyCode()
    if keyCode == 103 then  -- F11
        local vol = math.max(0, hs.audiodevice.defaultOutputDevice():volume() - 5)
        hs.audiodevice.defaultOutputDevice():setVolume(vol)
        hs.alert.show("🔉 " .. math.floor(vol) .. "%", 0.8)
        return true
    elseif keyCode == 111 then  -- F12
        local vol = math.min(100, hs.audiodevice.defaultOutputDevice():volume() + 5)
        hs.audiodevice.defaultOutputDevice():setVolume(vol)
        hs.alert.show("🔊 " .. math.floor(vol) .. "%", 0.8)
        return true
    end
    return false
end):start()