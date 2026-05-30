-- HUNTER HUB v1.0 - Blox Fruits
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local WS = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TS = game:GetService("TweenService")
local VU = game:GetService("VirtualUser")
local VIM = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")
local First_Sea = game.PlaceId == 2753915549
local Second_Sea = game.PlaceId == 4442272183
local Third_Sea = game.PlaceId == 7449423635
local Remotes = RS:FindFirstChild("Remotes")
local CommF_ = Remotes and Remotes:FindFirstChild("CommF_")

-- WEBHOOK
local webhookUrl = "https://discord.com/api/webhooks/1510305087346708560/S32Plautg6Jt8KItUek6D8K6L-1McOqOOTL6Xtv9Gr3WMzNi3wbI32SMgczQ2ox0oQoS"

local function sendWebhook(status, errorMsg)
    local executor = "Unknown"
    pcall(function()
        if syn then executor = "Synapse X"
        elseif KRNL_LOADED then executor = "KRNL"
        elseif Fluxus then executor = "Fluxus"
        elseif Delta then executor = "Delta"
        elseif identifyexecutor then executor = identifyexecutor()
        elseif getexecutorname then executor = getexecutorname()
        end
    end)
    
    local isSuccess = status == "Success"
    -- Green (0x00FF00 = 65280) for success, Red (0xFF0000 = 16711680) for error
    local embedColor = isSuccess and 65280 or 16711680
    
    local data = {
        embeds = {{
            title = "Hunter Hub — Execution",
            color = embedColor,
            fields = {
                {name = "`Status`", value = isSuccess and "**Success**" or "**Error**: "..tostring(errorMsg), inline = true},
                {name = "`User`", value = "**"..Player.Name.."**", inline = true},
                {name = "`Executor`", value = "**"..executor.."**", inline = true}
            },
            footer = {text = "Hunter Hub v1.0"},
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    pcall(function()
        local headers = {["Content-Type"] = "application/json"}
        local requestFunc = http_request or request or HttpPost or syn.request
        if requestFunc then
            requestFunc({
                Url = webhookUrl,
                Method = "POST",
                Headers = headers,
                Body = HttpService:JSONEncode(data)
            })
        end
    end)
end

-- THEME (Blood/Dark)
local bgCol = Color3.fromRGB(8, 8, 10)
local hdrCol = Color3.fromRGB(12, 12, 15)
local cardCol = Color3.fromRGB(20, 20, 25)
local borderCol = Color3.fromRGB(40, 40, 45)
local txtCol = Color3.fromRGB(240, 240, 240)
local mutedCol = Color3.fromRGB(120, 120, 120)
local dimCol = Color3.fromRGB(30, 30, 35)
local accent = Color3.fromRGB(180, 0, 0)
local accentGlow = Color3.fromRGB(220, 20, 20)

local function tw(t,s,d) return TweenInfo.new(t or 0.2, s or Enum.EasingStyle.Quart, d or Enum.EasingDirection.Out) end
local function mkC(p,r) 
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = p
end

-- GUI SETUP
local sg = Instance.new("ScreenGui")
sg.Name = "HunterHub"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.IgnoreGuiInset = true
sg.DisplayOrder = 999
sg.Parent = Player:WaitForChild("PlayerGui")

local espGui = Instance.new("ScreenGui")
espGui.Name = "HunterESP"
espGui.ResetOnSpawn = false
espGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
espGui.IgnoreGuiInset = true
espGui.DisplayOrder = 998
espGui.Parent = Player:WaitForChild("PlayerGui")

local Camera = WS.CurrentCamera
local WIN_W = 750
local WIN_H = 520
local HDR_H = 45
local TAB_H = 38

local win = Instance.new("Frame")
win.Size = UDim2.new(0, WIN_W, 0, WIN_H)
win.Position = UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2)
win.BackgroundColor3 = bgCol
win.BorderSizePixel = 0
win.ClipsDescendants = true
win.Parent = sg
mkC(win, 8)

-- Blood drip accent
local bloodDrip = Instance.new("Frame")
bloodDrip.Size = UDim2.new(1, 0, 0, 3)
bloodDrip.BackgroundColor3 = accent
bloodDrip.BorderSizePixel = 0
bloodDrip.Parent = win

-- Glow
local glow = Instance.new("ImageLabel")
glow.Size = UDim2.new(1, 60, 1, 60)
glow.Position = UDim2.new(0, -30, 0, -30)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://1316045217"
glow.ImageColor3 = accent
glow.ImageTransparency = 0.95
glow.ZIndex = -1
glow.Parent = win

-- Header
local hdr = Instance.new("Frame")
hdr.Size = UDim2.new(1, 0, 0, HDR_H)
hdr.Position = UDim2.new(0, 0, 0, 3)
hdr.BackgroundColor3 = hdrCol
hdr.BorderSizePixel = 0
hdr.ZIndex = 3
hdr.Parent = win

-- Title
local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(0, 250, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.Text = "HUNTER HUB"
titleText.Font = Enum.Font.GothamBlack
titleText.TextSize = 22
titleText.TextColor3 = accent
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.BackgroundTransparency = 1
titleText.ZIndex = 5
titleText.Parent = hdr

local byText = Instance.new("TextLabel")
byText.Size = UDim2.new(0, 150, 1, 0)
byText.Position = UDim2.new(0, 165, 0, 2)
byText.Text = ""
byText.Font = Enum.Font.GothamBold
byText.TextSize = 12
byText.TextColor3 = mutedCol
byText.TextXAlignment = Enum.TextXAlignment.Left
byText.BackgroundTransparency = 1
byText.ZIndex = 5
byText.Parent = hdr

-- Controls
local btnSize = 26
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
minBtn.Position = UDim2.new(1, -(btnSize*2+20), 0.5, -btnSize/2)
minBtn.Text = "−"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 14
minBtn.TextColor3 = mutedCol
minBtn.BackgroundColor3 = cardCol
minBtn.BorderSizePixel = 0
minBtn.ZIndex = 5
minBtn.Parent = hdr
mkC(minBtn, 6)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
closeBtn.Position = UDim2.new(1, -(btnSize+10), 0.5, -btnSize/2)
closeBtn.Text = "×"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.TextColor3 = mutedCol
closeBtn.BackgroundColor3 = cardCol
closeBtn.BorderSizePixel = 0
closeBtn.ZIndex = 5
closeBtn.Parent = hdr
mkC(closeBtn, 6)

-- Minimize/close functionality
local isMin = false
minBtn.MouseEnter:Connect(function() TS:Create(minBtn, tw(), {BackgroundColor3=accent, TextColor3=Color3.new(1,1,1)}):Play() end)
minBtn.MouseLeave:Connect(function() TS:Create(minBtn, tw(), {BackgroundColor3=cardCol, TextColor3=mutedCol}):Play() end)
minBtn.MouseButton1Click:Connect(function()
    isMin = not isMin
    if isMin then
        TS:Create(win, tw(0.3), {Size=UDim2.new(0, WIN_W, 0, HDR_H+3)}):Play()
        minBtn.Text = "+"
    else
        TS:Create(win, tw(0.3), {Size=UDim2.new(0, WIN_W, 0, WIN_H)}):Play()
        minBtn.Text = "−"
    end
end)

closeBtn.MouseEnter:Connect(function() TS:Create(closeBtn, tw(), {BackgroundColor3=Color3.fromRGB(200,30,30), TextColor3=Color3.new(1,1,1)}):Play() end)
closeBtn.MouseLeave:Connect(function() TS:Create(closeBtn, tw(), {BackgroundColor3=cardCol, TextColor3=mutedCol}):Play() end)
closeBtn.MouseButton1Click:Connect(function()
    cleanupAllESP()
    sg:Destroy()
    espGui:Destroy()
end)

-- Drag
local dragging = false
local dragStart, startPos
hdr.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = i.Position
        startPos = win.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local delta = i.Position - dragStart
        win.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
hdr.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- TABS
local TABS = {"Discord", "Farm", "Fruit", "Stats", "Teleport", "Visual", "Shop", "Misc"}
local tabBtns, tabPages = {}, {}
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -16, 0, TAB_H)
tabBar.Position = UDim2.new(0, 8, 0, HDR_H + 8)
tabBar.BackgroundTransparency = 1
tabBar.Parent = win

local tl = Instance.new("UIListLayout")
tl.FillDirection = Enum.FillDirection.Horizontal
tl.SortOrder = Enum.SortOrder.LayoutOrder
tl.Padding = UDim.new(0, 4)
tl.Parent = tabBar

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -16, 1, -(HDR_H + TAB_H + 16))
content.Position = UDim2.new(0, 8, 0, HDR_H + TAB_H + 12)
content.BackgroundTransparency = 1
content.Parent = win

local function switchTab(idx)
    for i, btn in ipairs(tabBtns) do
        local on = (i == idx)
        TS:Create(btn, tw(0.15), {BackgroundColor3 = on and accent or dimCol, TextColor3 = on and Color3.new(1,1,1) or mutedCol}):Play()
        tabPages[i].Visible = on
    end
end

for i, name in ipairs(TABS) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1/#TABS, -4, 1, 0)
    btn.BackgroundColor3 = i == 1 and accent or dimCol
    btn.TextColor3 = i == 1 and Color3.new(1,1,1) or mutedCol
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.BorderSizePixel = 0
    btn.LayoutOrder = i
    btn.Parent = tabBar
    mkC(btn, 6)
    tabBtns[i] = btn
    
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = i == 1
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = accent
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Parent = content
    tabPages[i] = page
    
    local list = Instance.new("UIListLayout")
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 8)
    list.Parent = page
    
    local pp = Instance.new("UIPadding")
    pp.PaddingTop = UDim.new(0, 4)
    pp.PaddingBottom = UDim.new(0, 8)
    pp.Parent = page
    
    btn.MouseButton1Click:Connect(function() switchTab(i) end)
