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

local function showStartupEffect()
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
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 0.3
    bg.BorderSizePixel = 0
    bg.Parent = effectGui

    local topText = Instance.new("TextLabel")
    topText.Size = UDim2.new(1, 0, 0, 50)
    topText.Position = UDim2.new(0, 0, 0.05, 0)
    topText.BackgroundTransparency = 1
    topText.Text = "付款脚本加载中..."
    topText.TextColor3 = Color3.fromRGB(0, 200, 220)
    topText.Font = Enum.Font.SourceSansBold
    topText.TextSize = 28
    topText.TextStrokeTransparency = 0.5
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
        loadMainScript()
    end)
end

showStartupEffect()

function loadMainScript()
    local adminList = {
        "zxc110819", 
        "NOOOPLSDONTletme444", 
        "aa1360051",
        "FengY3", 
        "FengYu303", 
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

    local function IsAdminOrAuthor()
        return isInList(adminList, LocalPlayer.Name) or isInList(authorList, LocalPlayer.Name)
    end

    if isInList(blacklist, LocalPlayer.Name) then
        LocalPlayer:Kick("错误代码 246：您已被禁止使用此脚本")
        return
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
        if playerTitleBillboards[player] then playerTitleBillboards[player]:Destroy() end

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
            playerTitleBillboards[player]:Destroy()
            playerTitleBillboards[player] = nil
        end
    end

    local function handlePlayerCharacter(player, character)
        if getPlayerTitle(player) then createTitleBillboard(player, character) end
        player.CharacterAdded:Connect(function(newChar)
            if getPlayerTitle(player) then wait(0.5); createTitleBillboard(player, newChar) end
        end)
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if player.Character then handlePlayerCharacter(player, player.Character)
            else player.CharacterAdded:Connect(function(char) handlePlayerCharacter(player, char) end) end
        end
    end

    Players.PlayerAdded:Connect(function(player)
        if player == LocalPlayer then return end
        player.CharacterAdded:Connect(function(char)
            if getPlayerTitle(player) then wait(0.5); createTitleBillboard(player, char) end
        end)
    end)
    Players.PlayerRemoving:Connect(removeTitleBillboard)

    if IsAdminOrAuthor() and userRoleName then
        local tabAdminOnly = Window:Tab(userRoleName .. "权限")
        local sectionAdminOnly = tabAdminOnly:Section(userRoleName .. "专属功能", {Y = "99282742934566", F = "99282742934566"}, true)

        local adminAimEnabled = false
        local adminNoclipEnabled = false
        local adminSpeedEnabled = false
        local adminJumpEnabled = false
        local adminHeartbeat = nil
        local adminSpeedValue = 16
        local adminJumpValue = 50

        local function updateAdminHeartbeat()
            local need = adminAimEnabled or adminNoclipEnabled or adminSpeedEnabled or adminJumpEnabled
            if need and not adminHeartbeat then
                adminHeartbeat = RunService.Heartbeat:Connect(function()
                    local char = LocalPlayer.Character
                    if not char then return end
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if not root then return end
                    if adminAimEnabled then
                        local nearestHead, minDist = nil, math.huge
                        for _, p in ipairs(Players:GetPlayers()) do
                            if p ~= LocalPlayer then
                                local otherChar = p.Character
                                if otherChar then
                                    local head = otherChar:FindFirstChild("Head")
                                    if head then
                                        local d = (root.Position - head.Position).Magnitude
                                        if d < minDist then minDist = d; nearestHead = head end
                                    end
                                end
                            end
                        end
                        if nearestHead then
                            root.CFrame = CFrame.lookAt(root.Position, Vector3.new(nearestHead.Position.X, root.Position.Y, nearestHead.Position.Z))
                        end
                    end
                    if adminNoclipEnabled and hum then hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false) end
                    if adminSpeedEnabled and hum then hum.WalkSpeed = adminSpeedValue end
                    if adminJumpEnabled and hum then hum.JumpPower = adminJumpValue end
                end)
            elseif not need and adminHeartbeat then
                adminHeartbeat:Disconnect(); adminHeartbeat = nil
                local char = LocalPlayer.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then hum:SetStateEnabled(Enum.HumanoidStateType.Physics, true); hum.WalkSpeed = 16; hum.JumpPower = 50 end
                end
            end
        end

        sectionAdminOnly:Toggle(userRoleName .. "自瞄", false, function(state) adminAimEnabled = state; updateAdminHeartbeat(); Window:Notification(userRoleName .. "权限", "自瞄 " .. (state and "开启" or "关闭"), "Success", 2)
end)
        
        sectionAdminOnly:Toggle(userRoleName .. "穿墙", false, function(state) adminNoclipEnabled = state; updateAdminHeartbeat(); Window:Notification(userRoleName .. "权限", "穿墙 " .. (state and "开启" or "关闭"), "Success", 2)
end)
        
        sectionAdminOnly:Button(userRoleName .. "飞行", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/improved-sy/refs/heads/main/%E6%AE%BA%E9%A3%9E%E8%A1%8C.lua"))(); Window:Notification(userRoleName .. "权限", "飞行已加载", "Success", 2) 
end)
        
        sectionAdminOnly:Slider(userRoleName .. "速度", 0, 500, 16, function(val) adminSpeedValue = val; if adminSpeedEnabled and LocalPlayer.Character then local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if hum then hum.WalkSpeed = val end end end)
        
        sectionAdminOnly:Toggle("启用" .. userRoleName .. "速度", false, function(state) adminSpeedEnabled = state; updateAdminHeartbeat(); Window:Notification(userRoleName .. "权限", "速度 " .. (state and "开启" or "关闭"), "Success", 2) end)
        
        sectionAdminOnly:Slider(userRoleName .. "跳跃高度", 0, 500, 50, function(val) adminJumpValue = val; if adminJumpEnabled and LocalPlayer.Character then local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if hum then hum.JumpPower = val end end end)
        
        sectionAdminOnly:Toggle("启用" .. userRoleName .. "跳跃", false, function(state) adminJumpEnabled = state; updateAdminHeartbeat(); Window:Notification(userRoleName .. "权限", "跳跃 " .. (state and "开启" or "关闭"), "Success", 2) end)
    end

    local tabProfile = Window:Tab("资料区", "85887401411044")
    local sectionAnnounce = tabProfile:Section("📢 更新公告", {Y = "109679829794228", F = "109679829794228"}, true)
    
    local announceText = sectionAnnounce:Label("【近期更新】\n1. 新增了防甩飞功能\n2. 移除卡密系统\n3. 恢复启动音效\n4. 优化代码结构")

    local sectionProfile = tabProfile:Section("款脚本身份", {Y = "94054854845750", F = "94054854845750"}, true)

    sectionProfile:Image({Title = "付款", Subtitle = "款脚本作者", Description = {"身份：小款没吃饱", "Q群：1087878073", "我真求你了"}, Icon = "rbxassetid://72464253114782", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了付款的资料", "Info", 2)
end})
    
    sectionProfile:Image({Title = "中皮", Subtitle = "款脚本副作者", Description = {"身份：脚本哥", "无", "无"}, Icon = "rbxassetid://83204773411249", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了中皮的资料", "Info", 2) 
end})
    
    sectionProfile:Image({Title = "风御", Subtitle = "殺脚本作者", Description = {"身份：疯子（刺猬）", "殺脚本主群819104139", "殺脚本副群1094790583"}, Icon = "rbxassetid://89381853103913", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了殺脚本作者的资料", "Info", 2)
end})
    
    sectionProfile:Image({Title = "小番", Subtitle = "管理员", Description = {"身份：番茄🍅", "小番牛逼", "xfnb666"}, Icon = "rbxassetid://138242046027117", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了小番的资料", "Info", 2)
end})
    
    sectionProfile:Image({Title = "奕夕", Subtitle = "测试人员", Description = {"身份：虚荣屠夫", "他们说我的饥饿是个问题", "事情变得开始有趣起来了"}, Icon = "rbxassetid://133051318196418", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了奕夕的资料", "Info", 2)
end})
    
    sectionProfile:Image({Title = "我是Noob", Subtitle = "管理员", Description = {"身份：Noob", "我爱脚本", "玩脚本这一块"}, Icon = "rbxassetid://118200262618824", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了我是Noob的资料", "Info", 2)
end})
    
    sectionProfile:Image({Title = "cube", Subtitle = "管理员", Description = {"身份：披萨员", "pizza！", "立方体"}, Icon = "rbxassetid://104898690520306", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了Pizza的资料", "Info", 2) 
end})

