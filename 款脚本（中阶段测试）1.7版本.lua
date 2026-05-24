local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local STARTUP_MUSIC_IDS = {
    "rbxassetid://73722198102705",
    "rbxassetid://86031791542518", 
    "rbxassetid://91122395878594",
    "rbxassetid://18980082432",
}

-- ==================== 全局变量 ====================
local adminList = {
    "zxc110819", 
    "NOOOPLSDONTletme444", 
    "aa1360051",
    "FengY3", 
    "FengYu303",
    "ma107133", 
    "DPYfish"
}
local authorList = {
    "fgvccvvbb3", 
    "dhjhcxgjk", 
    "yxhchchcucyv", 
    "用户名5"
}
local blacklist = {"无", "无"}

local function isInList(list, name)
    for i = 1, #list do
        if list[i] == name then return true end
    end
    return false
end

local windowTitle, titleColor, isRainbowTitle, userRoleName
if isInList(adminList, LocalPlayer.Name) then
    windowTitle = "测试人员"
    titleColor = Color3.fromRGB(255, 215, 0)
    isRainbowTitle = false
    userRoleName = "测试人员"
elseif isInList(authorList, LocalPlayer.Name) then
    windowTitle = "款脚本作者"
    titleColor = Color3.fromRGB(0, 255, 255)
    isRainbowTitle = true
    userRoleName = "作者"
else
    windowTitle = "脚本使用者"
    titleColor = Color3.fromRGB(0, 0, 0)
    isRainbowTitle = false
    userRoleName = nil
end

local function IsAdminOrAuthor()
    return isInList(adminList, LocalPlayer.Name) or isInList(authorList, LocalPlayer.Name)
end

if isInList(blacklist, LocalPlayer.Name) then
    LocalPlayer:Kick("错误代码 246：您已被禁止使用此脚本")
    return
end

-- ==================== 彩蛋系统 ====================
local easterEggTriggered = false
local easterEggClicked = {}
local totalProfileCount = 8

local function applyEasterEggBuffs()
    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = 500
            hum.JumpPower = 500
        end
    end
    LocalPlayer.CharacterAdded:Connect(function(char)
        local hum = char:WaitForChild("Humanoid", 5)
        if hum then
            hum.WalkSpeed = 500
            hum.JumpPower = 500
        end
    end)
end

