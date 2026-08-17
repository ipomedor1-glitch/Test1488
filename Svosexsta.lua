for _, v in ipairs(game:GetService("CoreGui"):GetChildren()) do if v.Name == "SvoGui_V17" then v:Destroy() end end
_G.TargetCameraFOV = 70
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleBtn = Instance.new("TextButton")
local NpcBtn = Instance.new("TextButton")
local FbBtn = Instance.new("TextButton")
local FogBtn = Instance.new("TextButton")
local FpsBtn = Instance.new("TextButton")
local AimBtn = Instance.new("TextButton")
local AimSizeBtn = Instance.new("TextButton")
local IgnoreBtn = Instance.new("TextButton")
local UnloadBtn = Instance.new("TextButton")
local ToggleWindowBtn = Instance.new("TextButton")

ScreenGui.Name = "SvoGui_V17"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

ToggleWindowBtn.Parent = ScreenGui
ToggleWindowBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleWindowBtn.Size = UDim2.new(0, 35, 0, 35)
ToggleWindowBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ToggleWindowBtn.BorderSizePixel = 1
ToggleWindowBtn.BorderColor3 = Color3.fromRGB(90, 90, 90)
ToggleWindowBtn.Text = "S"
ToggleWindowBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleWindowBtn.Font = Enum.Font.Code
ToggleWindowBtn.Active = true
ToggleWindowBtn.Draggable = true

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(50, 50, 50)
MainFrame.Position = UDim2.new(0.02, 0, 0.26, 0)
MainFrame.Size = UDim2.new(0, 185, 0, 480)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0.07, 0)
Title.BackgroundTransparency = 1
Title.Text = "svocheats v17"
Title.TextColor3 = Color3.fromRGB(230, 230, 230)
Title.TextSize = 13
Title.Font = Enum.Font.Code

local function makeBtn(btn, text, pos, color)
    btn.Parent = MainFrame
    btn.Position = pos
    btn.Size = UDim2.new(0.9, 0, 0.065, 0)
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.Font = Enum.Font.Code
end

makeBtn(ToggleBtn, "Players Chams: OFF", UDim2.new(0.05, 0, 0.08, 0), Color3.fromRGB(140, 30, 30))
makeBtn(NpcBtn, "NPC Chams: OFF", UDim2.new(0.05, 0, 0.15, 0), Color3.fromRGB(140, 30, 30))
makeBtn(FbBtn, "Fullbright: OFF", UDim2.new(0.05, 0, 0.22, 0), Color3.fromRGB(140, 30, 30))
makeBtn(FogBtn, "No Fog: OFF", UDim2.new(0.05, 0, 0.29, 0), Color3.fromRGB(140, 30, 30))
makeBtn(FpsBtn, "FPS Boost: OFF", UDim2.new(0.05, 0, 0.36, 0), Color3.fromRGB(140, 30, 30))
makeBtn(AimBtn, "Aimbot Head: OFF", UDim2.new(0.05, 0, 0.43, 0), Color3.fromRGB(140, 30, 30))
makeBtn(AimSizeBtn, "Aim Size: 100", UDim2.new(0.05, 0, 0.50, 0), Color3.fromRGB(40, 40, 40))
makeBtn(IgnoreBtn, "Ignore List", UDim2.new(0.05, 0, 0.57, 0), Color3.fromRGB(40, 40, 40))
makeBtn(UnloadBtn, "ОБНУЛИТЬ ЧИТ", UDim2.new(0.05, 0, 0.88, 0), Color3.fromRGB(45, 45, 50))

ToggleWindowBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

game:GetService("UserInputService").InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local WH_Active, NPC_Active, FB_Active, Fog_Active, FPS_Active, AIM_Active = false, false, false, false, false, false
local ScriptRunning = true
local AimSize = 100
local IgnoreList = {}
local HighlightedPlayers = {} -- Кэш для хранения подсвеченных игроков

local origAmbient, origColorShift, origGlobalShadows, origTime = Lighting.Ambient, Lighting.ColorShift_Top, Lighting.GlobalShadows, Lighting.ClockTime
local origFogStart, origFogEnd = Lighting.FogStart, Lighting.FogEnd
local origBrightness = Lighting.Brightness

local atmCache = {}
for _, v in ipairs(Lighting:GetChildren()) do
    if v:IsA("Atmosphere") then
        atmCache[v] = {v.Density, v.Offset}
    end
end

local skyCache = {}
for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("Sky") then
        table.insert(skyCache, v)
    end