local tabCommon = Window:Tab("通用", "85043685370431")

-- ============ 自身修改 ============
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
    if speedEnabled then wait(); local hum = char:FindFirstChildOfClass("Humanoid"); if hum then hum.WalkSpeed = speedValue end end
    if jumpEnabled then wait(); local hum = char:FindFirstChildOfClass("Humanoid"); if hum then hum.JumpPower = jumpValue end end
end)

sectionCommon:Toggle("改速度", false, function(state) speedEnabled = state; updateFeatureHeartbeat(); Window:Notification("改速度", state and "已开启" or "已关闭", state and "Success" or "Info", 2)
end)

sectionCommon:Slider("速度数值", 0, 500, 16, function(val) speedValue = val; if speedEnabled and LocalPlayer.Character then local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if hum then hum.WalkSpeed = val end end 
end)

sectionCommon:Toggle("改跳跃", false, function(state) jumpEnabled = state; updateFeatureHeartbeat(); Window:Notification("改跳跃", state and "已开启" or "已关闭", state and "Success" or "Info", 2) 
end)

sectionCommon:Slider("跳跃高度", 0, 500, 50, function(val) jumpValue = val; if jumpEnabled and LocalPlayer.Character then local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if hum then hum.JumpPower = val end end
end)

-- ============ 通用功能 ============
local sectionCommon2 = tabCommon:Section("通用功能", {Y = "89197120299249", F = "89197120299249"}, true)