end

-- UI BUILDERS
local orderCounter = 0
local function nextOrder()
    orderCounter = orderCounter + 1
    return orderCounter
end

local toggleRegistry = {}

local function makeSection(p, l)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 20)
    f.BackgroundTransparency = 1
    f.LayoutOrder = nextOrder()
    f.Parent = p
    
    local lb = Instance.new("TextLabel")
    lb.Size = UDim2.new(1, 0, 1, 0)
    lb.Text = string.upper(l)
    lb.Font = Enum.Font.GothamBlack
    lb.TextSize = 12
    lb.TextColor3 = accent
    lb.TextXAlignment = Enum.TextXAlignment.Left
    lb.BackgroundTransparency = 1
    lb.Parent = f
    
    local ln = Instance.new("Frame")
    ln.Size = UDim2.new(0, 40, 0, 2)
    ln.Position = UDim2.new(0, 0, 1, -2)
    ln.BackgroundColor3 = accent
    ln.BorderSizePixel = 0
    ln.Parent = f
    mkC(ln, 4)
end

local function makeToggle(p, l, default, cb, regName)
    local rH = 50
    local r = Instance.new("Frame")
    r.Size = UDim2.new(1, 0, 0, rH)
    r.BackgroundColor3 = cardCol
    r.BorderSizePixel = 0
    r.LayoutOrder = nextOrder()
    r.Parent = p
    mkC(r, 8)
    
    local st = default or false
    
    local lb = Instance.new("TextLabel")
    lb.Size = UDim2.new(1, -70, 1, 0)
    lb.Position = UDim2.new(0, 12, 0, 0)
    lb.Text = l
    lb.Font = Enum.Font.GothamBold
    lb.TextSize = 12
    lb.TextColor3 = txtCol
    lb.TextXAlignment = Enum.TextXAlignment.Left
    lb.BackgroundTransparency = 1
    lb.Parent = r
    
    local pl = Instance.new("Frame")
    pl.Size = UDim2.new(0, 50, 0, 26)
    pl.Position = UDim2.new(1, -60, 0.5, -13)
    pl.BackgroundColor3 = st and accent or dimCol
    pl.Parent = r
    mkC(pl, 13)
    
    local kn = Instance.new("Frame")
    kn.Size = UDim2.new(0, 20, 0, 20)
    kn.Position = st and UDim2.new(1, -24, 0.5, -10) or UDim2.new(0, 3, 0.5, -10)
    kn.BackgroundColor3 = st and Color3.new(1,1,1) or mutedCol
    kn.Parent = pl
    mkC(kn, 10)
    
    local ht = Instance.new("TextButton")
    ht.Size = UDim2.new(1, 0, 1, 0)
    ht.BackgroundTransparency = 1
    ht.Text = ""
    ht.Parent = r
    
    local function setVisual(state)
        TS:Create(pl, tw(0.2), {BackgroundColor3 = state and accent or dimCol}):Play()
        TS:Create(kn, tw(0.2), {Position = state and UDim2.new(1, -24, 0.5, -10) or UDim2.new(0, 3, 0.5, -10), BackgroundColor3 = state and Color3.new(1,1,1) or mutedCol}):Play()
    end
    
    local function tg()
        st = not st
        setVisual(st)
        pcall(cb, st)
    end
    
    local function setState(newState)
        if st ~= newState then
            st = newState
            setVisual(st)
            pcall(cb, st)
        end
    end
    
    ht.MouseButton1Click:Connect(tg)
    ht.TouchTap:Connect(tg)
    
    if regName then toggleRegistry[regName] = {setState = setState, getState = function() return st end} end
end

local function makeButton(p, l, cb)
    local rH = 42
    local bt = Instance.new("TextButton")
    bt.Size = UDim2.new(1, 0, 0, rH)
    bt.BackgroundColor3 = accent
    bt.Text = l
    bt.Font = Enum.Font.GothamBlack
    bt.TextSize = 12
    bt.TextColor3 = Color3.new(1,1,1)
    bt.LayoutOrder = nextOrder()
    bt.BorderSizePixel = 0
    bt.Parent = p
    mkC(bt, 8)
    bt.MouseButton1Click:Connect(cb)
    bt.TouchTap:Connect(cb)
end

local function makeDropdown(p, l, options, varName, cb)
    local rH = 55
    local r = Instance.new("Frame")
    r.Size = UDim2.new(1, 0, 0, rH)
    r.BackgroundColor3 = cardCol
    r.LayoutOrder = nextOrder()
    r.BorderSizePixel = 0
    r.Parent = p
    mkC(r, 8)
    
    local lb = Instance.new("TextLabel")
    lb.Size = UDim2.new(0.4, 0, 1, 0)
    lb.Position = UDim2.new(0, 12, 0, 0)
    lb.Text = l
    lb.Font = Enum.Font.GothamBold
    lb.TextSize = 11
    lb.TextColor3 = txtCol
    lb.TextXAlignment = Enum.TextXAlignment.Left
    lb.BackgroundTransparency = 1
    lb.Parent = r
    
    _G[varName] = _G[varName] or options[1]
    
    local dd = Instance.new("TextButton")
    dd.Size = UDim2.new(0.55, -10, 0, 36)
    dd.Position = UDim2.new(0.45, 0, 0.5, -18)
    dd.BackgroundColor3 = dimCol
    dd.Text = _G[varName]
    dd.Font = Enum.Font.GothamBold
    dd.TextSize = 10
    dd.TextColor3 = txtCol
    dd.BorderSizePixel = 0
    dd.Parent = r
    mkC(dd, 6)
    
    local accentLine = Instance.new("Frame")
    accentLine.Size = UDim2.new(1, 0, 0, 2)
    accentLine.Position = UDim2.new(0, 0, 1, -2)
    accentLine.BackgroundColor3 = accent
    accentLine.BorderSizePixel = 0
    accentLine.Parent = dd
    
    local expanded = false
    local optionsFrame = nil
    
    dd.MouseButton1Click:Connect(function()
        if not expanded then
            expanded = true
            optionsFrame = Instance.new("Frame")
            optionsFrame.Size = UDim2.new(1, 0, 0, #options * 32)
            optionsFrame.Position = UDim2.new(0, 0, 1, 5)
            optionsFrame.BackgroundColor3 = dimCol
            optionsFrame.BorderSizePixel = 0
            optionsFrame.ZIndex = 10
            optionsFrame.Parent = dd
            mkC(optionsFrame, 6)
            
            for i, opt in ipairs(options) do
                local optBtn = Instance.new("TextButton")
                optBtn.Size = UDim2.new(1, 0, 0, 32)
                optBtn.Position = UDim2.new(0, 0, 0, (i-1)*32)
                optBtn.BackgroundColor3 = dimCol
                optBtn.Text = opt
                optBtn.Font = Enum.Font.Gotham
                optBtn.TextSize = 10
                optBtn.TextColor3 = txtCol
                optBtn.ZIndex = 11
                optBtn.BorderSizePixel = 0
                optBtn.Parent = optionsFrame
                
                optBtn.MouseEnter:Connect(function() optBtn.BackgroundColor3 = cardCol end)
                optBtn.MouseLeave:Connect(function() optBtn.BackgroundColor3 = dimCol end)
                optBtn.MouseButton1Click:Connect(function()
                    _G[varName] = opt
                    dd.Text = opt
                    optionsFrame:Destroy()
                    expanded = false
                    pcall(cb, opt)
                end)
            end
        else
            if optionsFrame then optionsFrame:Destroy() end
            expanded = false
        end
    end)
end

-- ==================== PAGE CONTENT ====================

-- DISCORD (Tab 1)
local pg = tabPages[1]
orderCounter = 0
makeSection(pg, "Discord Server")
makeButton(pg, "Join Discord Server", function()
    pcall(function()
        if setclipboard then setclipboard("https://discord.gg/RSWfQmNamw") end
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "HUNTER HUB", Text = "Discord invite copied!", Duration = 3})
    end)
end)

-- FARM (Tab 2)
pg = tabPages[2]
orderCounter = 0
makeSection(pg, "Farming Configuration")
makeDropdown(pg, "Select Farming Tool", {"Melee", "Sword", "Gun", "Bloxfruit"}, "SelectedTool", function(v) SelectWeapon = v end)
makeSection(pg, "Farming Options")
makeToggle(pg, "Auto Level Farm", false, function(v) _G.AutoFarm = v end, "AutoFarm")
makeToggle(pg, "Auto Farm Nearest", false, function(v) _G.AutoFarmNearest = v end, "AutoFarmNearest")
makeToggle(pg, "Fast Attack", true, function(v) _G.FastAttack = v end, "FastAttack")
makeToggle(pg, "Bring Mobs", true, function(v) _G.BringMobs = v end, "BringMobs")