local function triggerEasterEgg()
    if easterEggTriggered then return end
    easterEggTriggered = true

    applyEasterEggBuffs()

    local eggGui = Instance.new("ScreenGui")
    eggGui.Name = "EasterEggEffect"
    eggGui.ResetOnSpawn = false
    eggGui.Parent = LocalPlayer.PlayerGui

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundTransparency = 1
    bg.BorderSizePixel = 0
    bg.Parent = eggGui

    local topText = Instance.new("TextLabel")
    topText.Size = UDim2.new(1, 0, 0, 50)
    topText.Position = UDim2.new(0, 0, 0.05, 0)
    topText.BackgroundTransparency = 1
    topText.Text = "你已触发彩蛋模式"
    topText.TextColor3 = Color3.fromRGB(255, 255, 255)
    topText.Font = Enum.Font.SourceSansBold
    topText.TextSize = 28
    topText.TextStrokeTransparency = 0
    topText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    topText.Parent = eggGui

    task.spawn(function()
        while topText.Parent do
            TweenService:Create(topText, TweenInfo.new(0.5), {TextTransparency = 0.7}):Play()
            task.wait(0.5)
            TweenService:Create(topText, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
            task.wait(0.5)
        end
    end)

    local characterRain = {
        {text = "小番", color = Color3.fromRGB(255, 0, 0)},
        {text = "风御", color = Color3.fromRGB(0, 150, 255)},
        {text = "只爱", color = Color3.fromRGB(0, 200, 220)},
        {text = "付款", color = Color3.fromRGB(0, 255, 255)},
        {text = "Noob", color = Color3.fromRGB(255, 255, 0)},
        {text = "奕夕", color = Color3.fromRGB(255, 165, 0)},
        {text = "cube", color = Color3.fromRGB(0, 255, 0)},
    }

    local numRain = 60
    local rainData = {}
    for i = 1, numRain do
        local data = characterRain[math.random(1, #characterRain)]
        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Text = data.text
        label.TextColor3 = data.color
        label.Font = Enum.Font.SourceSansBold
        label.TextSize = 18
        label.TextTransparency = 0
        label.Parent = eggGui
        label.Position = UDim2.new(math.random(0, 100) / 100, 0, 1 + math.random(0, 50) / 100, 0)
        table.insert(rainData, {
            label = label, 
            speed = 0.3 + math.random(0, 15) / 10,
            color = data.color
        })
    end

    local connection = RunService.Heartbeat:Connect(function(deltaTime)
        for _, data in ipairs(rainData) do
            local lbl = data.label
            if lbl and lbl.Parent then
                local newY = lbl.Position.Y.Scale - data.speed * deltaTime
                if newY < -0.3 then
                    lbl.Position = UDim2.new(math.random(0, 100) / 100, 0, 1 + math.random(0, 30) / 100, 0)
                    local newData = characterRain[math.random(1, #characterRain)]
                    lbl.Text = newData.text
                    lbl.TextColor3 = newData.color
                    data.color = newData.color
                else
                    lbl.Position = UDim2.new(lbl.Position.X.Scale, 0, newY, 0)
                end
            end
        end
    end)

    task.delay(8, function()
        connection:Disconnect()
        eggGui:Destroy()
        easterEggTriggered = false
        easterEggClicked = {}
    end)
end

-- ==================== UI构建函数 ====================
function buildUI()
    local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/probable-happiness/refs/heads/main/VIP_Fenglib(2).lua"))()
    local Window = library:CreateWindow({
        Title = windowTitle,
        Subtitle = "付款制作必是精品",
        Keybind = Enum.KeyCode.RightShift,
        Icon = 80732857736726,
        Theme = "Dark",
        Background = "https://chaton-images.s3.us-east-2.amazonaws.com/Qx7Aun30ZRPmlXtXDE3adbBleR5buvwp8AbOFCoIU5TugqRw62Dn00B4rBtx00Vx_1578x932x261816.jpeg"
    })

    task.wait(0.3)
    local sg = LocalPlayer.PlayerGui:FindFirstChild(windowTitle)
    if sg then
        local main = sg:FindFirstChild("Main") or sg:FindFirstChild("Frame")
        if main then
            local titleLabel = main:FindFirstChild("Title") or main:FindFirstChild("TitleText")
            if titleLabel and titleLabel:IsA("TextLabel") then
                titleLabel.TextColor3 = titleColor
                if isRainbowTitle then
                    local rainbow = {
                        Color3.fromRGB(0, 255, 255), Color3.fromRGB(255, 0, 255),
                        Color3.fromRGB(255, 215, 0), Color3.fromRGB(0, 255, 0)
                    }
                    local idx = 1
                    task.spawn(function()
                        while titleLabel and titleLabel.Parent do
                            titleLabel.TextColor3 = rainbow[idx]
                            idx = idx % #rainbow + 1
                            task.wait(0.4)
                        end
                    end)
                end
            end
        end
    end

    local function getPlayerTitle(player)
        if isInList(adminList, player.Name) then return "测试人员"
        elseif isInList(authorList, player.Name) then return "款脚本作者" end
        return nil
    end

    local playerTitleBillboards = {}

    local function createTitleBillboard(player, character)
        local head = character:WaitForChild("Head")
        if not head then return end
        local title = getPlayerTitle(player)
        if not title then return end
        if playerTitleBillboards[player] then 
            pcall(function() playerTitleBillboards[player]:Destroy() end)
        end

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "AdminTitleBillboard"
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 200, 0, 30)
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = head

        local outerFrame = Instance.new("Frame")
        outerFrame.Size = UDim2.new(1, 0, 1, 0)
        outerFrame.BackgroundTransparency = 0.6
        outerFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        outerFrame.Parent = billboard
        local outerCorner = Instance.new("UICorner")
        outerCorner.CornerRadius = UDim.new(0, 4)
        outerCorner.Parent = outerFrame

        local outerStroke = Instance.new("UIStroke")
        outerStroke.Thickness = 2
        outerStroke.LineJoinMode = Enum.LineJoinMode.Round
        outerStroke.Parent = outerFrame

        local rainbow = {
            Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 165, 0),
            Color3.fromRGB(255, 255, 0), Color3.fromRGB(0, 255, 0),
            Color3.fromRGB(0, 255, 255), Color3.fromRGB(0, 0, 255),
            Color3.fromRGB(128, 0, 128)
        }
        local idx = 1
        task.spawn(function()
            while outerStroke and outerStroke.Parent do
                outerStroke.Color = rainbow[idx]
                idx = idx % #rainbow + 1
                task.wait(0.3)
            end
        end)

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = title
        label.TextColor3 = Color3.fromRGB(0, 255, 255)
        label.TextStrokeTransparency = 0
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.Font = Enum.Font.SourceSansBold
        label.TextScaled = true
        label.Parent = outerFrame

        playerTitleBillboards[player] = billboard
    end

    local function removeTitleBillboard(player)
        if playerTitleBillboards[player] then
            pcall(function() playerTitleBillboards[player]:Destroy() end)
            playerTitleBillboards[player] = nil
        end
    end

    local function handlePlayerCharacter(player, character)
        if getPlayerTitle(player) then createTitleBillboard(player, character) end
        player.CharacterAdded:Connect(function(newChar)
            if getPlayerTitle(player) then 
                task.wait(0.5)
                createTitleBillboard(player, newChar) 
            end
        end)
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if player.Character then 
                handlePlayerCharacter(player, player.Character)
            else 
                player.CharacterAdded:Connect(function(char) 
                    handlePlayerCharacter(player, char) 
                end) 
            end
        end
    end

    Players.PlayerAdded:Connect(function(player)
        if player == LocalPlayer then return end
        player.CharacterAdded:Connect(function(char)
            if getPlayerTitle(player) then 
                task.wait(0.5)
                createTitleBillboard(player, char) 
            end
        end)
    end)
    Players.PlayerRemoving:Connect(removeTitleBillboard)

    local tabProfile = Window:Tab("资料区", "85887401411044")
    local sectionProfile = tabProfile:Section("款脚本身份", {Y = "94054854845750", F = "94054854845750"}, true)

    local function onProfileClick(name)
        easterEggClicked[name] = true
        local clickedCount = 0
        for _, _ in pairs(easterEggClicked) do
            clickedCount = clickedCount + 1
        end
        if clickedCount >= totalProfileCount then
            triggerEasterEgg()
        end
    end

    sectionProfile:Image({Title = "付款", Subtitle = "款脚本作者", Description = {"身份：小款没吃饱", "Q群：1087878073", "我真求你了"}, Icon = "rbxassetid://72464253114782", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了付款的资料", "Info", 2) onProfileClick("付款") end})
    sectionProfile:Image({Title = "中皮", Subtitle = "款脚本副作者", Description = {"身份：脚本哥", "无", "无"}, Icon = "rbxassetid://83204773411249", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了中皮的资料", "Info", 2) onProfileClick("中皮") end})
    sectionProfile:Image({Title = "风御", Subtitle = "殺脚本作者", Description = {"身份：疯子（刺猬）", "殺脚本主群819104139", "殺脚本副群1094790583"}, Icon = "rbxassetid://89381853103913", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了殺脚本作者的资料", "Info", 2) onProfileClick("风御") end})
    sectionProfile:Image({Title = "小番", Subtitle = "管理员", Description = {"身份：番茄🍅", "小番牛逼", "xfnb666"}, Icon = "rbxassetid://138242046027117", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了小番的资料", "Info", 2) onProfileClick("小番") end})
    sectionProfile:Image({Title = "奕夕", Subtitle = "测试人员", Description = {"身份：虚荣屠夫", "他们说我的饥饿是个问题", "事情变得开始有趣起来了"}, Icon = "rbxassetid://133051318196418", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了奕夕的资料", "Info", 2) onProfileClick("奕夕") end})
    sectionProfile:Image({Title = "只爱", Subtitle = "测试人员", Description = {"身份：奶烙", "小只爱", "3f"}, Icon = "rbxassetid://106483682176624", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了只爱的资料", "Info", 2) onProfileClick("只爱") end})
    sectionProfile:Image({Title = "我是Noob", Subtitle = "管理员", Description = {"身份：Noob", "我爱脚本", "玩脚本这一块"}, Icon = "rbxassetid://118200262618824", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了我是Noob的资料", "Info", 2) onProfileClick("我是Noob") end})
    sectionProfile:Image({Title = "cube", Subtitle = "管理员", Description = {"身份：披萨员", "pizza！", "立方体"}, Icon = "rbxassetid://104898690520306", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了Pizza的资料", "Info", 2) onProfileClick("cube") end})

    local tabCommon = Window:Tab("通用", "85043685370431")
    local sectionCommon = tabCommon:Section("自身修改", {Y = "127278444393372", F = "127278444393372"}, true)

    local aimEnabled = false
    local speedEnabled = false
    local speedValue = 16
    local jumpEnabled = false
    local jumpValue = 50
    local featureHeartbeat = nil

    local function updateFeatureHeartbeat()
        local needLoop = aimEnabled or speedEnabled or jumpEnabled
        if needLoop and not featureHeartbeat then
            featureHeartbeat = RunService.Heartbeat:Connect(function()
                local char = LocalPlayer.Character
                if not char then return end
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if not humanoid then return end
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then return end
                if aimEnabled then
                    local nearestHead, nearestDist = nil, math.huge
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer then
                            local otherChar = player.Character
                            if otherChar then
                                local head = otherChar:FindFirstChild("Head")
                                if head then
                                    local dist = (root.Position - head.Position).Magnitude
                                    if dist < nearestDist then nearestDist = dist; nearestHead = head end
                                end
                            end
                        end
                    end
                    if nearestHead then
                        local lookPos = nearestHead.Position
                        root.CFrame = CFrame.lookAt(root.Position, Vector3.new(lookPos.X, root.Position.Y, lookPos.Z))
                    end
                end
                if speedEnabled then humanoid.WalkSpeed = speedValue else humanoid.WalkSpeed = 16 end
                if jumpEnabled then humanoid.JumpPower = jumpValue else humanoid.JumpPower = 50 end
            end)
        elseif not needLoop and featureHeartbeat then
            featureHeartbeat:Disconnect(); featureHeartbeat = nil
            local char = LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    if not speedEnabled then humanoid.WalkSpeed = 16 end
                    if not jumpEnabled then humanoid.JumpPower = 50 end
                end
            end
        end
    end

    LocalPlayer.CharacterAdded:Connect(function(char)
        if speedEnabled then 
            task.wait()
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = speedValue end 
        end
        if jumpEnabled then 
            task.wait()
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = jumpValue end 
        end
    end)

    sectionCommon:Toggle("改速度", false, function(state) 
        speedEnabled = state
        updateFeatureHeartbeat()
        Window:Notification("改速度", state and "已开启" or "已关闭", state and "Success" or "Info", 2) 
    end)
    sectionCommon:Slider("速度数值", 0, 500, 16, function(val) 
        speedValue = val
        if speedEnabled and LocalPlayer.Character then 
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = val end 
        end 
    end)
    sectionCommon:Toggle("改跳跃", false, function(state) 
        jumpEnabled = state
        updateFeatureHeartbeat()
        Window:Notification("改跳跃", state and "已开启" or "已关闭", state and "Success" or "Info", 2) 
    end)
    sectionCommon:Slider("跳跃高度", 0, 500, 50, function(val) 
        jumpValue = val
        if jumpEnabled and LocalPlayer.Character then 
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = val end 
        end 
    end)

    local sectionCommon2 = tabCommon:Section("通用功能", {Y = "89197120299249", F = "89197120299249"}, true)

    local espEnabled = false
    local espCache = {}

    local function getPlayerDisplayName(player)
        local title = getPlayerTitle(player)
        if title then return title end
        if player.DisplayName and player.DisplayName ~= "" then return player.DisplayName end
        return player.Name
    end

    local function addESP(player)
        if espCache[player] and espCache[player].highlight then return end
        
        local function onCharacterAdded(character)
            local old = espCache[player]
            if old then
                if old.highlight then pcall(function() old.highlight:Destroy() end) end
                if old.billboard then pcall(function() old.billboard:Destroy() end) end
                if old.connections then
                    for _, conn in ipairs(old.connections) do
                        if conn then pcall(function() conn:Disconnect() end) end
                    end
                end
            end
            
            local humanoid = character:WaitForChild("Humanoid", 5)
            if not humanoid then return end
            local head = character:WaitForChild("Head", 5)
            if not head then return end
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESP_Highlight"
            highlight.Adornee = character
            highlight.FillTransparency = 1
            highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
            highlight.OutlineTransparency = 0
            highlight.Parent = character
            
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESP_Billboard"
            billboard.Adornee = head
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 2, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = head
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1,0,1,0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.fromRGB(255,255,255)
            label.TextStrokeTransparency = 0
            label.Font = Enum.Font.SourceSansBold
            label.TextScaled = true
            label.Parent = billboard
            
            local function update()
                if humanoid and humanoid.Parent and head and head.Parent then
                    local displayName = getPlayerDisplayName(player)
                    label.Text = string.format("%s\n%d/%d", displayName, math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))
                end
            end
            
            update()
            
            local connections = {}
            table.insert(connections, humanoid.HealthChanged:Connect(update))
            
            local existingData = espCache[player] or {}
            espCache[player] = {
                charConnection = existingData.charConnection,
                highlight = highlight,
                billboard = billboard,
                connections = connections
            }
        end
        
        if player.Character then onCharacterAdded(player.Character) end
        
        local existingData = espCache[player] or {}
        if existingData.charConnection then
            pcall(function() existingData.charConnection:Disconnect() end)
        end
        local charConn = player.CharacterAdded:Connect(onCharacterAdded)
        espCache[player] = espCache[player] or {}
        espCache[player].charConnection = charConn
    end

    local function removeESP(player)
        local data = espCache[player]
        if not data then return end
        
        if data.charConnection then pcall(function() data.charConnection:Disconnect() end) end
        if data.connections then
            for _, conn in ipairs(data.connections) do 
                if conn then pcall(function() conn:Disconnect() end) end 
            end
        end
        if data.highlight then pcall(function() data.highlight:Destroy() end) end
        if data.billboard then pcall(function() data.billboard:Destroy() end) end
        
        espCache[player] = nil
    end

    local playerAddedConn, playerRemovingConn
    sectionCommon2:Toggle("透视（绿色轮廓+信息）", false, function(state)
        espEnabled = state
        if state then
            for player, _ in pairs(espCache) do removeESP(player) end
            espCache = {}
            for _, player in ipairs(Players:GetPlayers()) do 
                if player ~= LocalPlayer then addESP(player) end 
            end
            if playerAddedConn then playerAddedConn:Disconnect() end
            if playerRemovingConn then playerRemovingConn:Disconnect() end
            playerAddedConn = Players.PlayerAdded:Connect(function(player) 
                if player ~= LocalPlayer and espEnabled then addESP(player) end 
            end)
            playerRemovingConn = Players.PlayerRemoving:Connect(function(player) removeESP(player) end)
            Window:Notification("透视", "已开启", "Success", 2)
        else
            espEnabled = false
            if playerAddedConn then playerAddedConn:Disconnect(); playerAddedConn = nil end
            if playerRemovingConn then playerRemovingConn:Disconnect(); playerRemovingConn = nil end
            for player, _ in pairs(espCache) do removeESP(player) end
            espCache = {}
            Window:Notification("透视", "已关闭", "Info", 2)
        end
    end)

    local noclipEnabled = false
    local noclipHeartbeat = nil
    local originalCollidableParts = {}

    local function enableNoclipForCharacter(character)
        if not character then return end
        local parts = {}
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide == true then
                table.insert(parts, part)
                part.CanCollide = false
            end
        end
        originalCollidableParts[character] = parts
    end

    local function disableNoclipForCharacter(character)
        local parts = originalCollidableParts[character]
        if parts then
            for _, part in ipairs(parts) do
                if part and part.Parent then part.CanCollide = true end
            end
            originalCollidableParts[character] = nil
        end
    end

    local function startNoclipLoop()
        if noclipHeartbeat then return end
        noclipHeartbeat = RunService.Heartbeat:Connect(function()
            if noclipEnabled and LocalPlayer.Character then
                local char = LocalPlayer.Character
                local parts = originalCollidableParts[char]
                if parts then
                    for _, part in ipairs(parts) do
                        if part and part.Parent then part.CanCollide = false end
                    end
                end
            end
        end)
    end

    local function stopNoclipLoop()
        if noclipHeartbeat then noclipHeartbeat:Disconnect(); noclipHeartbeat = nil end
    end

    LocalPlayer.CharacterAdded:Connect(function(character)
        if noclipEnabled then task.wait(); enableNoclipForCharacter(character) end
    end)

    sectionCommon2:Toggle("穿墙模式（永久）", false, function(state)
        noclipEnabled = state
        if state then
            if LocalPlayer.Character then enableNoclipForCharacter(LocalPlayer.Character) end
            startNoclipLoop()
            Window:Notification("穿墙", "已开启", "Success", 2)
        else
            if LocalPlayer.Character then disableNoclipForCharacter(LocalPlayer.Character) end
            stopNoclipLoop()
            Window:Notification("穿墙", "已关闭", "Info", 2)
        end
    end)

    local invisibleEnabled = false
    local function setCharacterInvisible(character, invisible)
        if not character then return end
        for _, part in ipairs(character:GetDescendants()) do 
            if part:IsA("BasePart") then part.LocalTransparencyModifier = invisible and 1 or 0 end 
        end
    end
    LocalPlayer.CharacterAdded:Connect(function(character) 
        if invisibleEnabled then task.wait(); setCharacterInvisible(character, true) end 
    end)
    sectionCommon2:Toggle("隐身", false, function(state)
        invisibleEnabled = state
        if state then
            if LocalPlayer.Character then setCharacterInvisible(LocalPlayer.Character, true) end
            Window:Notification("隐身", "已开启", "Success", 2)
        else
            if LocalPlayer.Character then setCharacterInvisible(LocalPlayer.Character, false) end
            Window:Notification("隐身", "已关闭", "Info", 2)
        end
    end)

    local infiniteJumpEnabled = false
    UserInputService.JumpRequest:Connect(function()
        if infiniteJumpEnabled and LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end)
    sectionCommon2:Toggle("无限跳", false, function(state) 
        infiniteJumpEnabled = state
        Window:Notification("无限跳", state and "已开启" or "已关闭", state and "Success" or "Info", 2) 
    end)
    sectionCommon2:Button("死亡笔记", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))() end)
    sectionCommon2:Button("自死", function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health = 0 end end)
    sectionCommon2:Button("踏空行走", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))() end)
    sectionCommon2:Button("视角可提超广角", function() workspace.CurrentCamera.FieldOfView = 100 end)
    sectionCommon2:Button("铁拳", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))() end)
    sectionCommon2:Toggle("反挂机", false, function(state)
        if state then loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))(); Window:Notification("反挂机", "已开启", "Success", 2)
        else Window:Notification("反挂机", "关闭需要重新加入游戏", "Info", 2) end
    end)
    sectionCommon2:Button("汉化", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Wlzhmaa/UWU/refs/heads/main/Chinese%20translation"))() end)
    sectionCommon2:Button("汉化Dex", function() loadstring(game:HttpGet("https://gitee.com/cmbhbh/cmbh/raw/master/Bex.lua"))() end)

    local sectionAim = tabCommon:Section("自瞄区域", {Y = "134293959597321", F = "134293959597321"}, true)
    sectionAim:Button("阿尔宙斯同款自瞄", function() 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/sgbs/main/%E4%B8%81%E4%B8%81%20%E6%B1%89%E5%8C%96%E8%87%AA%E7%9E%84.txt"))()
        Window:Notification("自瞄区域", "阿尔宙斯自瞄已加载", "Success", 2) 
    end)
    sectionAim:Toggle("自瞄（瞄准头部）", false, function(state) 
        aimEnabled = state
        updateFeatureHeartbeat()
        Window:Notification("自瞄区域", "自瞄 " .. (state and "已开启" or "已关闭"), "Success", 2) 
    end)

    local sectionFling = tabCommon:Section("甩飞区域", {Y = "113899846067098", F = "113899846067098"}, true)
    local antiKnockbackEnabled = false
    local antiKnockbackConnection = nil
    sectionFling:Toggle("防甩飞（无碰撞箱）", false, function(state)
        antiKnockbackEnabled = state
        if state then
            if LocalPlayer.Character then
                local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root then root.CanCollide = false end
            end
            antiKnockbackConnection = LocalPlayer.CharacterAdded:Connect(function(char)
                if not antiKnockbackEnabled then antiKnockbackConnection:Disconnect(); return end
                local root = char:WaitForChild("HumanoidRootPart")
                root.CanCollide = false
            end)
            Window:Notification("防甩飞", "已开启（删除碰撞箱）", "Success", 2)
        else
            if antiKnockbackConnection then antiKnockbackConnection:Disconnect(); antiKnockbackConnection = nil end
            if LocalPlayer.Character then
                local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root then root.CanCollide = true end
            end
            Window:Notification("防甩飞", "已关闭", "Info", 2)
        end
    end)
    sectionFling:Button("甩飞(先开飞行再开)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%97%8B%E8%BD%AC.lua"))() end)
    sectionFling:Toggle("甩飞所有人", false, function(state)
        if state then loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))(); Window:Notification("甩飞", "已开启", "Success", 2)
        else Window:Notification("甩飞", "关闭需要重新加入游戏", "Info", 2) end
    end)

    local tabFun = Window:Tab("娱乐(FE)", "117911709021357")
    local sectionFun = tabFun:Section("FE以及娱乐功能", {Y = "113580079129703", F = "113580079129703"}, true)
    sectionFun:Button("C00lgui", function() loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)() end)
    sectionFun:Button("M 47", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/sinret/rbxscript.com-scripts-reuploads-/main/ak47", true))() end)
    sectionFun:Button("电脑键盘", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))() end)
    sectionFun:Button("飞檐走壁", function() loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))() end)

    local sectionFun2 = tabFun:Section("动作类", {Y = "101403657260817", F = "101403657260817"}, true)
    sectionFun2:Button("动作", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-7yd7-I-Emote-Script-48024"))() end)
    sectionFun2:Button("SCP-096", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-SCP-096-36948"))() end)
    sectionFun2:Button("变车", function() loadstring(game:HttpGet("https://pastefy.app/UqDEIOpO/raw"))() end)
    sectionFun2:Button("撸管R15", function() loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))() end)
    sectionFun2:Button("撸管R6", function() loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))() end)
    sectionFun2:Button("打人", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-THE-REAL-dropkick-177199"))() end)

    local tabMusic = Window:Tab("音乐", "98485449573808")
    local currentSound = nil
    local function stopSound()
        if currentSound then currentSound:Stop(); currentSound:Destroy(); currentSound = nil end
    end
    local function playSoundById(id, notifyName)
        stopSound()
        if not id or id == "" then Window:Notification("音乐", "无效的音乐ID", "Error", 2) return end
        currentSound = Instance.new("Sound")
        currentSound.SoundId = id
        currentSound.Volume = 1
        currentSound.Parent = LocalPlayer.PlayerGui
        currentSound:Play()
        local soundRef = currentSound
        soundRef.Ended:Connect(function()
            if currentSound == soundRef then currentSound = nil end
            soundRef:Destroy()
        end)
        if notifyName then Window:Notification("音乐", "正在播放：" .. notifyName, "Success", 3) end
    end

    local sectionHall = tabMusic:Section("音乐大厅", {Y = "102502304372289", F = "102502304372289"}, true)
    local musicLibrary = {
        {name = "雨爱", id = "rbxassetid://79277371759525"},
        {name = "起风了", id = "rbxassetid://99498025749186"},
        {name = "鸟之诗", id = "rbxassetid://113665010217108"},
        {name = "唯一", id = "rbxassetid://138570939058838"},
        {name = "azure与Two time", id = "rbxassetid://77715601943266"},
    }
    local selectedHall = musicLibrary[1].name
    local hallNames = {}
    for _, m in ipairs(musicLibrary) do table.insert(hallNames, m.name) end
    sectionHall:Dropdown("🎵 选择音乐", hallNames, function(choice) selectedHall = choice end)
    sectionHall:Button("▶ 播放", function()
        for _, m in ipairs(musicLibrary) do if m.name == selectedHall then playSoundById(m.id, m.name) break end end
    end)
    sectionHall:Button("⏸ 暂停", function()
        if currentSound and currentSound.IsPlaying then currentSound:Pause(); Window:Notification("音乐", "已暂停", "Info", 2)
        else Window:Notification("音乐", "没有正在播放的音乐", "Error", 2) end
    end)
    sectionHall:Button("▶ 继续", function()
        if currentSound and not currentSound.IsPlaying then currentSound:Resume(); Window:Notification("音乐", "已继续", "Success", 2)
        elseif currentSound then Window:Notification("音乐", "音乐正在播放中", "Info", 2)
        else Window:Notification("音乐", "没有暂停的音乐", "Error", 2) end
    end)

    local customMusicId = ""
    local sectionCustomMusic = tabMusic:Section("音乐ID", {Y = "92109853056999", F = "92109853056999"}, true)
    sectionCustomMusic:Textbox("输入音乐ID（纯数字）", "例如：12345678", function(val) customMusicId = val end)
    sectionCustomMusic:Button("播放自定义音乐", function() playSoundById("rbxassetid://" .. customMusicId, "自定义音乐") end)
    sectionCustomMusic:Button("暂停音乐", function()
        if currentSound and currentSound.IsPlaying then currentSound:Pause(); Window:Notification("音乐", "已暂停", "Info", 2)
        else Window:Notification("音乐", "没有正在播放的音乐", "Error", 2) end
    end)
    sectionCustomMusic:Button("继续播放", function()
        if currentSound and not currentSound.IsPlaying then currentSound:Resume(); Window:Notification("音乐", "已继续", "Success", 2)
        elseif currentSound then Window:Notification("音乐", "音乐正在播放中", "Info", 2)
        else Window:Notification("音乐", "没有暂停的音乐", "Error", 2) end
    end)

    local sectionBattle = tabMusic:Section("一些梗音效", {Y = "139719142899671", F = "139719142899671"}, true)
    local battleSounds = {
        {name = "乌鲁鲁", id = "rbxassetid://80701295792893"},
        {name = "关注塔菲谢谢喵", id = "rbxassetid://126774078187195"},
        {name = "大东北", id = "rbxassetid://134786908423441"},
    }
    local selectedBattle = battleSounds[1].name
    local battleNames = {}
    for _, s in ipairs(battleSounds) do table.insert(battleNames, s.name) end
    sectionBattle:Dropdown("🎵 选择梗音效", battleNames, function(choice) selectedBattle = choice end)
    sectionBattle:Button("▶ 播放", function()
        for _, s in ipairs(battleSounds) do if s.name == selectedBattle then playSoundById(s.id, s.name) break end end
    end)
    sectionBattle:Button("⏸ 暂停", function()
        if currentSound and currentSound.IsPlaying then currentSound:Pause(); Window:Notification("音效", "已暂停", "Info", 2)
        else Window:Notification("音效", "没有正在播放的音效", "Error", 2) end
    end)
    sectionBattle:Button("▶ 继续", function()
        if currentSound and not currentSound.IsPlaying then currentSound:Resume(); Window:Notification("音效", "已继续", "Success", 2)
        elseif currentSound then Window:Notification("音效", "音效正在播放中", "Info", 2)
        else Window:Notification("音效", "没有暂停的音效", "Error", 2) end
    end)

    local tabOtherScripts = Window:Tab("其他脚本", "115947871467249")
    local sectionOther = tabOtherScripts:Section("通用", {Y = "129170176484820", F = "129170176484820"}, true)
    sectionOther:Button("皮脚本", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))() end)
    sectionOther:Button("叶脚本", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua"))() end)
    sectionOther:Button("落叶中心", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/krlpl/Deciduous-center-LS/main/%E8%90%BD%E5%8F%B6%E4%B8%AD%E5%BF%83%E6%B7%B7%E6%B7%86.txt"))() end)
    sectionOther:Button("(殺)通用", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-X/_Hub_/refs/heads/X/sha.lua"))() end)

    local sectionSpecial = tabOtherScripts:Section("殺脚本", {Y = "84848865030433", F = "84848865030433"}, true)
    sectionSpecial:Button("(殺)被遗弃", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-X/Max/refs/heads/X/fsk.lua"))() end)
    sectionSpecial:Button("(殺)成果记忆", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-X/Max/refs/heads/X/OM.lua"))() end)
    sectionSpecial:Button("(殺)撕咬之夜", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-X/Max/refs/heads/X/BBN.lua"))() end)
    sectionSpecial:Button("(殺)死亡之死", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-X/Max/refs/heads/X/DOD.lua"))() end)

    local tabConfig = Window:Tab("配置管理")
    local sectionConfig = tabConfig:Section("配置设置")
    Window.CurrentConfig = "None"
    local ConfigName = ""
    sectionConfig:Textbox("配置名字", "输入配置名", function(val) ConfigName = val end)
    local dropdownObj
    local ConfigPaths = {}
    local function RefreshConfigs()
        pcall(function()
            if not isfolder(Window.RootFolder) then makefolder(Window.RootFolder) end
            if not isfolder(Window.ConfigFolder) then makefolder(Window.ConfigFolder) end
        end)
        local newList = {"None"}
        local newPaths = {}
        pcall(function()
            for _, file in pairs(listfiles(Window.ConfigFolder)) do
                local name = file:gsub(".*[\\/]", ""):gsub("%.json$", "")
                if name ~= "" then table.insert(newList, name); newPaths[name] = file end
            end
        end)
        ConfigPaths = newPaths
        if dropdownObj then pcall(function() dropdownObj.Refresh(newList) end) end
    end
    dropdownObj = sectionConfig:Dropdown("选择配置", {"None"}, function(val) Window.CurrentConfig = val end)
    sectionConfig:Button("刷新列表", RefreshConfigs)
    sectionConfig:Button("保存配置", function()
        if ConfigName == "" then Window:Notification("保存错误", "请填写配置名", "Error", 2) return end
        library:SaveConfig(ConfigName, Window.ConfigFolder)
        RefreshConfigs()
        Window:Notification("成功保存", "配置保存为 " .. ConfigName, "Success", 2)
    end)
    sectionConfig:Button("加载配置", function()
        if Window.CurrentConfig == "" or Window.CurrentConfig == "None" then Window:Notification("加载错误", "请先选择一个配置", "Error", 2) return end
        local name = Window.CurrentConfig
        local path = ConfigPaths[name] or (Window.ConfigFolder .. "/" .. name .. ".json")
        Window:Notification("正在加载", "正在载入 " .. name, "Info", 2)
        local ok = library:LoadConfig(path)
        if ok then Window:Notification("加载成功", name .. " 已加载", "Success", 2)
        else Window:Notification("错误", "加载失败", "Error", 2) end
    end)
    sectionConfig:Button("删除配置", function()
        if Window.CurrentConfig == "" or Window.CurrentConfig == "None" then Window:Notification("错误", "请先选择要删除的配置", "Error", 2) return end
        local name = Window.CurrentConfig
        pcall(function()
            for _, path in ipairs({ConfigPaths[name], Window.ConfigFolder .. "/" .. name .. ".json", Window.ConfigFolder .. "\\" .. name .. ".json"}) do
                if path and isfile(path) then delfile(path) break end
            end
        end)
        Window.CurrentConfig = "None"
        task.wait(0.05)
        RefreshConfigs()
        if dropdownObj and dropdownObj.Reset then dropdownObj.Reset() end
        Window:Notification("成功", name .. " 已删除", "Success", 2)
    end)
    RefreshConfigs()

    local tabUISettings = Window:Tab("UI设置")
    local sectionUI = tabUISettings:Section("界面设置")
    sectionUI:Toggle("彩虹边框", false, function(v) library:ToggleRainbow(v) end)
    sectionUI:Slider("边框速度", 0.1, 10, 1, function(v) library:SetRainbowSpeed(v) end)
    local rainbowTypeMap = {
        ["线性渐变（实心彩虹）"] = "Linear Gradient (Solid Rainbow)",
        ["动态/循环彩虹"] = "Animated/Cycling Rainbow",
        ["平滑渐变"] = "Smooth Fading Gradient",
        ["分段/条带彩虹"] = "Step/Band Rainbow",
        ["彩虹脉冲"] = "Rainbow Pulse",
        ["径向彩虹"] = "Radial Rainbow",
        ["霓虹/发光彩虹"] = "Neon/Glowing Rainbow",
        ["柔和彩虹"] = "Pastel Rainbow",
        ["垂直/水平渐变"] = "Vertical/Horizontal Fade"
    }
    local rainbowTypeDisplay = {}
    for display, _ in pairs(rainbowTypeMap) do table.insert(rainbowTypeDisplay, display) end
    sectionUI:Dropdown("边框类型", rainbowTypeDisplay, function(val) library:SetRainbowType(rainbowTypeMap[val]) end)
    local themeMap = {
        ["暗色"] = "Dark",
        ["白色"] = "White",
        ["紫色"] = "Purple",
        ["蓝色"] = "Blue",
        ["红色"] = "Red",
        ["黄色"] = "Yellow",
        ["绿色"] = "Green"
    }
    local themeDisplay = {}
    for display, _ in pairs(themeMap) do table.insert(themeDisplay, display) end
    sectionUI:Dropdown("主题颜色", themeDisplay, function(v) library:SetTheme(themeMap[v]) end)
    sectionUI:Keybind("菜单键绑定", Enum.KeyCode.RightShift, function(v) Window:SetKeybind(v) end)
    sectionUI:Button("摧毁界面", function() Window:Destroy() end)
end

-- 开场动画
local function showTitleAnimation()
    local animGui = Instance.new("ScreenGui")
    animGui.Name = "TitleAnimation"
    animGui.ResetOnSpawn = false
    animGui.Parent = LocalPlayer.PlayerGui

    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 0, 0, 100)
    card.Position = UDim2.new(0, 50, 0.55, -50)
    card.AnchorPoint = Vector2.new(0, 0.5)
    card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    card.BorderSizePixel = 0
    card.BackgroundTransparency = 0.05
    card.Parent = animGui

    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 12)
    cardCorner.Parent = card

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = ""
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 32
    titleLabel.TextTransparency = 1
    titleLabel.TextStrokeTransparency = 0
    titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 200, 220)
    titleLabel.Parent = card

    local tweenCard = TweenService:Create(card, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 300, 0, 100),
        Position = UDim2.new(0.5, -150, 0.55, -50)
    })
    tweenCard:Play()

    task.wait(0.7)

    local fullText = "款脚本"
    local result = ""
    for _, code in utf8.codes(fullText) do
        result = result .. utf8.char(code)
        titleLabel.Text = result
        titleLabel.TextTransparency = 0
        task.wait(0.3)
    end

    local tweenToCyan = TweenService:Create(titleLabel, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        TextColor3 = Color3.fromRGB(0, 200, 220)
    })
    tweenToCyan:Play()
    tweenToCyan.Completed:Wait()

    task.wait(0.3)

    for i = 1, 10 do
        card.BackgroundTransparency = math.min(1, card.BackgroundTransparency + 0.1)
        titleLabel.TextTransparency = math.min(1, titleLabel.TextTransparency + 0.1)
        task.wait(0.05)
    end

    animGui:Destroy()
    buildUI()
end

local function continueStartup()
    local sound
    if #STARTUP_MUSIC_IDS > 0 then
        local randomId = STARTUP_MUSIC_IDS[math.random(1, #STARTUP_MUSIC_IDS)]
        if randomId ~= "rbxassetid://0" then
            sound = Instance.new("Sound")
            sound.SoundId = randomId
            sound.Volume = 1
            sound.Parent = LocalPlayer.PlayerGui
            sound:Play()
        end
    end

    local effectGui = Instance.new("ScreenGui")
    effectGui.Name = "启动特效"
    effectGui.ResetOnSpawn = false
    effectGui.Parent = LocalPlayer.PlayerGui

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundTransparency = 1
    bg.BorderSizePixel = 0
    bg.Parent = effectGui

    local topText = Instance.new("TextLabel")
    topText.Size = UDim2.new(1, 0, 0, 50)
    topText.Position = UDim2.new(0, 0, 0.05, 0)
    topText.BackgroundTransparency = 1
    topText.Text = "款脚本加载中..."
    topText.TextColor3 = Color3.fromRGB(0, 200, 220)
    topText.Font = Enum.Font.SourceSansBold
    topText.TextSize = 28
    topText.TextStrokeTransparency = 0.5
    topText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    topText.Parent = effectGui

    task.spawn(function()
        while topText.Parent do
            TweenService:Create(topText, TweenInfo.new(0.5), {TextTransparency = 0.7}):Play()
            task.wait(0.5)
            TweenService:Create(topText, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
            task.wait(0.5)
        end
    end)

    local codeText = "付款牛逼"
    local numRain = 50
    local rainData = {}
    for i = 1, numRain do
        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Text = codeText
        label.TextColor3 = Color3.fromRGB(0, 200, 220)
        label.Font = Enum.Font.SourceSansBold
        label.TextSize = 16
        label.TextTransparency = 0.2
        label.Parent = effectGui
        label.Position = UDim2.new(math.random(0, 100) / 100, 0, 1 + math.random(0, 50) / 100, 0)
        table.insert(rainData, {label = label, speed = 0.3 + math.random(0, 15) / 10})
    end

    local connection = RunService.Heartbeat:Connect(function(deltaTime)
        for _, data in ipairs(rainData) do
            local lbl = data.label
            if lbl and lbl.Parent then
                local newY = lbl.Position.Y.Scale - data.speed * deltaTime
                if newY < -0.3 then
                    lbl.Position = UDim2.new(math.random(0, 100) / 100, 0, 1 + math.random(0, 30) / 100, 0)
                else
                    lbl.Position = UDim2.new(lbl.Position.X.Scale, 0, newY, 0)
                end
            end
        end
    end)

    task.delay(3, function()
        connection:Disconnect()
        effectGui:Destroy()
        if sound then sound:Destroy() end
        showTitleAnimation()
    end)
end

continueStartup()