-- Проверка ключа при запуске
local KeyCheck = Instance.new("ScreenGui")
KeyCheck.Parent = game:GetService("CoreGui")
KeyCheck.ResetOnSpawn = false
KeyCheck.IgnoreGuiInset = true
KeyCheck.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local KeyFrame = Instance.new("Frame")
KeyFrame.Parent = KeyCheck
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
KeyFrame.Size = UDim2.new(0, 300, 0, 200)
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.ZIndex = 9999
local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 10)
KeyCorner.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Parent = KeyFrame
KeyTitle.Size = UDim2.new(1, 0, 0.15, 0)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "svokaktak v1"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.Font = Enum.Font.Code
KeyTitle.TextSize = 16

local KeyInput = Instance.new("TextBox")
KeyInput.Parent = KeyFrame
KeyInput.Position = UDim2.new(0.1, 0, 0.25, 0)
KeyInput.Size = UDim2.new(0.8, 0, 0.2, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.Code
KeyInput.TextSize = 12
KeyInput.PlaceholderText = "Enter key..."
local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 5)
KeyInputCorner.Parent = KeyInput

local KeyButton = Instance.new("TextButton")
KeyButton.Parent = KeyFrame
KeyButton.Position = UDim2.new(0.1, 0, 0.5, 0)
KeyButton.Size = UDim2.new(0.8, 0, 0.15, 0)
KeyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeyButton.Text = "Submit"
KeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyButton.Font = Enum.Font.Code
KeyButton.TextSize = 12
local KeyButtonCorner = Instance.new("UICorner")
KeyButtonCorner.CornerRadius = UDim.new(0, 5)
KeyButtonCorner.Parent = KeyButton

local TelegramButton = Instance.new("TextButton")
TelegramButton.Parent = KeyFrame
TelegramButton.Position = UDim2.new(0.1, 0, 0.72, 0)
TelegramButton.Size = UDim2.new(0.8, 0, 0.15, 0)
TelegramButton.BackgroundColor3 = Color3.fromRGB(0, 136, 204) -- Цвет Telegram
TelegramButton.Text = "Telegram: @neimozuu"
TelegramButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TelegramButton.Font = Enum.Font.Code
TelegramButton.TextSize = 11
local TelegramCorner = Instance.new("UICorner")
TelegramCorner.CornerRadius = UDim.new(0, 5)
TelegramCorner.Parent = TelegramButton

TelegramButton.MouseButton1Click:Connect(function()
    setclipboard("@neimozuu")
    TelegramButton.Text = "Copied!"
    task.wait(1)
    TelegramButton.Text = "Telegram: @neimozuu"
end)

local function checkKey()
    if KeyInput.Text == "SVOKAKTAK" then
        KeyCheck:Destroy()
        loadMainScript()
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "Wrong key!"
    end
end

KeyButton.MouseButton1Click:Connect(checkKey)
KeyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        checkKey()
    end
end)