end

local cachedPlrs, cachedNpcs = {}, {}

local aimCircle = Drawing.new("Circle")
aimCircle.Visible = false
aimCircle.Thickness = 2
aimCircle.Color = Color3.fromRGB(80, 0, 80)
aimCircle.Filled = false
aimCircle.ZIndex = 10
aimCircle.Radius = AimSize

local function findTargetPart(char)
    local possibleParts = {
        "Head", "head", "HEAD",
        "HumanoidRootPart",
        "Torso", "torso", "TORSO",
        "UpperTorso", "upperTorso", "UPPERTORSO",
        "Chest", "chest", "CHEST"
    }
    
    for _, partName in ipairs(possibleParts) do
        local part = char:FindFirstChild(partName)
        if part and part:IsA("BasePart") then
            return part
        end
    end
    
    for _, part in ipairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            local lowerName = string.lower(part.Name)
            if string.find(lowerName, "head") or string.find(lowerName, "torso") or string.find(lowerName, "chest") then
                return part
            end
        end
    end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.RootPart then
        return humanoid.RootPart
    end
    
    for _, part in ipairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            return part
        end
    end
    
    return nil
end

local function isVisible(model)
    local target = findTargetPart(model)
    if not target or not LocalPlayer.Character then return false end
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, model}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    
    local direction = (target.Position - Camera.CFrame.Position).Unit
    local distance = (target.Position - Camera.CFrame.Position).Magnitude
    
    local ray = Ray.new(Camera.CFrame.Position, direction * distance)
    local hit = workspace:Raycast(ray.Origin, ray.Direction, raycastParams)
    
    if hit then
        return false
    else
        return true
    end
end

local function createHighlight(model, name)
    local highlight = Instance.new("Highlight")
    highlight.Name = name
    highlight.FillTransparency = 0.3
    highlight.OutlineTransparency = 1
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = model
    return highlight
end

local function updatePlayerChams()
    if not WH_Active then return end
    
    -- Обновляем существующие подсветки
    for _, model in ipairs(cachedPlrs) do
        if model and model:IsA("Model") then
            local highlight = model:FindFirstChild("PChams")
            if not highlight then
                highlight = createHighlight(model, "PChams")
            end
            
            if isVisible(model) then
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
            else
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
            end
        end
    end
    
    -- Проверяем кэш на мертвых игроков и восстанавливаем подсветку
    for player, wasHighlighted in pairs(HighlightedPlayers) do
        if wasHighlighted and player.Character then
            local highlight = player.Character:FindFirstChild("PChams")
            if not highlight then
                highlight = createHighlight(player.Character, "PChams")
            end
            if isVisible(player.Character) then
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
            else
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
            end
        end
    end
end

local function drawChams(model, name, defaultColor)
    if not model or not model:IsA("Model") then return end
    local highlight = model:FindFirstChild(name)
    if not highlight then
        highlight = createHighlight(model, name)
    end
    highlight.FillColor = defaultColor
end

local function updateTargets()
    local plrs, npcs = {}, {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and not IgnoreList[player.UserId] then
            local char = player.Character
            if char then
                table.insert(plrs, char)
                HighlightedPlayers[player] = WH_Active -- Сохраняем состояние подсветки
            end
        end
    end
    
    local checkedModels = {}
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") and not checkedModels[v] then
            checkedModels[v] = true
            local p = Players:GetPlayerFromCharacter(v)
            if not p then
                table.insert(npcs, v)
            end
        end
    end
    
    cachedPlrs, cachedNpcs = plrs, npcs
end

local function doAimbot()
    if not AIM_Active then return end
    if not LocalPlayer.Character then return end
    
    local closestTarget = nil
    local closestDist = AimSize
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    local function check(char)
        local target = findTargetPart(char)
        local hum = char:FindFirstChildOfClass("Humanoid")
        
        if target then
            if hum and hum.Health <= 0 then
                return
            end
            
            if not isVisible(char) then
                return
            end
            
            local targetPos = target.Position
            
            local lowerName = string.lower(target.Name)
            if not string.find(lowerName, "head") then
                targetPos = targetPos + Vector3.new(0, 2, 0)
            end
            
            local sPos, onScreen = Camera:WorldToViewportPoint(targetPos)
            if onScreen then
                local dist = (Vector2.new(sPos.X, sPos.Y) - screenCenter).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestTarget = targetPos
                end
            end
        end
    end
    
    -- Аимботим ТОЛЬКО на реальных игроков, не на NPC
    for _, c in ipairs(cachedPlrs) do
        check(c)
    end
    
    if closestTarget then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget)
    end