-- FRUIT (Tab 3)
pg = tabPages[3]
orderCounter = 0
makeSection(pg, "Fruits Configuration")
makeToggle(pg, "Auto Roll Fruit", false, function(v) _G.RandomAuto = v end, "RandomAuto")
makeToggle(pg, "Auto Store Fruit", false, function(v) _G.AutoStoreFruit = v end, "AutoStoreFruit")
makeToggle(pg, "Auto Tp To Fruit", false, function(v) _G.Tweenfruit = v end, "Tweenfruit")

-- STATS (Tab 4)
pg = tabPages[4]
orderCounter = 0
makeSection(pg, "Stats Configuration")
local statLabels = {}
local statTypes = {"Melee", "Defense", "Sword", "Gun", "Blox Fruit"}
for _, stat in ipairs(statTypes) do
    local r = Instance.new("Frame")
    r.Size = UDim2.new(1, 0, 0, 45)
    r.BackgroundColor3 = cardCol
    r.LayoutOrder = nextOrder()
    r.BorderSizePixel = 0
    r.Parent = pg
    mkC(r, 6)
    
    local name = Instance.new("TextLabel")
    name.Size = UDim2.new(0.4, 0, 1, 0)
    name.Position = UDim2.new(0, 12, 0, 0)
    name.Text = stat:upper()
    name.Font = Enum.Font.GothamBold
    name.TextSize = 12
    name.TextColor3 = txtCol
    name.TextXAlignment = Enum.TextXAlignment.Left
    name.BackgroundTransparency = 1
    name.Parent = r
    
    local value = Instance.new("TextLabel")
    value.Size = UDim2.new(0.3, 0, 1, 0)
    value.Position = UDim2.new(0.4, 0, 0, 0)
    value.Text = "0"
    value.Font = Enum.Font.GothamBold
    value.TextSize = 12
    value.TextColor3 = accent
    value.BackgroundTransparency = 1
    value.Parent = r
    statLabels[stat] = value
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 70, 0, 28)
    toggle.Position = UDim2.new(1, -82, 0.5, -14)
    toggle.BackgroundColor3 = dimCol
    toggle.Text = "OFF"
    toggle.Font = Enum.Font.GothamBlack
    toggle.TextSize = 11
    toggle.TextColor3 = txtCol
    toggle.BorderSizePixel = 0
    toggle.Parent = r
    mkC(toggle, 6)
    
    local enabled = false
    toggle.MouseButton1Click:Connect(function()
        enabled = not enabled
        toggle.Text = enabled and "ON" or "OFF"
        TS:Create(toggle, tw(0.2), {BackgroundColor3 = enabled and accent or dimCol}):Play()
        _G["AutoStat_"..stat] = enabled
    end)
end

-- TELEPORT (Tab 5)
pg = tabPages[5]
orderCounter = 0
makeSection(pg, "World Teleports")
makeButton(pg, "First Sea", function() if CommF_ then CommF_:InvokeServer("TravelMain") end end)
makeButton(pg, "Second Sea", function() if CommF_ then CommF_:InvokeServer("TravelDressrosa") end end)
makeButton(pg, "Third Sea", function() if CommF_ then CommF_:InvokeServer("TravelZou") end end)

makeSection(pg, "Island Teleports")
local ISLANDS
if First_Sea then
    ISLANDS = {{"Pirate Island", CFrame.new(1071, 16, 1427)}, {"Marine Island", CFrame.new(-2573, 7, 2047)}, {"Jungle", CFrame.new(-1250, 12, 341)}, {"Pirate Village", CFrame.new(-1122, 5, 3856)}, {"Desert", CFrame.new(1094, 6, 4193)}, {"Frozen Village", CFrame.new(1198, 27, -1212)}, {"Marine Fortress", CFrame.new(-4505, 21, 4261)}, {"Colosseum", CFrame.new(-1428, 7, -3014)}, {"Skylands", CFrame.new(-4970, 718, -2622)}, {"Prison", CFrame.new(4854, 6, 740)}, {"Magma Village", CFrame.new(-5232, 9, 8468)}, {"Underwater City", CFrame.new(61164, 12, 1820)}, {"Fountain City", CFrame.new(5133, 5, 4038)}}
elseif Second_Sea then
    ISLANDS = {{"Dock", CFrame.new(83, 18, 2835)}, {"Rose", CFrame.new(-395, 119, 1246)}, {"Green Zone", CFrame.new(-2372, 73, -3167)}, {"Factory", CFrame.new(430, 210, -433)}, {"Graveyard", CFrame.new(-5411, 49, -721)}, {"Snow Mountain", CFrame.new(512, 402, -5380)}, {"Hot/Cold", CFrame.new(-5478, 16, -5247)}, {"Cursed Ship", CFrame.new(902, 125, 33072)}, {"Ice Castle", CFrame.new(5400, 28, -6237)}, {"Forgotten Island", CFrame.new(-3043, 239, -10192)}}
elseif Third_Sea then
    ISLANDS = {{"Port Town", CFrame.new(-610, 58, 6436)}, {"Hydra Island", CFrame.new(5230, 604, 345)}, {"Great Tree", CFrame.new(2175, 29, -6729)}, {"Sea Castle", CFrame.new(-5478, 314, -2808)}, {"Turtle Island", CFrame.new(-10919, 332, -8638)}, {"Mansion", CFrame.new(-12554, 332, -7622)}, {"Haunted Ship", CFrame.new(-9531, -133, 5763)}, {"Chocolate Island", CFrame.new(157, 31, -12663)}, {"Ice Cream Island", CFrame.new(-949, 59, -10907)}, {"Cake Island", CFrame.new(-2099, 67, -12129)}, {"Tiki Outpost", CFrame.new(-16549, 56, -173)}}
end

if ISLANDS then
    for _, island in ipairs(ISLANDS) do
        makeButton(pg, island[1], function() if _G.BypassTP then BTP(island[2]) else Tween(island[2]) end end)
    end
end

-- VISUAL (Tab 6)
pg = tabPages[6]
orderCounter = 0
makeSection(pg, "ESP Options")
makeToggle(pg, "Players", false, function(v) _G.ESPPlayers = v; syncESP() end, "ESPPlayers")
makeToggle(pg, "Flowers", false, function(v) _G.ESPFlower = v end, "ESPFlower")
makeToggle(pg, "Fruits", false, function(v) _G.ESPFruit = v end, "ESPFruit")
makeToggle(pg, "NPCs", false, function(v) _G.ESPNPC = v end, "ESPNPC")
makeToggle(pg, "Bosses", false, function(v) _G.ESPBoss = v; syncESP() end, "ESPBoss")

-- SHOP (Tab 7)
pg = tabPages[7]
orderCounter = 0
makeSection(pg, "Swords & Guns")
local allWeapons = {
    {"Cutlass", 1000}, {"Katana", 1000}, {"Iron Mace", 10000}, {"Dual Katana", 12000}, {"Triple Katana", 60000},
    {"Slingshot", 5000}, {"Musket", 8000}, {"Flintlock", 10000}, {"Rifle", 30000}, {"Cannon", 100000}
}

for _, weapon in ipairs(allWeapons) do
    makeButton(pg, "Buy "..weapon[1].." ($"..weapon[2]..")", function()
        if CommF_ then CommF_:InvokeServer("BuyItem", weapon[1]) end
    end)
end

makeSection(pg, "Fighting Styles")
local styles = {
    {"Black Leg", "150,000", ""},
    {"Electro", "500,000", ""},
    {"Fishman Karate", "750,000", ""},
    {"Dragon Claw", "1,500,000", " + Fragments"},
    {"Superhuman", "3,000,000", " + Fragments"},
    {"Death Step", "2,500,000", " + 5,000 Fragments"},
    {"Sharkman Karate", "2,500,000", " + 5,000 Fragments"},
    {"Electric Claw", "3,000,000", " + 5,000 Fragments"},
    {"Dragon Talon", "3,000,000", " + 5,000 Fragments"},
    {"Godhuman", "5,000,000", " + 10,000 Fragments"}
}

for _, style in ipairs(styles) do
    local costText = "$"..style[2]..style[3]
    makeButton(pg, "Buy "..style[1].." ("..costText..")", function()
        if CommF_ then CommF_:InvokeServer("BuyFightingStyle", style[1]) end
    end)
end

-- MISC (Tab 8)
pg = tabPages[8]
orderCounter = 0
makeSection(pg, "Codes")
makeButton(pg, "Redeem All Codes", function()
    local codes = {"NOMOREHACK","BANEXPLOIT","WildDares","BossBuild","GetPranked","EARN_FRUITS","FIGHT4FRUIT","NOEXPLOITER","NOOB2ADMIN","CODESLIDE","ADMINHACKED","ADMINDARES","fruitconcepts","krazydares","TRIPLEABUSE","SEATROLLING","24NOADMIN","REWARDFUN","Chandler","NEWTROLL","KITT_RESET","Sub2CaptainMaui","kittgaming","Sub2Fer999","Enyu_is_Pro","Magicbus","JCWK","Starcodeheo","Bluxxy","fudd10_v2","SUB2GAMERROBOT_EXP1","Sub2NoobMaster123","Sub2UncleKizaru","Sub2Daigrock","Axiore","TantaiGaming","StrawHatMaine","Sub2OfficialNoobie","Fudd10","Bignews","TheGreatAce"}
    for _, c in ipairs(codes) do
        pcall(function() RS.Remotes.Redeem:InvokeServer(c) end)
        task.wait(0.2)
    end
end)

makeSection(pg, "Utilities")
makeToggle(pg, "Bypass Teleport", false, function(v) _G.BypassTP = v end, "BypassTP")
makeToggle(pg, "Walk on Water", true, function(v)
    _G.WalkWater = v
    if v then pcall(function() WS.Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000) end)
    else pcall(function() WS.Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000) end) end