sectionCommon2:Button("款飞行", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/improved-sy/refs/heads/main/%E6%AE%BA%E9%A3%9E%E8%A1%8C.lua"))()
end)

local espEnabled = false
local espConnections = {}
local espCache = {}

local function addESP(player)
    local function onCharacterAdded(character)
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
                label.Text = string.format("%s\n%d/%d", player.Name, math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))
            end
        end

        local healthChanged = humanoid.HealthChanged:Connect(update)
        local hbConn = RunService.Heartbeat:Connect(function()
            if not espEnabled or not character.Parent then hbConn:Disconnect(); return end
            update()
        end)

        table.insert(espConnections, {healthChanged, hbConn})
        espCache[player] = {highlight = highlight, billboard = billboard, connections = {healthChanged, hbConn}}
    end

    if player.Character then onCharacterAdded(player.Character) end
    local charConn = player.CharacterAdded:Connect(onCharacterAdded)
    table.insert(espConnections, charConn)
    if not espCache[player] then espCache[player] = {} end
    espCache[player].charConnection = charConn
end

local function removeESP(player)
    local data = espCache[player]
    if not data then return end
    if data.charConnection then data.charConnection:Disconnect() end
    if data.connections then
        for _, conn in ipairs(data.connections) do if conn then conn:Disconnect() end end
    end
    if data.highlight then data.highlight:Destroy() end
    if data.billboard then data.billboard:Destroy() end
    espCache[player] = nil
end