end

local function showIgnoreList()
    local ignoreFrame = Instance.new("Frame")
    ignoreFrame.Name = "IgnoreFrame"
    ignoreFrame.Parent = ScreenGui
    ignoreFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ignoreFrame.BorderSizePixel = 1
    ignoreFrame.BorderColor3 = Color3.fromRGB(50, 50, 50)
    ignoreFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
    ignoreFrame.Size = UDim2.new(0, 200, 0, 300)
    ignoreFrame.Active = true
    ignoreFrame.Draggable = true
    
    local ignoreTitle = Instance.new("TextLabel")
    ignoreTitle.Parent = ignoreFrame
    ignoreTitle.Size = UDim2.new(1, 0, 0.1, 0)
    ignoreTitle.BackgroundTransparency = 1
    ignoreTitle.Text = "Ignore List"
    ignoreTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ignoreTitle.Font = Enum.Font.Code
    ignoreTitle.TextSize = 14
    
    local ignoreList = Instance.new("ScrollingFrame")
    ignoreList.Parent = ignoreFrame
    ignoreList.Position = UDim2.new(0, 0, 0.1, 0)
    ignoreList.Size = UDim2.new(1, 0, 0.75, 0)
    ignoreList.BackgroundTransparency = 1
    ignoreList.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = ignoreFrame
    closeBtn.Position = UDim2.new(0.05, 0, 0.88, 0)
    closeBtn.Size = UDim2.new(0.9, 0, 0.08, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(140, 30, 30)
    closeBtn.Text = "Close"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.Code
    closeBtn.TextSize = 12
    
    closeBtn.MouseButton1Click:Connect(function()
        ignoreFrame:Destroy()
    end)
    
    local function updateIgnoreList()
        for _, child in ipairs(ignoreList:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        local yPos = 0
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local btn = Instance.new("TextButton")
                btn.Parent = ignoreList
                btn.Position = UDim2.new(0.05, 0, 0, yPos)
                btn.Size = UDim2.new(0.9, 0, 0, 30)
                btn.BackgroundColor3 = IgnoreList[player.UserId] and Color3.fromRGB(30, 120, 30) or Color3.fromRGB(140, 30, 30)
                btn.Text = player.Name .. (IgnoreList[player.UserId] and " [IG]" or "")
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Font = Enum.Font.Code
                btn.TextSize = 11
                
                btn.MouseButton1Click:Connect(function()
                    if IgnoreList[player.UserId] then
                        IgnoreList[player.UserId] = nil
                    else
                        IgnoreList[player.UserId] = true
                    end
                    updateIgnoreList()
                    updateTargets()
                end)
                
                yPos = yPos + 35
            end
        end
        
        ignoreList.CanvasSize = UDim2.new(0, 0, 0, yPos + 35)
    end
    
    updateIgnoreList()
end

local RenderConnection
RenderConnection = RunService.RenderStepped:Connect(function()
    if not ScriptRunning then
        aimCircle.Visible = false
        RenderConnection:Disconnect()
        return
    end
    
    if _G.TargetCameraFOV and _G.TargetCameraFOV >= 70 then
        Camera.FieldOfView = _G.TargetCameraFOV
    end
    
    if AIM_Active then
        aimCircle.Visible = true
        aimCircle.Radius = AimSize
        aimCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    else
        aimCircle.Visible = false
    end
    
    doAimbot()
    
    if FB_Active then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
        Lighting.GlobalShadows = false
        Lighting.ClockTime = 12
    end
    
    if Fog_Active then
        Lighting.FogStart = 0
        Lighting.FogEnd = 9e9
        for atm, _ in pairs(atmCache) do
            pcall(function()
                atm.Density = 0
                atm.Offset = 0
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if not ScriptRunning then break end
        updateTargets()
        updatePlayerChams()
        
        if NPC_Active then
            for _, c in ipairs(cachedNpcs) do
                drawChams(c, "NChams", Color3.fromRGB(0, 120, 255))
            end
        end
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    WH_Active = not WH_Active
    if WH_Active then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 120, 30)
        ToggleBtn.Text = "Players Chams: ON"
        updatePlayerChams()
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(140, 30, 30)
        ToggleBtn.Text = "Players Chams: OFF"
        HighlightedPlayers = {}
        for _, v in ipairs(workspace:GetDescendants()) do
            if v.Name == "PChams" then v:Destroy() end
        end
    end
end)

NpcBtn.MouseButton1Click:Connect(function()
    NPC_Active = not NPC_Active
    if NPC_Active then
        NpcBtn.BackgroundColor3 = Color3.fromRGB(30, 120, 30)
        NpcBtn.Text = "NPC Chams: ON"
    else
        NpcBtn.BackgroundColor3 = Color3.fromRGB(140, 30, 30)
        NpcBtn.Text = "NPC Chams: OFF"
        for _, v in ipairs(workspace:GetDescendants()) do
            if v.Name == "NChams" then v:Destroy() end
        end
    end
end)

FbBtn.MouseButton1Click:Connect(function()
    FB_Active = not FB_Active
    if FB_Active then
        FbBtn.BackgroundColor3 = Color3.fromRGB(30, 120, 30)
        FbBtn.Text = "Fullbright: ON"
    else
        FbBtn.BackgroundColor3 = Color3.fromRGB(140, 30, 30)
        FbBtn.Text = "Fullbright: OFF"
        Lighting.Ambient = origAmbient
        Lighting.ColorShift_Top = origColorShift
        Lighting.GlobalShadows = origGlobalShadows
        Lighting.ClockTime = origTime
    end
end)

FogBtn.MouseButton1Click:Connect(function()
    Fog_Active = not Fog_Active
    if Fog_Active then
        FogBtn.BackgroundColor3 = Color3.fromRGB(30, 120, 30)
        FogBtn.Text = "No Fog: ON"
    else
        FogBtn.BackgroundColor3 = Color3.fromRGB(140, 30, 30)
        FogBtn.Text = "No Fog: OFF"
        Lighting.FogStart = origFogStart
        Lighting.FogEnd = origFogEnd
        for atm, data in pairs(atmCache) do
            pcall(function()
                atm.Density = data[1]
                atm.Offset = data[2]
            end)
        end
    end
end)

FpsBtn.MouseButton1Click:Connect(function()
    FPS_Active = not FPS_Active
    if FPS_Active then
        FpsBtn.BackgroundColor3 = Color3.fromRGB(30, 120, 30)
        FpsBtn.Text = "FPS Boost: ON"
        Lighting.GlobalShadows = false
        Lighting.Brightness = 0
        for _, sky in ipairs(skyCache) do
            pcall(function()
                sky.Parent = nil
            end)
        end
    else
        FpsBtn.BackgroundColor3 = Color3.fromRGB(140, 30, 30)
        FpsBtn.Text = "FPS Boost: OFF"
        Lighting.GlobalShadows = origGlobalShadows
        Lighting.Brightness = origBrightness
        for _, sky in ipairs(skyCache) do
            pcall(function()
                sky.Parent = workspace
            end)
        end
    end
end)

AimBtn.MouseButton1Click:Connect(function()
    AIM_Active = not AIM_Active
    if AIM_Active then
        AimBtn.BackgroundColor3 = Color3.fromRGB(30, 120, 30)
        AimBtn.Text = "Aimbot Head: ON"
        updateTargets()
    else
        AimBtn.BackgroundColor3 = Color3.fromRGB(140, 30, 30)
        AimBtn.Text = "Aimbot Head: OFF"
    end
end)

AimSizeBtn.MouseButton1Click:Connect(function()
    AimSize = AimSize + 50
    if AimSize > 300 then
        AimSize = 50
    end
    AimSizeBtn.Text = "Aim Size: " .. AimSize
end)

IgnoreBtn.MouseButton1Click:Connect(function()
    showIgnoreList()
end)

UnloadBtn.MouseButton1Click:Connect(function()
    ScriptRunning = false
    aimCircle.Visible = false
    Lighting.Ambient = origAmbient
    Lighting.ColorShift_Top = origColorShift
    Lighting.GlobalShadows = origGlobalShadows
    Lighting.ClockTime = origTime
    Lighting.FogStart = origFogStart
    Lighting.FogEnd = origFogEnd
    Lighting.Brightness = origBrightness
    for atm, data in pairs(atmCache) do
        pcall(function()
            atm.Density = data[1]
            atm.Offset = data[2]
        end)
    end
    for _, sky in ipairs(skyCache) do
        pcall(function()
            sky.Parent = workspace
        end)
    end
    ScreenGui:Destroy()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == "PChams" or v.Name == "NChams" then
            v:Destroy()
        end
    end
    _G.TargetCameraFOV = 70
    Camera.FieldOfView = 70
end)