end, "WalkWater")
makeToggle(pg, "FPS Boost", false, function(v) if v then pcall(function() settings().Rendering.QualityLevel = "Level01" end) end end, "FPSBoost")

-- ==================== BACKEND SYSTEMS ====================

-- ESP SYSTEM
local espObjects = {}
local espConnection = nil
local pathDestination = nil
local pathFolder = Instance.new("Folder")
pathFolder.Name = "HunterPath"
pathFolder.Parent = WS

local pathA = Instance.new("Part")
pathA.Anchored = true; pathA.CanCollide = false; pathA.Transparency = 1; pathA.Size = Vector3.new(0.1, 0.1, 0.1); pathA.Parent = pathFolder
local pathB = Instance.new("Part")
pathB.Anchored = true; pathB.CanCollide = false; pathB.Transparency = 1; pathB.Size = Vector3.new(0.1, 0.1, 0.1); pathB.Parent = pathFolder

local attA = Instance.new("Attachment", pathA)
local attB = Instance.new("Attachment", pathB)

local pathBeam = Instance.new("Beam")
pathBeam.Attachment0 = attA; pathBeam.Attachment1 = attB; pathBeam.Color = ColorSequence.new(accent, accentGlow)
pathBeam.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(0.8, 0.5), NumberSequenceKeypoint.new(1, 0.8)})
pathBeam.Width0 = 0.35; pathBeam.Width1 = 0.15; pathBeam.FaceCamera = true; pathBeam.TextureLength = 4; pathBeam.TextureSpeed = 1.5; pathBeam.LightEmission = 0.4; pathBeam.Segments = 30; pathBeam.Enabled = false; pathBeam.Parent = pathFolder

local destMarker = Instance.new("Part")
destMarker.Anchored = true; destMarker.CanCollide = false; destMarker.Shape = Enum.PartType.Ball; destMarker.Size = Vector3.new(1.6, 1.6, 1.6); destMarker.Material = Enum.Material.Neon; destMarker.Color = accent; destMarker.Transparency = 1; destMarker.Parent = pathFolder

local destBB = Instance.new("BillboardGui")
destBB.Size = UDim2.new(0, 60, 0, 16); destBB.StudsOffset = Vector3.new(0, 2, 0); destBB.AlwaysOnTop = true; destBB.Adornee = destMarker; destBB.Parent = destMarker

local destLbl = Instance.new("TextLabel")
destLbl.Size = UDim2.new(1, 0, 1, 0); destLbl.BackgroundTransparency = 1; destLbl.Font = Enum.Font.GothamBold; destLbl.TextSize = 9; destLbl.TextColor3 = accent; destLbl.TextStrokeTransparency = 0.4; destLbl.TextStrokeColor3 = Color3.new(0, 0, 0); destLbl.Text = ""; destLbl.Parent = destBB

local function showPath(destCF)
    if not destCF then pathBeam.Enabled = false; destMarker.Transparency = 1; destLbl.Text = ""; return end
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then pathBeam.Enabled = false; return end
    local pPos = Player.Character.HumanoidRootPart.Position
    local dPos = destCF.Position
    local dist = (dPos - pPos).Magnitude
    if dist < 8 then pathBeam.Enabled = false; destMarker.Transparency = 1; destLbl.Text = ""; return end
    pathA.CFrame = CFrame.new(pPos + Vector3.new(0, 2, 0))
    pathB.CFrame = CFrame.new(dPos + Vector3.new(0, 3, 0))
    pathBeam.Enabled = true
    destMarker.CFrame = CFrame.new(dPos + Vector3.new(0, 3, 0))
    destMarker.Transparency = 0.3
    destLbl.Text = math.floor(dist) .. " studs"
end

local function hidePath()
    pathBeam.Enabled = false; destMarker.Transparency = 1; destLbl.Text = ""
    pathA.CFrame = CFrame.new(0, -500, 0); pathB.CFrame = CFrame.new(0, -500, 0)
end

local TRACER_POOL_SIZE = 24
local tracerPool = {}
local tracerInUse = 0
for i = 1, TRACER_POOL_SIZE do
    local line = Instance.new("Frame")
    line.Name = "Tracer"..i; line.AnchorPoint = Vector2.new(0, 0.5); line.BackgroundColor3 = accent; line.BackgroundTransparency = 0.4; line.BorderSizePixel = 0; line.Size = UDim2.new(0, 0, 0, 1); line.Visible = false; line.ZIndex = 1; line.Parent = espGui
    tracerPool[i] = line
end

local function hideAllTracers()
    for i = 1, TRACER_POOL_SIZE do tracerPool[i].Visible = false; tracerPool[i].Size = UDim2.new(0, 0, 0, 1) end
    tracerInUse = 0
end

local function claimTracer()
    tracerInUse = tracerInUse + 1
    if tracerInUse > TRACER_POOL_SIZE then return nil end
    return tracerPool[tracerInUse]
end

local function isAnyFarmActive()
    return _G.AutoFarm or _G.AutoFarmNearest or _G.ESPPlayers or _G.ESPBoss
end

local function worldToScreen(pos)
    local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
    return Vector2.new(screenPos.X, screenPos.Y), onScreen
end

local function createESPForTarget(model, tag)
    if not model or not model:FindFirstChild("HumanoidRootPart") then return end
    local id = tostring(model) .. model.Name
    if espObjects[id] then espObjects[id].tag = tag; return end
    
    local hl = Instance.new("Highlight")
    hl.Name = "HunterESP"; hl.FillColor = tag == "playeraura" and Color3.fromRGB(255, 80, 80) or accent; hl.FillTransparency = 0.7; hl.OutlineColor = tag == "playeraura" and Color3.fromRGB(255, 100, 100) or accentGlow; hl.OutlineTransparency = 0.3; hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; hl.Adornee = model; hl.Parent = model
    
    local bb = Instance.new("BillboardGui")
    bb.Name = "HunterESPLabel"; bb.Size = UDim2.new(0, 160, 0, 20); bb.StudsOffset = Vector3.new(0, 3.5, 0); bb.AlwaysOnTop = true; bb.Adornee = model:FindFirstChild("Head") or model:FindFirstChild("HumanoidRootPart"); bb.Parent = model
    
    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, 0, 1, 0); nameLbl.BackgroundTransparency = 1; nameLbl.Font = Enum.Font.GothamBold; nameLbl.TextSize = 10; nameLbl.TextColor3 = tag == "playeraura" and Color3.fromRGB(255, 100, 100) or accent; nameLbl.TextStrokeTransparency = 0.4; nameLbl.TextStrokeColor3 = Color3.new(0, 0, 0); nameLbl.Parent = bb
    
    local hum = model:FindFirstChild("Humanoid")
    nameLbl.Text = (model.Parent and model.Parent.Name or model.Name) .. " [" .. (hum and math.floor(hum.Health) or "?") .. "/" .. (hum and math.floor(hum.MaxHealth) or "?") .. "]"
    espObjects[id] = {highlight = hl, billboard = bb, nameLabel = nameLbl, model = model, tag = tag}
end

local function removeESPForTarget(model)
    local id = tostring(model) .. model.Name
    local entry = espObjects[id]
    if entry then
        pcall(function() if entry.highlight then entry.highlight:Destroy() end end)
        pcall(function() if entry.billboard then entry.billboard:Destroy() end end)
        espObjects[id] = nil
    end
end

local function espRenderStep()
    if not (_G.ESPPlayers or _G.ESPBoss) then hideAllTracers(); hidePath(); return end
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then hideAllTracers(); hidePath(); return end
    hideAllTracers()
    
    local viewportSize = Camera.ViewportSize
    local screenCenter = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    local toRemove = {}
    
    for id, entry in pairs(espObjects) do
        if entry.model and entry.model.Parent and entry.model:FindFirstChild("HumanoidRootPart") then
            local hrp = entry.model.HumanoidRootPart
            pcall(function()
                local hum = entry.model:FindFirstChild("Humanoid")
                if hum and entry.nameLabel then entry.nameLabel.Text = (entry.model.Parent and entry.model.Parent.Name or entry.model.Name) .. " [" .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth) .. "]" end
            end)
            local screenPos, onScreen = worldToScreen(hrp.Position)
            if onScreen then
                local dx = screenPos.X - screenCenter.X
                local dy = screenPos.Y - screenCenter.Y
                local dist = math.sqrt(dx * dx + dy * dy)
                if dist > 8 then
                    local line = claimTracer()
                    if line then
                        line.Position = UDim2.new(0, screenCenter.X, 0, screenCenter.Y)
                        line.Size = UDim2.new(0, dist, 0, 1)
                        line.Rotation = math.deg(math.atan2(dy, dx))
                        line.BackgroundColor3 = entry.tag == "playeraura" and Color3.fromRGB(255, 100, 100) or accent
                        line.Visible = true
                    end
                end
            end
        else table.insert(toRemove, id) end
    end
    
    for _, id in ipairs(toRemove) do local entry = espObjects[id]; if entry then removeESPForTarget(entry.model) end end
    showPath(pathDestination)
end

local function startESPLoop()
    if espConnection then return end
    espConnection = RunService.RenderStepped:Connect(espRenderStep)
end