local playerAddedConn, playerRemovingConn
sectionCommon2:Toggle("透视（绿色轮廓+信息）", false, function(state)
    espEnabled = state
    if state then
        for _, player in ipairs(Players:GetPlayers()) do if player ~= LocalPlayer then addESP(player) end end
        playerAddedConn = Players.PlayerAdded:Connect(function(player) if player ~= LocalPlayer then addESP(player) end end)
        playerRemovingConn = Players.PlayerRemoving:Connect(removeESP)
        Window:Notification("透视", "已开启", "Success", 2)
    else
        for player, _ in pairs(espCache) do removeESP(player) end
        if playerAddedConn then playerAddedConn:Disconnect() end
        if playerRemovingConn then playerRemovingConn:Disconnect() end
        espConnections = {}; espCache = {}
        Window:Notification("透视", "已关闭", "Info", 2)
    end
end)

local noclipEnabled = false
local noclipHeartbeat = nil
local function setCharacterCollision(character, enabled)
    if not character then return end
    for _, part in ipairs(character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = not enabled end end
end
local function startNoclipLoop()
    if noclipHeartbeat then return end
    noclipHeartbeat = RunService.Heartbeat:Connect(function() if noclipEnabled and LocalPlayer.Character then setCharacterCollision(LocalPlayer.Character, true) end end)
end
local function stopNoclipLoop() if noclipHeartbeat then noclipHeartbeat:Disconnect(); noclipHeartbeat = nil end end
if LocalPlayer then
    LocalPlayer.CharacterAdded:Connect(function(character) if noclipEnabled then wait(); setCharacterCollision(character, true) else setCharacterCollision(character, false) end end)
    if LocalPlayer.Character then setCharacterCollision(LocalPlayer.Character, false) end
end
sectionCommon2:Toggle("穿墙模式（永久）", false, function(state)
    noclipEnabled = state
    if state then if LocalPlayer.Character then setCharacterCollision(LocalPlayer.Character, true) end; startNoclipLoop(); Window:Notification("穿墙", "已开启", "Success", 2)
    else if LocalPlayer.Character then setCharacterCollision(LocalPlayer.Character, false) end; stopNoclipLoop(); Window:Notification("穿墙", "已关闭", "Info", 2) end
end)

local invisibleEnabled = false
local function setCharacterInvisible(character, invisible)
    if not character then return end
    for _, part in ipairs(character:GetDescendants()) do if part:IsA("BasePart") then part.LocalTransparencyModifier = invisible and 1 or 0 end end
end
if LocalPlayer then
    LocalPlayer.CharacterAdded:Connect(function(character) if invisibleEnabled then wait(); setCharacterInvisible(character, true) end end)
    if LocalPlayer.Character then setCharacterInvisible(LocalPlayer.Character, false) end
end
sectionCommon2:Toggle("隐身", false, function(state)
    invisibleEnabled = state
    if state then if LocalPlayer.Character then setCharacterInvisible(LocalPlayer.Character, true) end; Window:Notification("隐身", "已开启", "Success", 2)
    else if LocalPlayer.Character then setCharacterInvisible(LocalPlayer.Character, false) end; Window:Notification("隐身", "已关闭", "Info", 2) end
end)

local infiniteJumpEnabled = false
UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)
sectionCommon2:Toggle("无限跳", false, function(state) infiniteJumpEnabled = state; Window:Notification("无限跳", state and "已开启" or "已关闭", state and "Success" or "Info", 2) end)

sectionCommon2:Button("死亡笔记", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()
end)

sectionCommon2:Button("自死", function() game.Players.LocalPlayer.Character.Humanoid.Health=0
end)

sectionCommon2:Button("踏空行走", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
end)

sectionCommon2:Button("视角可提超广角", function() Workspace.CurrentCamera.FieldOfView = 100
end)

sectionCommon2:Button("铁拳", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
end)

sectionCommon2:Toggle("反挂机", false, function(state) loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))()
end)

sectionCommon2:Button("汉化", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wlzhmaa/UWU/refs/heads/main/Chinese%20translation"))()
end)