function loadMainScript()
    for _, v in ipairs(game:GetService("CoreGui"):GetChildren()) do 
        if v.Name == "SvoGui_V17" then 
            v:Destroy() 
        end 
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SvoGui_V17"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local ToggleWindowBtn = Instance.new("TextButton")
    ToggleWindowBtn.Parent = ScreenGui
    ToggleWindowBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
    ToggleWindowBtn.Size = UDim2.new(0, 70, 0, 45)
    ToggleWindowBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    ToggleWindowBtn.Text = "svo"
    ToggleWindowBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleWindowBtn.Font = Enum.Font.Code
    ToggleWindowBtn.TextSize = 18
    ToggleWindowBtn.Draggable = true
    ToggleWindowBtn.ZIndex = 1000
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = ToggleWindowBtn

    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Position = UDim2.new(0.02, 0, 0.32, 0)
    MainFrame.Size = UDim2.new(0, 230, 0, 280)
    MainFrame.Visible = false
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.ZIndex = 999
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Parent = MainFrame
    Title.Size = UDim2.new(1, 0, 0.08, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "svokaktak v1"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.Font = Enum.Font.Code

    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Parent = MainFrame
    ScrollingFrame.Position = UDim2.new(0, 0, 0.08, 0)
    ScrollingFrame.Size = UDim2.new(1, 0, 0.84, 0)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 220)
    ScrollingFrame.ScrollBarThickness = 3

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local RunService = game:GetService("RunService")

    local states = {
        AIM = false,
        WH = false,
        NPC = false
    }
    local AimSize = 100
    local IgnoreList = {}
    local cachedPlrs = {}

    local aimCircle = Instance.new("Frame")
    aimCircle.Parent = ScreenGui
    aimCircle.Size = UDim2.new(0, AimSize * 2, 0, AimSize * 2)
    aimCircle.Position = UDim2.new(0.5, -AimSize, 0.5, -AimSize)
    aimCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    aimCircle.BackgroundTransparency = 0.85
    aimCircle.Visible = false
    aimCircle.ZIndex = 10
    Instance.new("UICorner", aimCircle).CornerRadius = UDim.new(1, 0)
    local aimStroke = Instance.new("UIStroke")
    aimStroke.Parent = aimCircle
    aimStroke.Color = Color3.fromRGB(255, 255, 255)
    aimStroke.Thickness = 2

    local function createToggle(text, y, key, callback)
        local container = Instance.new("Frame")
        container.Parent = ScrollingFrame
        container.Position = UDim2.new(0.05, 0, 0, y)
        container.Size = UDim2.new(0.9, 0, 0, 35)
        container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = container
        
        local label = Instance.new("TextLabel")
        label.Parent = container
        label.Position = UDim2.new(0.05, 0, 0, 0)
        label.Size = UDim2.new(0.5, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.Code
        label.TextSize = 11
        label.TextXAlignment = Enum.TextXAlignment.Left
        
        local slider = Instance.new("TextButton")
        slider.Parent = container
        slider.Position = UDim2.new(0.65, 0, 0.15, 0)
        slider.Size = UDim2.new(0.3, 0, 0.7, 0)
        slider.BackgroundColor3 = states[key] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(60, 60, 60)
        slider.Text = states[key] and "ON" or "OFF"
        slider.TextColor3 = Color3.fromRGB(255, 255, 255)
        slider.Font = Enum.Font.Code
        slider.TextSize = 10
        local sliderCorner = Instance.new("UICorner")
        sliderCorner.CornerRadius = UDim.new(0, 6)
        sliderCorner.Parent = slider
        
        slider.MouseButton1Click:Connect(function()
            states[key] = not states[key]
            slider.BackgroundColor3 = states[key] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(60, 60, 60)
            slider.Text = states[key] and "ON" or "OFF"
            callback(states[key])
        end)
        
        if states[key] then
            callback(true)
        end
    end

    createToggle("Player Chams", 5, "WH", function(state) states.WH = state end)
    createToggle("NPC Chams", 45, "NPC", function(state) states.NPC = state end)
    createToggle("Aimbot", 85, "AIM", function(state) 
        states.AIM = state
        aimCircle.Visible = state
    end)

    local AimSizeLabel = Instance.new("TextLabel")
    AimSizeLabel.Parent = ScrollingFrame
    AimSizeLabel.Position = UDim2.new(0.05, 0, 0, 125)
    AimSizeLabel.Size = UDim2.new(0.9, 0, 0, 20)
    AimSizeLabel.BackgroundTransparency = 1
    AimSizeLabel.Text = "Aim Size: 100"
    AimSizeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    AimSizeLabel.Font = Enum.Font.Code
    AimSizeLabel.TextSize = 11

    local AimSizeInput = Instance.new("TextBox")
    AimSizeInput.Parent = ScrollingFrame
    AimSizeInput.Position = UDim2.new(0.05, 0, 0, 145)
    AimSizeInput.Size = UDim2.new(0.9, 0, 0, 30)
    AimSizeInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    AimSizeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    AimSizeInput.Font = Enum.Font.Code
    AimSizeInput.TextSize = 12
    AimSizeInput.PlaceholderText = "Enter size (50-300)"
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 6)
    inputCorner.Parent = AimSizeInput

    AimSizeInput.FocusLost:Connect(function(enterPressed)
        local value = tonumber(AimSizeInput.Text)
        if value and value >= 50 and value <= 300 then
            AimSize = value
            AimSizeLabel.Text = "Aim Size: " .. AimSize
            aimCircle.Size = UDim2.new(0, AimSize * 2, 0, AimSize * 2)
            aimCircle.Position = UDim2.new(0.5, -AimSize, 0.5, -AimSize)
        end
        AimSizeInput.Text = ""
    end)

    local IgnoreBtn = Instance.new("TextButton")
    IgnoreBtn.Parent = ScrollingFrame
    IgnoreBtn.Position = UDim2.new(0.05, 0, 0, 185)
    IgnoreBtn.Size = UDim2.new(0.9, 0, 0, 30)
    IgnoreBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    IgnoreBtn.Text = "Ignore List"
    IgnoreBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    IgnoreBtn.Font = Enum.Font.Code
    IgnoreBtn.TextSize = 11
    local ignoreCorner = Instance.new("UICorner")
    ignoreCorner.CornerRadius = UDim.new(0, 8)
    ignoreCorner.Parent = IgnoreBtn

    local UnloadBtn = Instance.new("TextButton")
    UnloadBtn.Parent = MainFrame
    UnloadBtn.Position = UDim2.new(0.05, 0, 0.92, 0)
    UnloadBtn.Size = UDim2.new(0.9, 0, 0.06, 0)
    UnloadBtn.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
    UnloadBtn.Text = "UNLOAD"
    UnloadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    UnloadBtn.Font = Enum.Font.Code
    UnloadBtn.TextSize = 12
    local unloadCorner = Instance.new("UICorner")
    unloadCorner.CornerRadius = UDim.new(0, 6)
    unloadCorner.Parent = UnloadBtn

    UnloadBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Highlight") and v.Name == "PChams" then
                v:Destroy()
            end
        end
    end)

    ToggleWindowBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    local function findHead(char)
        for _, name in ipairs({"Head", "HumanoidRootPart", "Torso", "UpperTorso"}) do
            local part = char:FindFirstChild(name)
            if part and part:IsA("BasePart") then 
                return part 
            end
        end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        return humanoid and humanoid.RootPart
    end

    local function isVisible(model)
        local target = findHead(model)
        if not target or not LocalPlayer.Character then return false end
        local params = RaycastParams.new()
        params.FilterDescendantsInstances = {LocalPlayer.Character, model}
        params.FilterType = Enum.RaycastFilterType.Blacklist
        local dir = (target.Position - Camera.CFrame.Position)
        local ray = Ray.new(Camera.CFrame.Position, dir.Unit * dir.Magnitude)
        return workspace:Raycast(ray.Origin, ray.Direction, params) == nil
    end

    local function updateTargets()
        cachedPlrs = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and not IgnoreList[player.UserId] and player.Character then
                local root = findHead(player.Character)
                if root then
                    local dist = (root.Position - Camera.CFrame.Position).Magnitude
                    if dist <= 1000 then
                        table.insert(cachedPlrs, player.Character)
                    end
                end
            end
        end
    end

    local function updateChams()
        if not states.WH then return end
        for _, model in ipairs(cachedPlrs) do
            local highlight = model:FindFirstChild("PChams")
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "PChams"
                highlight.FillTransparency = 0.3
                highlight.OutlineTransparency = 1
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.Parent = model
            end
            highlight.FillColor = isVisible(model) and Color3.fromRGB(255, 100, 0) or Color3.fromRGB(40, 0, 80)
        end
    end

    local function doAimbot()
        if not states.AIM or not LocalPlayer.Character then return end
        local best, bestDist = nil, AimSize
        local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        
        for _, char in ipairs(cachedPlrs) do
            local target = findHead(char)
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if target and humanoid and humanoid.Health > 0 and isVisible(char) then
                local pos, onScreen = Camera:WorldToViewportPoint(target.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if dist < bestDist then
                        bestDist = dist
                        best = target.Position
                    end
                end
            end
        end
        
        if best then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, best)
        end
    end

    local function showIgnoreList()
        local frame = Instance.new("Frame")
        frame.Parent = ScreenGui
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        frame.Position = UDim2.new(0.3, 0, 0.2, 0)
        frame.Size = UDim2.new(0, 200, 0, 250)
        frame.Active = true
        frame.Draggable = true
        frame.ZIndex = 998
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = frame
        
        local list = Instance.new("ScrollingFrame")
        list.Parent = frame
        list.Position = UDim2.new(0, 0, 0.1, 0)
        list.Size = UDim2.new(1, 0, 0.75, 0)
        list.BackgroundTransparency = 1
        list.CanvasSize = UDim2.new(0, 0, 0, 0)
        
        local closeBtn = Instance.new("TextButton")
        closeBtn.Parent = frame
        closeBtn.Position = UDim2.new(0.05, 0, 0.88, 0)
        closeBtn.Size = UDim2.new(0.9, 0, 0.08, 0)
        closeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        closeBtn.Text = "Close"
        closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeBtn.Font = Enum.Font.Code
        closeBtn.TextSize = 12
        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UDim.new(0, 6)
        closeCorner.Parent = closeBtn
        
        closeBtn.MouseButton1Click:Connect(function()
            frame:Destroy()
        end)
        
        local function updateList()
            for _, child in ipairs(list:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy()
                end
            end
            
            local yPos = 0
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local btn = Instance.new("TextButton")
                    btn.Parent = list
                    btn.Position = UDim2.new(0.05, 0, 0, yPos)
                    btn.Size = UDim2.new(0.9, 0, 0, 25)
                    btn.BackgroundColor3 = IgnoreList[player.UserId] and Color3.fromRGB(50, 100, 50) or Color3.fromRGB(60, 60, 60)
                    btn.Text = player.Name .. (IgnoreList[player.UserId] and " [IG]" or "")
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    btn.Font = Enum.Font.Code
                    btn.TextSize = 10
                    local btnCorner = Instance.new("UICorner")
                    btnCorner.CornerRadius = UDim.new(0, 5)
                    btnCorner.Parent = btn
                    
                    btn.MouseButton1Click:Connect(function()
                        IgnoreList[player.UserId] = not IgnoreList[player.UserId]
                        updateList()
                        updateTargets()
                    end)
                    
                    yPos = yPos + 28
                end
            end
            
            list.CanvasSize = UDim2.new(0, 0, 0, yPos + 28)
        end
        
        updateList()
    end

    IgnoreBtn.MouseButton1Click:Connect(function()
        showIgnoreList()
    end)

    RunService.RenderStepped:Connect(function()
        doAimbot()
    end)

    task.spawn(function()
        while task.wait(0.05) do
            updateTargets()
            updateChams()
        end
    end)

    Players.LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        updateTargets()
    end)
end