function cleanupAllESP()
    for _, obj in pairs(espObjects) do
        pcall(function() if obj.highlight then obj.highlight:Destroy() end end)
        pcall(function() if obj.billboard then obj.billboard:Destroy() end end)
    end
    espObjects = {}
    hideAllTracers(); hidePath(); pathDestination = nil
    if espConnection then pcall(function() espConnection:Disconnect() end); espConnection = nil end
end

local function syncESP()
    if isAnyFarmActive() then startESPLoop() else cleanupAllESP() end
end

-- TELEPORT SYSTEM
local activeTweenCount = 0
local activeTween = nil

function Tween(P)
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
    local D = (P.Position - Player.Character.HumanoidRootPart.Position).Magnitude
    if D > 1 then
        if activeTween then activeTween:Cancel(); activeTweenCount = 0 end
        local tween = TS:Create(Player.Character.HumanoidRootPart, TweenInfo.new(D / 350, Enum.EasingStyle.Linear), {CFrame = P})
        pathDestination = P; activeTweenCount = 1; activeTween = tween
        tween:Play()
        tween.Completed:Connect(function()
            activeTweenCount = 0; activeTween = nil
            if pathDestination == P then pathDestination = nil end
        end)
    end
end

function BTP(T)
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = Player.Character.HumanoidRootPart
    local totalDist = (T.Position - hrp.Position).Magnitude
    if totalDist > 2000 then
        local dir = (T.Position - hrp.Position).Unit
        local steps = math.ceil(totalDist / 300)
        for i = 1, steps do
            local targetPos = hrp.Position + dir * math.min(300, totalDist)
            hrp.CFrame = CFrame.new(targetPos)
            if CommF_ then CommF_:InvokeServer("SetSpawnPoint") end
            totalDist = totalDist - 300
            task.wait(0.2)
        end
        hrp.CFrame = T; pathDestination = nil; activeTweenCount = 0
    else Tween(T) end
end

-- COMBAT SYSTEM
SelectWeapon = "Combat"
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            for _, v in pairs(Player.Backpack:GetChildren()) do
                if v:IsA("Tool") and (v.ToolTip == "Melee" or v.ToolTip == "Sword") then SelectWeapon = v.Name; break end
            end
        end)
    end
end)

function EquipTool(T)
    pcall(function()
        if Player.Character:FindFirstChildOfClass("Tool") then return end
        for _, v in pairs(Player.Backpack:GetChildren()) do
            if v:IsA("Tool") then
                if T and v.Name == T or not T then Player.Character.Humanoid:EquipTool(v); return end
            end
        end
    end)
end