sectionCommon2:Button("汉化Dex", function()
    loadstring(game:HttpGet("https://gitee.com/cmbhbh/cmbh/raw/master/Bex.lua"))()
end)

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
        local char = LocalPlayer.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then root.CanCollide = false end
        end
        local charAdded
        charAdded = LocalPlayer.CharacterAdded:Connect(function(newChar)
            if not antiKnockbackEnabled then charAdded:Disconnect(); return end
            local root = newChar:WaitForChild("HumanoidRootPart")
            root.CanCollide = false
        end)
        antiKnockbackConnection = charAdded
        Window:Notification("防甩飞", "已开启（删除碰撞箱）", "Success", 2)
    else
        if antiKnockbackConnection then antiKnockbackConnection:Disconnect(); antiKnockbackConnection = nil end
        local char = LocalPlayer.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then root.CanCollide = true end
        end
        Window:Notification("防甩飞", "已关闭", "Info", 2)
    end
end)

sectionFling:Button("甩飞(先开飞行再开)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%97%8B%E8%BD%AC.lua"))()
end)

sectionFling:Toggle("甩飞所有人", false, function(state)
loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
end)

    local tabFun = Window:Tab("娱乐(FE)", "117911709021357")
    local sectionFun = tabFun:Section("FE以及娱乐功能", {Y = "113580079129703", F = "113580079129703"}, true)
    
sectionFun:Button("C00lgui", function() loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()
end)        

sectionFun:Button("M 47", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/sinret/rbxscript.com-scripts-reuploads-/main/ak47", true))()
end)        

sectionFun:Button("电脑键盘", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
end)

sectionFun:Button("飞檐走壁", function() loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)

    local sectionFun2 = tabFun:Section("动作类", {Y = "101403657260817", F = "101403657260817"}, true)
    
    sectionFun2:Button("动作", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-7yd7-I-Emote-Script-48024"))() 
end)
    
    sectionFun2:Button("SCP-096", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-SCP-096-36948"))() 
end)

sectionFun2:Button("变车", function() loadstring(game:HttpGet("https://pastefy.app/UqDEIOpO/raw"))() 
end)    
        
    sectionFun2:Button("撸管R15", function() loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))() 