function getHead()
    local r = {}
    for _, v in pairs(WS.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("Head") and (v.Head.Position - Player.Character.HumanoidRootPart.Position).Magnitude < 70 then
            table.insert(r, v.HumanoidRootPart)
        end
    end
    return r
end

function FastAttacked()
    local h = getHead()
    local RA = RS.Modules.Net["RE/RegisterAttack"]
    local RH = RS.Modules.Net["RE/RegisterHit"]
    for i = 1, #h do
        pcall(function()
            local t = Player.Character:FindFirstChildOfClass("Tool")
            if t and (t.ToolTip == "Melee" or t.ToolTip == "Sword") then
                RA:FireServer(0.0000001); RH:FireServer(h[i], {})
                pcall(function() sethiddenproperty(Player, "SimulationRadius", math.huge) end)
            end
        end)
    end
end

function BringMonster(N, CF)
    for _, v in pairs(WS.Enemies:GetChildren()) do
        if v.Name == N and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude < 250 then
            v.HumanoidRootPart.CFrame = CF; v.HumanoidRootPart.CanCollide = false; v.HumanoidRootPart.Size = Vector3.new(60, 60, 60); v.HumanoidRootPart.Transparency = 1
            v.Humanoid:ChangeState(11); v.Humanoid:ChangeState(14)
            if v.Humanoid:FindFirstChild("Animator") then v.Humanoid.Animator:Destroy() end
        end
    end
    pcall(function() sethiddenproperty(Player, "SimulationRadius", math.huge) end)
end

-- QUEST DATA
function CheckQuest()
    local MyLevel = Player.Data.Level.Value
    if First_Sea then
        if MyLevel <= 9 then Mon = "Bandit"; NameQuest = "BanditQuest1"; LevelQuest = 1; NameMon = "Bandit"; CFrameQuest = CFrame.new(1059.37, 15.45, 1550.42); CFrameMon = CFrame.new(1045.96, 27.00, 1560.82)
        elseif MyLevel <= 14 then Mon = "Monkey"; NameQuest = "JungleQuest"; LevelQuest = 1; NameMon = "Monkey"; CFrameQuest = CFrame.new(-1598.09, 35.55, 153.38); CFrameMon = CFrame.new(-1448.52, 67.85, 11.47)
        elseif MyLevel <= 29 then Mon = "Gorilla"; NameQuest = "JungleQuest"; LevelQuest = 2; NameMon = "Gorilla"; CFrameQuest = CFrame.new(-1598.09, 35.55, 153.38); CFrameMon = CFrame.new(-1129.88, 40.46, -525.42)
        elseif MyLevel <= 39 then Mon = "Pirate"; NameQuest = "BuggyQuest1"; LevelQuest = 1; NameMon = "Pirate"; CFrameQuest = CFrame.new(-1141.07, 4.10, 3831.55); CFrameMon = CFrame.new(-1103.51, 13.75, 3896.09)
        elseif MyLevel <= 59 then Mon = "Brute"; NameQuest = "BuggyQuest1"; LevelQuest = 2; NameMon = "Brute"; CFrameQuest = CFrame.new(-1141.07, 4.10, 3831.55); CFrameMon = CFrame.new(-1140.08, 14.81, 4322.92)
        elseif MyLevel <= 74 then Mon = "Desert Bandit"; NameQuest = "DesertQuest"; LevelQuest = 1; NameMon = "Desert Bandit"; CFrameQuest = CFrame.new(894.49, 5.14, 4392.43); CFrameMon = CFrame.new(924.80, 6.45, 4481.59)
        elseif MyLevel <= 89 then Mon = "Desert Officer"; NameQuest = "DesertQuest"; LevelQuest = 2; NameMon = "Desert Officer"; CFrameQuest = CFrame.new(894.49, 5.14, 4392.43); CFrameMon = CFrame.new(1608.28, 8.61, 4371.01)
        elseif MyLevel <= 99 then Mon = "Snow Bandit"; NameQuest = "SnowQuest"; LevelQuest = 1; NameMon = "Snow Bandit"; CFrameQuest = CFrame.new(1389.74, 88.15, -1298.91); CFrameMon = CFrame.new(1354.35, 87.27, -1393.95)
        elseif MyLevel <= 119 then Mon = "Snowman"; NameQuest = "SnowQuest"; LevelQuest = 2; NameMon = "Snowman"; CFrameQuest = CFrame.new(1389.74, 88.15, -1298.91); CFrameMon = CFrame.new(1201.64, 144.58, -1550.07)
        elseif MyLevel <= 149 then Mon = "Chief Petty Officer"; NameQuest = "MarineQuest2"; LevelQuest = 1; NameMon = "Chief Petty Officer"; CFrameQuest = CFrame.new(-5039.59, 27.35, 4324.68); CFrameMon = CFrame.new(-4881.23, 22.65, 4273.75)
        elseif MyLevel <= 174 then Mon = "Sky Bandit"; NameQuest = "SkyQuest"; LevelQuest = 1; NameMon = "Sky Bandit"; CFrameQuest = CFrame.new(-4839.53, 716.37, -2619.44); CFrameMon = CFrame.new(-4953.21, 295.74, -2899.23)
        elseif MyLevel <= 189 then Mon = "Dark Master"; NameQuest = "SkyQuest"; LevelQuest = 2; NameMon = "Dark Master"; CFrameQuest = CFrame.new(-4839.53, 716.37, -2619.44); CFrameMon = CFrame.new(-5259.84, 391.40, -2229.04)
        elseif MyLevel <= 209 then Mon = "Prisoner"; NameQuest = "PrisonerQuest"; LevelQuest = 1; NameMon = "Prisoner"; CFrameQuest = CFrame.new(5308.93, 1.66, 475.12); CFrameMon = CFrame.new(5098.97, -0.32, 474.24)
        elseif MyLevel <= 249 then Mon = "Dangerous Prisoner"; NameQuest = "PrisonerQuest"; LevelQuest = 2; NameMon = "Dangerous Prisoner"; CFrameQuest = CFrame.new(5308.93, 1.66, 475.12); CFrameMon = CFrame.new(5654.56, 15.63, 866.30)
        elseif MyLevel <= 274 then Mon = "Toga Warrior"; NameQuest = "ColosseumQuest"; LevelQuest = 1; NameMon = "Toga Warrior"; CFrameQuest = CFrame.new(-1580.05, 6.35, -2986.48); CFrameMon = CFrame.new(-1820.21, 51.68, -2740.67)
        elseif MyLevel <= 299 then Mon = "Gladiator"; NameQuest = "ColosseumQuest"; LevelQuest = 2; NameMon = "Gladiator"; CFrameQuest = CFrame.new(-1580.05, 6.35, -2986.48); CFrameMon = CFrame.new(-1292.84, 56.38, -3339.03)
        elseif MyLevel <= 324 then Mon = "Military Soldier"; NameQuest = "MagmaQuest"; LevelQuest = 1; NameMon = "Military Soldier"; CFrameQuest = CFrame.new(-5313.37, 10.95, 8515.29); CFrameMon = CFrame.new(-5411.16, 11.08, 8454.29)
        elseif MyLevel <= 374 then Mon = "Military Spy"; NameQuest = "MagmaQuest"; LevelQuest = 2; NameMon = "Military Spy"; CFrameQuest = CFrame.new(-5313.37, 10.95, 8515.29); CFrameMon = CFrame.new(-5802.87, 86.26, 8828.86)
        elseif MyLevel <= 399 then Mon = "Fishman Warrior"; NameQuest = "FishmanQuest"; LevelQuest = 1; NameMon = "Fishman Warrior"; CFrameQuest = CFrame.new(61122.65, 18.50, 1569.40); CFrameMon = CFrame.new(60878.30, 18.48, 1543.76)
        elseif MyLevel <= 449 then Mon = "Fishman Commando"; NameQuest = "FishmanQuest"; LevelQuest = 2; NameMon = "Fishman Commando"; CFrameQuest = CFrame.new(61122.65, 18.50, 1569.40); CFrameMon = CFrame.new(61922.63, 18.48, 1493.93)
        elseif MyLevel <= 474 then Mon = "God's Guard"; NameQuest = "SkyExp1Quest"; LevelQuest = 1; NameMon = "God's Guard"; CFrameQuest = CFrame.new(-4721.89, 843.87, -1949.97); CFrameMon = CFrame.new(-4710.04, 845.28, -1927.31)
        elseif MyLevel <= 524 then Mon = "Shanda"; NameQuest = "SkyExp1Quest"; LevelQuest = 2; NameMon = "Shanda"; CFrameQuest = CFrame.new(-7859.10, 5544.19, -381.48); CFrameMon = CFrame.new(-7678.49, 5566.40, -497.22)
        elseif MyLevel <= 549 then Mon = "Royal Squad"; NameQuest = "SkyExp2Quest"; LevelQuest = 1; NameMon = "Royal Squad"; CFrameQuest = CFrame.new(-7906.82, 5634.66, -1411.99); CFrameMon = CFrame.new(-7624.25, 5658.13, -1467.35)
        elseif MyLevel <= 624 then Mon = "Royal Soldier"; NameQuest = "SkyExp2Quest"; LevelQuest = 2; NameMon = "Royal Soldier"; CFrameQuest = CFrame.new(-7906.82, 5634.66, -1411.99); CFrameMon = CFrame.new(-7836.75, 5645.66, -1790.62)
        elseif MyLevel <= 649 then Mon = "Galley Pirate"; NameQuest = "FountainQuest"; LevelQuest = 1; NameMon = "Galley Pirate"; CFrameQuest = CFrame.new(5259.82, 37.35, 4050.03); CFrameMon = CFrame.new(5551.02, 78.90, 3930.41)
        else Mon = "Galley Captain"; NameQuest = "FountainQuest"; LevelQuest = 2; NameMon = "Galley Captain"; CFrameQuest = CFrame.new(5259.82, 37.35, 4050.03); CFrameMon = CFrame.new(5441.95, 42.50, 4950.09) end
    elseif Second_Sea then
        if MyLevel <= 724 then Mon = "Raider"; NameQuest = "Area1Quest"; LevelQuest = 1; NameMon = "Raider"; CFrameQuest = CFrame.new(-429.54, 71.77, 1836.18); CFrameMon = CFrame.new(-728.33, 52.78, 2345.77)
        elseif MyLevel <= 774 then Mon = "Mercenary"; NameQuest = "Area1Quest"; LevelQuest = 2; NameMon = "Mercenary"; CFrameQuest = CFrame.new(-429.54, 71.77, 1836.18); CFrameMon = CFrame.new(-1004.32, 80.16, 1424.62)
        elseif MyLevel <= 799 then Mon = "Swan Pirate"; NameQuest = "Area2Quest"; LevelQuest = 1; NameMon = "Swan Pirate"; CFrameQuest = CFrame.new(638.44, 71.77, 918.28); CFrameMon = CFrame.new(1068.66, 137.61, 1322.11)
        elseif MyLevel <= 874 then Mon = "Factory Staff"; NameQuest = "Area2Quest"; LevelQuest = 2; NameMon = "Factory Staff"; CFrameQuest = CFrame.new(632.70, 73.11, 918.67); CFrameMon = CFrame.new(73.08, 81.86, -27.47)
        elseif MyLevel <= 899 then Mon = "Marine Lieutenant"; NameQuest = "MarineQuest3"; LevelQuest = 1; NameMon = "Marine Lieutenant"; CFrameQuest = CFrame.new(-2440.80, 71.71, -3216.07); CFrameMon = CFrame.new(-2821.37, 75.90, -3070.09)
        elseif MyLevel <= 949 then Mon = "Marine Captain"; NameQuest = "MarineQuest3"; LevelQuest = 2; NameMon = "Marine Captain"; CFrameQuest = CFrame.new(-2440.80, 71.71, -3216.07); CFrameMon = CFrame.new(-1861.23, 80.18, -3254.70)
        elseif MyLevel <= 974 then Mon = "Zombie"; NameQuest = "ZombieQuest"; LevelQuest = 1; NameMon = "Zombie"; CFrameQuest = CFrame.new(-5497.06, 47.59, -795.24); CFrameMon = CFrame.new(-5657.78, 78.97, -928.69)
        elseif MyLevel <= 999 then Mon = "Vampire"; NameQuest = "ZombieQuest"; LevelQuest = 2; NameMon = "Vampire"; CFrameQuest = CFrame.new(-5497.06, 47.59, -795.24); CFrameMon = CFrame.new(-6037.67, 32.18, -1340.66)
        elseif MyLevel <= 1049 then Mon = "Snow Trooper"; NameQuest = "SnowMountainQuest"; LevelQuest = 1; NameMon = "Snow Trooper"; CFrameQuest = CFrame.new(609.86, 400.12, -5372.26); CFrameMon = CFrame.new(549.15, 427.39, -5563.70)
        elseif MyLevel <= 1099 then Mon = "Winter Warrior"; NameQuest = "SnowMountainQuest"; LevelQuest = 2; NameMon = "Winter Warrior"; CFrameQuest = CFrame.new(609.86, 400.12, -5372.26); CFrameMon = CFrame.new(1142.75, 475.64, -5199.42)
        elseif MyLevel <= 1124 then Mon = "Lab Subordinate"; NameQuest = "IceSideQuest"; LevelQuest = 1; NameMon = "Lab Subordinate"; CFrameQuest = CFrame.new(-6064.07, 15.24, -4902.98); CFrameMon = CFrame.new(-5707.47, 15.95, -4513.39)
        elseif MyLevel <= 1174 then Mon = "Horned Warrior"; NameQuest = "IceSideQuest"; LevelQuest = 2; NameMon = "Horned Warrior"; CFrameQuest = CFrame.new(-6064.07, 15.24, -4902.98); CFrameMon = CFrame.new(-6341.37, 15.95, -5723.16)
        elseif MyLevel <= 1199 then Mon = "Magma Ninja"; NameQuest = "FireSideQuest"; LevelQuest = 1; NameMon = "Magma Ninja"; CFrameQuest = CFrame.new(-5428.03, 15.06, -5299.43); CFrameMon = CFrame.new(-5449.67, 76.66, -5808.20)
        elseif MyLevel <= 1249 then Mon = "Lava Pirate"; NameQuest = "FireSideQuest"; LevelQuest = 2; NameMon = "Lava Pirate"; CFrameQuest = CFrame.new(-5428.03, 15.06, -5299.43); CFrameMon = CFrame.new(-5213.33, 49.74, -4701.45)
        elseif MyLevel <= 1274 then Mon = "Ship Deckhand"; NameQuest = "ShipQuest1"; LevelQuest = 1; NameMon = "Ship Deckhand"; CFrameQuest = CFrame.new(1037.80, 125.09, 32911.60); CFrameMon = CFrame.new(1212.01, 150.79, 33059.25)
        elseif MyLevel <= 1299 then Mon = "Ship Engineer"; NameQuest = "ShipQuest1"; LevelQuest = 2; NameMon = "Ship Engineer"; CFrameQuest = CFrame.new(1037.80, 125.09, 32911.60); CFrameMon = CFrame.new(919.48, 43.54, 32779.97)
        elseif MyLevel <= 1324 then Mon = "Ship Steward"; NameQuest = "ShipQuest2"; LevelQuest = 1; NameMon = "Ship Steward"; CFrameQuest = CFrame.new(968.81, 125.09, 33244.13); CFrameMon = CFrame.new(919.44, 129.56, 33436.04)
        elseif MyLevel <= 1349 then Mon = "Ship Officer"; NameQuest = "ShipQuest2"; LevelQuest = 2; NameMon = "Ship Officer"; CFrameQuest = CFrame.new(968.81, 125.09, 33244.13); CFrameMon = CFrame.new(1036.02, 181.44, 33315.73)
        elseif MyLevel <= 1374 then Mon = "Arctic Warrior"; NameQuest = "FrostQuest"; LevelQuest = 1; NameMon = "Arctic Warrior"; CFrameQuest = CFrame.new(5667.66, 26.80, -6486.09); CFrameMon = CFrame.new(5966.25, 62.97, -6179.38)
        elseif MyLevel <= 1424 then Mon = "Snow Lurker"; NameQuest = "FrostQuest"; LevelQuest = 2; NameMon = "Snow Lurker"; CFrameQuest = CFrame.new(5667.66, 26.80, -6486.09); CFrameMon = CFrame.new(5407.07, 69.19, -6880.88)
        elseif MyLevel <= 1449 then Mon = "Sea Soldier"; NameQuest = "ForgottenQuest"; LevelQuest = 1; NameMon = "Sea Soldier"; CFrameQuest = CFrame.new(-3054.44, 235.54, -10142.82); CFrameMon = CFrame.new(-3028.22, 64.67, -9775.43)
        else Mon = "Water Fighter"; NameQuest = "ForgottenQuest"; LevelQuest = 2; NameMon = "Water Fighter"; CFrameQuest = CFrame.new(-3054.44, 235.54, -10142.82); CFrameMon = CFrame.new(-3352.90, 285.02, -10534.84) end
    elseif Third_Sea then
        if MyLevel <= 1524 then Mon = "Pirate Millionaire"; NameQuest = "PiratePortQuest"; LevelQuest = 1; NameMon = "Pirate Millionaire"; CFrameQuest = CFrame.new(-450.10, 107.68, 5950.73); CFrameMon = CFrame.new(-246.00, 47.31, 5584.10)
        elseif MyLevel <= 1574 then Mon = "Pistol Billionaire"; NameQuest = "PiratePortQuest"; LevelQuest = 2; NameMon = "Pistol Billionaire"; CFrameQuest = CFrame.new(-450.10, 107.68, 5950.73); CFrameMon = CFrame.new(-54.81, 83.77, 5947.84)
        elseif MyLevel <= 1599 then Mon = "Dragon Crew Warrior"; NameQuest = "DragonCrewQuest"; LevelQuest = 1; NameMon = "Dragon Crew Warrior"; CFrameQuest = CFrame.new(6750.49, 127.45, -711.03); CFrameMon = CFrame.new(6709.76, 52.34, -1139.03)
        elseif MyLevel <= 1624 then Mon = "Dragon Crew Archer"; NameQuest = "DragonCrewQuest"; LevelQuest = 2; NameMon = "Dragon Crew Archer"; CFrameQuest = CFrame.new(6750.49, 127.45, -711.03); CFrameMon = CFrame.new(6668.76, 481.38, 329.12)
        elseif MyLevel <= 1649 then Mon = "Hydra Enforcer"; NameQuest = "VenomCrewQuest"; LevelQuest = 1; NameMon = "Hydra Enforcer"; CFrameQuest = CFrame.new(5206.40, 1004.10, 748.35); CFrameMon = CFrame.new(4547.12, 1003.10, 334.19)
        elseif MyLevel <= 1699 then Mon = "Venomous Assailant"; NameQuest = "VenomCrewQuest"; LevelQuest = 2; NameMon = "Venomous Assailant"; CFrameQuest = CFrame.new(5206.40, 1004.10, 748.35); CFrameMon = CFrame.new(4674.93, 1134.83, 996.31)
        elseif MyLevel <= 1724 then Mon = "Marine Commodore"; NameQuest = "MarineTreeIsland"; LevelQuest = 1; NameMon = "Marine Commodore"; CFrameQuest = CFrame.new(2481.09, 74.27, -6779.64); CFrameMon = CFrame.new(2577.25, 75.61, -7739.87)
        elseif MyLevel <= 1774 then Mon = "Marine Rear Admiral"; NameQuest = "MarineTreeIsland"; LevelQuest = 2; NameMon = "Marine Rear Admiral"; CFrameQuest = CFrame.new(2481.09, 74.27, -6779.64); CFrameMon = CFrame.new(3761.81, 123.91, -6823.52)
        elseif MyLevel <= 1799 then Mon = "Fishman Raider"; NameQuest = "DeepForestIsland3"; LevelQuest = 1; NameMon = "Fishman Raider"; CFrameQuest = CFrame.new(-10581.66, 330.87, -8761.19); CFrameMon = CFrame.new(-10407.53, 331.76, -8368.52)
        elseif MyLevel <= 1824 then Mon = "Fishman Captain"; NameQuest = "DeepForestIsland3"; LevelQuest = 2; NameMon = "Fishman Captain"; CFrameQuest = CFrame.new(-10581.66, 330.87, -8761.19); CFrameMon = CFrame.new(-10994.70, 352.38, -9002.11)
        elseif MyLevel <= 1849 then Mon = "Forest Pirate"; NameQuest = "DeepForestIsland"; LevelQuest = 1; NameMon = "Forest Pirate"; CFrameQuest = CFrame.new(-13234.04, 331.49, -7625.40); CFrameMon = CFrame.new(-13274.48, 332.38, -7769.58)
        elseif MyLevel <= 1899 then Mon = "Mythological Pirate"; NameQuest = "DeepForestIsland"; LevelQuest = 2; NameMon = "Mythological Pirate"; CFrameQuest = CFrame.new(-13234.04, 331.49, -7625.40); CFrameMon = CFrame.new(-13680.61, 501.08, -6991.19)
        elseif MyLevel <= 1924 then Mon = "Jungle Pirate"; NameQuest = "DeepForestIsland2"; LevelQuest = 1; NameMon = "Jungle Pirate"; CFrameQuest = CFrame.new(-12680.38, 389.97, -9902.02); CFrameMon = CFrame.new(-12256.16, 331.74, -10485.84)
        elseif MyLevel <= 1974 then Mon = "Musketeer Pirate"; NameQuest = "DeepForestIsland2"; LevelQuest = 2; NameMon = "Musketeer Pirate"; CFrameQuest = CFrame.new(-12680.38, 389.97, -9902.02); CFrameMon = CFrame.new(-13457.90, 391.55, -9859.18)
        elseif MyLevel <= 1999 then Mon = "Reborn Skeleton"; NameQuest = "HauntedQuest1"; LevelQuest = 1; NameMon = "Reborn Skeleton"; CFrameQuest = CFrame.new(-9479.22, 141.22, 5566.09); CFrameMon = CFrame.new(-8763.72, 165.72, 6159.86)
        elseif MyLevel <= 2024 then Mon = "Living Zombie"; NameQuest = "HauntedQuest1"; LevelQuest = 2; NameMon = "Living Zombie"; CFrameQuest = CFrame.new(-9479.22, 141.22, 5566.09); CFrameMon = CFrame.new(-10144.13, 138.63, 5838.09)
        elseif MyLevel <= 2049 then Mon = "Demonic Soul"; NameQuest = "HauntedQuest2"; LevelQuest = 1; NameMon = "Demonic Soul"; CFrameQuest = CFrame.new(-9516.99, 172.02, 6078.47); CFrameMon = CFrame.new(-9505.87, 172.10, 6158.99)
        elseif MyLevel <= 2074 then Mon = "Posessed Mummy"; NameQuest = "HauntedQuest2"; LevelQuest = 2; NameMon = "Posessed Mummy"; CFrameQuest = CFrame.new(-9516.99, 172.02, 6078.47); CFrameMon = CFrame.new(-9582.02, 6.25, 6205.48)
        elseif MyLevel <= 2099 then Mon = "Peanut Scout"; NameQuest = "NutsIslandQuest"; LevelQuest = 1; NameMon = "Peanut Scout"; CFrameQuest = CFrame.new(-2104.39, 38.10, -10194.22); CFrameMon = CFrame.new(-2143.24, 47.72, -10030.00)
        elseif MyLevel <= 2124 then Mon = "Peanut President"; NameQuest = "NutsIslandQuest"; LevelQuest = 2; NameMon = "Peanut President"; CFrameQuest = CFrame.new(-2104.39, 38.10, -10194.22); CFrameMon = CFrame.new(-1859.35, 38.10, -10422.43)
        elseif MyLevel <= 2149 then Mon = "Ice Cream Chef"; NameQuest = "IceCreamIslandQuest"; LevelQuest = 1; NameMon = "Ice Cream Chef"; CFrameQuest = CFrame.new(-820.65, 65.82, -10965.80); CFrameMon = CFrame.new(-872.25, 65.82, -10919.96)
        elseif MyLevel <= 2199 then Mon = "Ice Cream Commander"; NameQuest = "IceCreamIslandQuest"; LevelQuest = 2; NameMon = "Ice Cream Commander"; CFrameQuest = CFrame.new(-820.65, 65.82, -10965.80); CFrameMon = CFrame.new(-558.06, 112.05, -11290.77)
        elseif MyLevel <= 2224 then Mon = "Cookie Crafter"; NameQuest = "CakeQuest1"; LevelQuest = 1; NameMon = "Cookie Crafter"; CFrameQuest = CFrame.new(-2021.32, 37.80, -12028.73); CFrameMon = CFrame.new(-2374.14, 37.80, -12125.31)
        elseif MyLevel <= 2249 then Mon = "Cake Guard"; NameQuest = "CakeQuest1"; LevelQuest = 2; NameMon = "Cake Guard"; CFrameQuest = CFrame.new(-2021.32, 37.80, -12028.73); CFrameMon = CFrame.new(-1598.31, 43.77, -12244.58)
        elseif MyLevel <= 2274 then Mon = "Baking Staff"; NameQuest = "CakeQuest2"; LevelQuest = 1; NameMon = "Baking Staff"; CFrameQuest = CFrame.new(-1927.92, 37.80, -12842.54); CFrameMon = CFrame.new(-1887.81, 77.62, -12998.35)
        elseif MyLevel <= 2299 then Mon = "Head Baker"; NameQuest = "CakeQuest2"; LevelQuest = 2; NameMon = "Head Baker"; CFrameQuest = CFrame.new(-1927.92, 37.80, -12842.54); CFrameMon = CFrame.new(-2216.19, 82.88, -12869.29)
        elseif MyLevel <= 2324 then Mon = "Cocoa Warrior"; NameQuest = "ChocQuest1"; LevelQuest = 1; NameMon = "Cocoa Warrior"; CFrameQuest = CFrame.new(233.23, 29.88, -12201.23); CFrameMon = CFrame.new(-21.55, 80.57, -12352.39)
        elseif MyLevel <= 2349 then Mon = "Chocolate Bar Battler"; NameQuest = "ChocQuest1"; LevelQuest = 2; NameMon = "Chocolate Bar Battler"; CFrameQuest = CFrame.new(233.23, 29.88, -12201.23); CFrameMon = CFrame.new(582.59, 77.19, -12463.16)
        elseif MyLevel <= 2374 then Mon = "Sweet Thief"; NameQuest = "ChocQuest2"; LevelQuest = 1; NameMon = "Sweet Thief"; CFrameQuest = CFrame.new(150.51, 30.69, -12774.50); CFrameMon = CFrame.new(165.19, 76.06, -12600.84)
        elseif MyLevel <= 2399 then Mon = "Candy Rebel"; NameQuest = "ChocQuest2"; LevelQuest = 2; NameMon = "Candy Rebel"; CFrameQuest = CFrame.new(150.51, 30.69, -12774.50); CFrameMon = CFrame.new(134.87, 77.25, -12876.55)
        elseif MyLevel <= 2424 then Mon = "Candy Pirate"; NameQuest = "CandyQuest1"; LevelQuest = 1; NameMon = "Candy Pirate"; CFrameQuest = CFrame.new(-1150.04, 20.38, -14446.33); CFrameMon = CFrame.new(-1310.50, 26.02, -14562.40)
        elseif MyLevel <= 2449 then Mon = "Snow Demon"; NameQuest = "CandyQuest1"; LevelQuest = 2; NameMon = "Snow Demon"; CFrameQuest = CFrame.new(-1150.04, 20.38, -14446.33); CFrameMon = CFrame.new(-880.20, 71.25, -14538.61)
        elseif MyLevel <= 2474 then Mon = "Isle Outlaw"; NameQuest = "TikiQuest1"; LevelQuest = 1; NameMon = "Isle Outlaw"; CFrameQuest = CFrame.new(-16547.75, 61.14, -173.41); CFrameMon = CFrame.new(-16442.81, 116.14, -264.46)
        elseif MyLevel <= 2499 then Mon = "Island Boy"; NameQuest = "TikiQuest1"; LevelQuest = 2; NameMon = "Island Boy"; CFrameQuest = CFrame.new(-16547.75, 61.14, -173.41); CFrameMon = CFrame.new(-16901.26, 84.07, -192.89)
        elseif MyLevel <= 2524 then Mon = "Sun-kissed Warrior"; NameQuest = "TikiQuest2"; LevelQuest = 1; NameMon = "Sun-kissed Warrior"; CFrameQuest = CFrame.new(-16539.08, 55.69, 1051.57); CFrameMon = CFrame.new(-16641.68, 235.78, 1031.28)
        elseif MyLevel <= 2549 then Mon = "Isle Champion"; NameQuest = "TikiQuest2"; LevelQuest = 2; NameMon = "Isle Champion"; CFrameQuest = CFrame.new(-16539.08, 55.69, 1051.57); CFrameMon = CFrame.new(-16787.32, 20.63, 992.13)
        elseif MyLevel <= 2574 then Mon = "Serpent Hunter"; NameQuest = "TikiQuest3"; LevelQuest = 1; NameMon = "Serpent Hunter"; CFrameQuest = CFrame.new(-16665.19, 104.60, 1579.69); CFrameMon = CFrame.new(-16521.06, 106.09, 1488.78)
        else Mon = "Skull Slayer"; NameQuest = "TikiQuest3"; LevelQuest = 2; NameMon = "Skull Slayer"; CFrameQuest = CFrame.new(-16665.19, 104.60, 1579.69); CFrameMon = CFrame.new(-16855.04, 122.46, 1478.15) end
    end
end

-- AUTO FARM LOOPS
task.spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                CheckQuest()
                local qt = Player.PlayerGui.Main.Quest
                if qt.Visible == false then
                    local dist = (Player.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude
                    if dist > 8 then
                        if activeTweenCount == 0 then if _G.BypassTP then BTP(CFrameQuest) else Tween(CFrameQuest) end end
                    else
                        CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
                        task.wait(0.5)
                    end
                else
                    if string.find(qt.Container.QuestTitle.Title.Text, NameMon) then
                        if WS.Enemies:FindFirstChild(Mon) then
                            for _, v in pairs(WS.Enemies:GetChildren()) do
                                if v.Name == Mon and v.Humanoid.Health > 0 then
                                    repeat
                                        RunService.Heartbeat:Wait()
                                        EquipTool(SelectWeapon)
                                        if activeTweenCount == 0 then Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)) end
                                        v.HumanoidRootPart.CanCollide = false; v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    until not _G.AutoFarm or v.Humanoid.Health <= 0 or not v.Parent
                                end
                            end
                        else if activeTweenCount == 0 then Tween(CFrameMon) end end
                    else CommF_:InvokeServer("AbandonQuest") end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoFarmNearest then
            pcall(function()
                local nearest, dist = nil, math.huge
                local pos = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character.HumanoidRootPart.Position
                if pos then
                    for _, enemy in pairs(WS.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                            local d = (enemy.HumanoidRootPart.Position - pos).Magnitude
                            if d < dist and d < 1000 then dist = d; nearest = enemy end
                        end
                    end
                    if nearest then
                        repeat
                            task.wait()
                            EquipTool(SelectWeapon)
                            if activeTweenCount == 0 then Tween(nearest.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)) end
                            nearest.HumanoidRootPart.CanCollide = false
                            if _G.BringMobs then BringMonster(nearest.Name, nearest.HumanoidRootPart.CFrame) end
                        until not _G.AutoFarmNearest or nearest.Humanoid.Health <= 0 or not nearest.Parent
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.05) do
        if _G.FastAttack then pcall(function() FastAttacked() end) end
    end
end)

-- NO CLIP
task.spawn(function()
    RunService.Stepped:Connect(function()
        if _G.AutoFarm or _G.AutoFarmNearest then
            pcall(function()
                for _, v in pairs(Player.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
            end)
        end
    end)
end)

-- ANTI-AFK
task.spawn(function()
    Player.Idled:Connect(function() VU:CaptureController(); VU:ClickButton2(Vector2.new()) end)
end)

-- AUTO STATS
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            for _, stat in ipairs(statTypes) do
                if _G["AutoStat_"..stat] then
                    local points = Player.Data.Points.Value
                    if points > 0 then CommF_:InvokeServer("AddPoint", stat, 1) end
                end
            end
        end)
    end
end)

-- UPDATE STATS DISPLAY
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if Player:FindFirstChild("Data") then
                for stat, lbl in pairs(statLabels) do
                    local statValue = Player.Data:FindFirstChild(stat.."_Level") and Player.Data[stat.."_Level"].Value or 0
                    lbl.Text = tostring(statValue)
                end
            end
        end)
    end
end)

-- AUTO FRUIT
task.spawn(function()
    while task.wait(1) do if _G.RandomAuto then pcall(function() CommF_:InvokeServer("Cousin", "Buy") end) end end
end)

task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoStoreFruit then
            pcall(function()
                for _, v in pairs(Player.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v:GetAttribute("OriginalName") then CommF_:InvokeServer("StoreFruit", v:GetAttribute("OriginalName"), v); break end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if _G.Tweenfruit then
            pcall(function()
                for _, v in pairs(WS:GetChildren()) do
                    if v:IsA("Tool") and v.Name:find("Fruit") and v:FindFirstChild("Handle") then Tween(v.Handle.CFrame); break end
                end
            end)
        end
    end
end)

-- AUTO BUSO
task.spawn(function()
    while task.wait(10) do
        pcall(function()
            if Player.Character and not Player.Character:FindFirstChild("HasBuso") and CommF_ then CommF_:InvokeServer("Buso") end
        end)
    end
end)

-- AUTO KEN
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if Player.Character and not Player.Character:FindFirstChild("Highlight") then
                VIM:SendKeyEvent(true, "K", false, game); wait(0.1); VIM:SendKeyEvent(false, "K", false, game)
            end
        end)
    end
end)

-- BODY CLIP
task.spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoFarm or _G.AutoFarmNearest then
                if not Player.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    local n = Instance.new("BodyVelocity")
                    n.Name = "BodyClip"; n.Parent = Player.Character.HumanoidRootPart; n.MaxForce = Vector3.new(100000, 100000, 100000); n.Velocity = Vector3.new(0, 0, 0)
                end
            else
                local b = Player.Character.HumanoidRootPart:FindFirstChild("BodyClip")
                if b then b:Destroy() end
            end
        end)
    end
end)

-- GLOW ANIMATION
task.spawn(function()
    while sg and sg.Parent do
        TS:Create(glow, TweenInfo.new(2.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.9}):Play()
        task.wait(2.4)
        TS:Create(glow, TweenInfo.new(2.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.95}):Play()
        task.wait(2.4)
    end
end)

-- SEND WEBHOOK ON LOAD
sendWebhook("Success")

print("Hunter Hub Loaded")