end)
    
    sectionFun2:Button("撸管R6", function() loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)
    
    sectionFun2:Button("打人", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-THE-REAL-dropkick-177199"))() 
end)

    local tabMusic = Window:Tab("音乐", "98485449573808")

    local currentSound = nil
    local function stopSound()
        if currentSound then
            currentSound:Stop()
            currentSound:Destroy()
            currentSound = nil
        end
    end

    local function playSoundById(id, notifyName)
        stopSound()
        if not id or id == "" then
            Window:Notification("音乐", "无效的音乐ID", "Error", 2)
            return
        end
        currentSound = Instance.new("Sound")
        currentSound.SoundId = id
        currentSound.Volume = 1
        currentSound.Parent = LocalPlayer.PlayerGui
        currentSound:Play()

        local soundRef = currentSound
        soundRef.Ended:Connect(function()
            if currentSound == soundRef then
                currentSound = nil
            end
            soundRef:Destroy()
        end)

        if notifyName then
            Window:Notification("音乐", "正在播放：" .. notifyName, "Success", 3)
        end
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
        for _, m in ipairs(musicLibrary) do
            if m.name == selectedHall then
                playSoundById(m.id, m.name)
                break
            end
        end
    end)
    sectionHall:Button("⏸ 暂停", function()
        if currentSound and currentSound.IsPlaying then
            currentSound:Pause()
            Window:Notification("音乐", "已暂停", "Info", 2)
        else
            Window:Notification("音乐", "没有正在播放的音乐", "Error", 2)
        end
    end)
    sectionHall:Button("▶ 继续", function()
        if currentSound and not currentSound.IsPlaying then
            currentSound:Resume()
            Window:Notification("音乐", "已继续", "Success", 2)
        elseif currentSound then
            Window:Notification("音乐", "音乐正在播放中", "Info", 2)
        else
            Window:Notification("音乐", "没有暂停的音乐", "Error", 2)
        end
    end)

    local customMusicId = ""
    local sectionCustomMusic = tabMusic:Section("音乐ID", {Y = "92109853056999", F = "92109853056999"}, true)
    sectionCustomMusic:Textbox("输入音乐ID（纯数字）", "例如：12345678", function(val) customMusicId = val end)
    sectionCustomMusic:Button("播放自定义音乐", function()
        local fullId = "rbxassetid://" .. customMusicId
        playSoundById(fullId, "自定义音乐")
    end)
    sectionCustomMusic:Button("暂停音乐", function()
        if currentSound and currentSound.IsPlaying then
            currentSound:Pause()
            Window:Notification("音乐", "已暂停", "Info", 2)
        else
            Window:Notification("音乐", "没有正在播放的音乐", "Error", 2)
        end
    end)
    sectionCustomMusic:Button("继续播放", function()
        if currentSound and not currentSound.IsPlaying then
            currentSound:Resume()
            Window:Notification("音乐", "已继续", "Success", 2)
        elseif currentSound then
            Window:Notification("音乐", "音乐正在播放中", "Info", 2)
        else
            Window:Notification("音乐", "没有暂停的音乐", "Error", 2)
        end
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
        for _, s in ipairs(battleSounds) do
            if s.name == selectedBattle then
                playSoundById(s.id, s.name)
                break
            end
        end
    end)
    sectionBattle:Button("⏸ 暂停", function()
        if currentSound and currentSound.IsPlaying then
            currentSound:Pause()
            Window:Notification("音效", "已暂停", "Info", 2)
        else
            Window:Notification("音效", "没有正在播放的音效", "Error", 2)
        end
    end)
    sectionBattle:Button("▶ 继续", function()
        if currentSound and not currentSound.IsPlaying then
            currentSound:Resume()
            Window:Notification("音效", "已继续", "Success", 2)
        elseif currentSound then
            Window:Notification("音效", "音效正在播放中", "Info", 2)
        else
            Window:Notification("音效", "没有暂停的音效", "Error", 2)
        end
    end)

    local tabConfig = Window:Tab("配置管理")
    local sectionConfig = tabConfig:Section("配置设置")
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
                if name ~= "" then
                    table.insert(newList, name)
                    newPaths[name] = file
                end
            end
        end)
        ConfigPaths = newPaths
        if dropdownObj then dropdownObj.Refresh(newList) end
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
        if Window.CurrentConfig == "" or Window.CurrentConfig == "None" then
            Window:Notification("加载错误", "请先选择一个配置", "Error", 2)
            return
        end
        local name = Window.CurrentConfig
        local path = ConfigPaths[name] or (Window.ConfigFolder .. "/" .. name .. ".json")
        Window:Notification("正在加载", "正在载入 " .. name, "Info", 2)
        local ok = library:LoadConfig(path)
        if ok then
            Window:Notification("加载成功", name .. " 已加载", "Success", 2)
        else
            Window:Notification("错误", "加载失败", "Error", 2)
        end
    end)

    sectionConfig:Button("删除配置", function()
        if Window.CurrentConfig == "" or Window.CurrentConfig == "None" then
            Window:Notification("错误", "请先选择要删除的配置", "Error", 2)
            return
        end
        local name = Window.CurrentConfig
        pcall(function()
            for _, path in ipairs({ConfigPaths[name], Window.ConfigFolder .. "/" .. name .. ".json", Window.ConfigFolder .. "\\" .. name .. ".json"}) do
                if path and isfile(path) then delfile(path) break end
            end
        end)
        Window.CurrentConfig = "None"
        wait(0.05)
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