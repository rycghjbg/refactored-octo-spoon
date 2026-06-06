local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local STARTUP_MUSIC_IDS = {
    "rbxassetid://73722198102705",
    "rbxassetid://91122395878594",
    "rbxassetid://18980082432",
}

local function continueStartup()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")

    local sound
    if #STARTUP_MUSIC_IDS > 0 then
        local randomId = STARTUP_MUSIC_IDS[math.random(1, #STARTUP_MUSIC_IDS)]
        if randomId ~= "rbxassetid://0" then
            sound = Instance.new("Sound")
            sound.SoundId = randomId
            sound.Volume = 1
            sound.Parent = playerGui
            pcall(function() sound:Play() end)
        end
    end

    local preloadedLibrary = nil
    local libraryLoaded = false
    task.spawn(function()
        local success, result = pcall(function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/probable-happiness/refs/heads/main/VIP_Fenglib(2).lua"))()
        end)
        if success then preloadedLibrary = result end
        libraryLoaded = true
    end)

    local animGui = Instance.new("ScreenGui")
    animGui.Name = "TitleAnimation"
    animGui.ResetOnSpawn = false
    animGui.Parent = playerGui

    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 0, 0, 100)
    card.AnchorPoint = Vector2.new(0.5, 0.5)
    card.Position = UDim2.new(0.5, 0, 0.45, 0)   
    card.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    card.BorderSizePixel = 0
    card.BackgroundTransparency = 0.1
    card.ClipsDescendants = true               
    card.Parent = animGui

    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 12)
    cardCorner.Parent = card

    local cardStroke = Instance.new("UIStroke")
    cardStroke.Thickness = 1.5
    cardStroke.Color = Color3.fromRGB(0, 180, 220)
    cardStroke.Transparency = 0.5
    cardStroke.Parent = card

    task.spawn(function()
        local hue = 0
        while cardStroke and cardStroke.Parent do
            hue = (hue + 1) % 360
            cardStroke.Color = Color3.fromHSV(hue/360, 0.8, 0.9)
            task.wait(0.05)
        end
    end)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = ""
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 32
    titleLabel.TextTransparency = 1
    titleLabel.TextStrokeTransparency = 0.3
    titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 180, 220)
    titleLabel.ClipsDescendants = true
    titleLabel.Parent = card

    local lightning = Instance.new("Frame")
    lightning.Size = UDim2.new(0, 80, 1, 0)
    lightning.Position = UDim2.new(0, -100, 0, 0)
    lightning.BackgroundColor3 = Color3.fromRGB(0, 220, 255)
    lightning.BorderSizePixel = 0
    lightning.ZIndex = 5
    lightning.Parent = titleLabel

    local lightningGradient = Instance.new("UIGradient")
    lightningGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(0, 240, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 240, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
    })
    lightningGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.6),
        NumberSequenceKeypoint.new(0.15, 0),
        NumberSequenceKeypoint.new(0.4, 0.2),
        NumberSequenceKeypoint.new(0.7, 0),
        NumberSequenceKeypoint.new(1, 0.6),
    })
    lightningGradient.Parent = lightning

    task.spawn(function()
        while lightning and lightning.Parent do
            lightning.Position = UDim2.new(0, -100, 0, 0)
            for pos = -100, 350, 15 do
                if not lightning or not lightning.Parent then break end
                lightning.Position = UDim2.new(0, pos, 0, 0)
                task.wait(0.01)
            end
            task.wait(math.random(15, 50) / 100)
        end
    end)

    pcall(function()
        local tweenCard = TweenService:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 300, 0, 100),
            Position = UDim2.new(0.5, 0, 0.45, 0)   
        })
        tweenCard:Play()
    end)

    task.wait(0.1)

    local fullText = "款脚本"
    local result = ""
    for _, code in utf8.codes(fullText) do
        result = result .. utf8.char(code)
        titleLabel.Text = result
        titleLabel.TextTransparency = 0
        task.wait(0.05)
    end

    pcall(function()
        local tweenToCyan = TweenService:Create(titleLabel, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            TextColor3 = Color3.fromRGB(0, 200, 220)
        })
        tweenToCyan:Play()
    end)

    if sound then
        pcall(function() sound.Ended:Wait() end)
    end

    animGui:Destroy()

    local waited = 0
    while not libraryLoaded and waited < 3 do
        task.wait(0.1)
        waited = waited + 0.1
    end

    if sound then
        pcall(function() sound:Stop() end)
        pcall(function() sound:Destroy() end)
    end

    loadMainScript(preloadedLibrary)
end

function loadMainScript(preloadedLib)
    local adminList = {
        "zxc110819", 
        "NOOOPLSDONTletme444", 
        "aa1360051",
        "FengY3", 
        "FengYu303",
        "KuaishouKuan2", 
        "ma107133", 
        "DPYfish"
    }
    local authorList = {
        "fgvccvvbb3", 
        "dhjhcxgjk", 
        "yxhchchcucyv", 
        "用户名5"
    }
    local blacklist = {}

    local function isInList(list, name)
        if not list or #list == 0 then return false end
        for i = 1, #list do
            if list[i] == name then return true end
        end
        return false
    end

    if isInList(blacklist, LocalPlayer.Name) then
        LocalPlayer:Kick("错误代码 246：您已被禁止使用此脚本")
        return
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

    local library
    if preloadedLib then
        library = preloadedLib
    else
        local success, err = pcall(function()
            library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/probable-happiness/refs/heads/main/VIP_Fenglib(2).lua"))()
        end)
        if not success or not library then
            warn("库加载失败: " .. tostring(err))
            local errorGui = Instance.new("ScreenGui")
            errorGui.Name = "ErrorGui"
            errorGui.ResetOnSpawn = false
            errorGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
            local errorFrame = Instance.new("Frame")
            errorFrame.Size = UDim2.new(0, 300, 0, 120)
            errorFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
            errorFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            errorFrame.Parent = errorGui
            Instance.new("UICorner", errorFrame).CornerRadius = UDim.new(0, 8)
            local errorText = Instance.new("TextLabel")
            errorText.Size = UDim2.new(1, -20, 1, -20)
            errorText.Position = UDim2.new(0, 10, 0, 10)
            errorText.BackgroundTransparency = 1
            errorText.Text = "脚本加载失败\n请检查网络连接后重试"
            errorText.TextColor3 = Color3.fromRGB(255, 255, 255)
            errorText.Font = Enum.Font.SourceSansBold
            errorText.TextSize = 14
            errorText.TextWrapped = true
            errorText.Parent = errorFrame
            return
        end
    end

    local Window = library:CreateWindow({
        Title = windowTitle,
        Subtitle = "付款制作必是精品",
        Keybind = Enum.KeyCode.RightShift,
        Icon = 80732857736726,
        Theme = "Dark",
        Background = "https://raw.githubusercontent.com/rycghjbg/refactored-octo-spoon/refs/heads/main/Image_1780492829762_461.jpg"
})

    task.wait(0.3)
    pcall(function()
        local playerGui = LocalPlayer:WaitForChild("PlayerGui")
        local sg = playerGui:FindFirstChild(windowTitle)
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
    end)

    local function IsAdminOrAuthor()
        return isInList(adminList, LocalPlayer.Name) or isInList(authorList, LocalPlayer.Name)
    end

    local function getPlayerTitle(player)
        if isInList(adminList, player.Name) then return "测试人员"
        elseif isInList(authorList, player.Name) then return "款脚本作者" end
        return nil
    end

    local playerTitleBillboards = {}
    local function createTitleBillboard(player, character)
        local head = character:FindFirstChild("Head")
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
        Instance.new("UICorner", outerFrame).CornerRadius = UDim.new(0, 4)
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
                player.CharacterAdded:Connect(function(char) handlePlayerCharacter(player, char) end)
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

    if IsAdminOrAuthor() and userRoleName then
        local tabAdminOnly = Window:Tab(userRoleName .. "权限")
        local sectionAdminOnly = tabAdminOnly:Section(userRoleName .. "专属功能", {Y = "99282742934566", F = "99282742934566"}, true)
        local brightnessEnabled = false
        local brightnessValue = 1
        local brightnessConnection = nil
        local function updateBrightness()
            if brightnessEnabled then
                if not brightnessConnection then
                    brightnessConnection = RunService.Heartbeat:Connect(function()
                        if brightnessEnabled then
                            Lighting.Brightness = brightnessValue
                            Lighting.ClockTime = 12
                            Lighting.FogEnd = 100000
                            Lighting.GlobalShadows = false
                        end
                    end)
                end
                Lighting.Brightness = brightnessValue
                Lighting.ClockTime = 12
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
            else
                if brightnessConnection then
                    brightnessConnection:Disconnect()
                    brightnessConnection = nil
                end
                Lighting.Brightness = 1
                Lighting.ClockTime = 14
                Lighting.FogEnd = 10000
                Lighting.GlobalShadows = true
            end
        end
        sectionAdminOnly:Slider(userRoleName .. "亮度值", 0.1, 10, 1, function(val)
            brightnessValue = val
            if brightnessEnabled then Lighting.Brightness = val end
        end)
        sectionAdminOnly:Toggle("启用" .. userRoleName .. "亮度", false, function(state)
            brightnessEnabled = state
            updateBrightness()
            Window:Notification(userRoleName .. "权限", "亮度调节 " .. (state and "已开启" or "已关闭"), "Success", 2)
        end)
    end

    local espHighlightEnabled = false
    local showNames = true
    local showHealth = true
    local infiniteJumpEnabled = false
    local espCache = {}
    local playerAddedConn, playerRemovingConn

    local function getPlayerDisplayName(player)
        local title = getPlayerTitle(player)
        if title then return title end
        if player.DisplayName and player.DisplayName ~= "" then return player.DisplayName end
        return player.Name
    end

    local function createESPForPlayer(player)
        if espCache[player] then return end
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
            local data = {connections = {}}
            if espHighlightEnabled then
                local highlight = Instance.new("Highlight")
                highlight.Name = "ESP_Highlight"
                highlight.Adornee = character
                highlight.FillTransparency = 1
                highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
                highlight.OutlineTransparency = 0
                highlight.Parent = character
                data.highlight = highlight
            end
            if showNames or showHealth then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "ESP_Billboard"
                billboard.Adornee = head
                billboard.Size = UDim2.new(0, 120, 0, 30)
                billboard.StudsOffset = Vector3.new(0, 1.5, 0)
                billboard.AlwaysOnTop = true
                billboard.Parent = head
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1,0,1,0)
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.fromRGB(255,255,255)
                label.TextStrokeTransparency = 0
                label.Font = Enum.Font.SourceSansBold
                label.TextSize = 10
                label.TextScaled = false
                label.Parent = billboard
                local function update()
                    if humanoid and humanoid.Parent and head and head.Parent then
                        local textParts = {}
                        if showNames then table.insert(textParts, getPlayerDisplayName(player)) end
                        if showHealth then table.insert(textParts, string.format("%d/%d", math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))) end
                        label.Text = table.concat(textParts, "\n")
                        label.Visible = (#textParts > 0)
                    end
                end
                update()
                table.insert(data.connections, humanoid.HealthChanged:Connect(update))
                data.billboard = billboard
            end
            espCache[player] = data
        end
        if player.Character then onCharacterAdded(player.Character) end
        local charConn = player.CharacterAdded:Connect(onCharacterAdded)
        if espCache[player] then espCache[player].charConnection = charConn else espCache[player] = {charConnection = charConn} end
    end

    local function removeESP(player)
        local data = espCache[player]
        if not data then return end
        if data.charConnection then pcall(function() data.charConnection:Disconnect() end) end
        if data.connections then for _, conn in ipairs(data.connections) do if conn then pcall(function() conn:Disconnect() end) end end end
        if data.highlight then pcall(function() data.highlight:Destroy() end) end
        if data.billboard then pcall(function() data.billboard:Destroy() end) end
        espCache[player] = nil
    end

    local function rebuildAllESP()
        for player, _ in pairs(espCache) do removeESP(player) end
        espCache = {}
        if espHighlightEnabled or showNames or showHealth then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then createESPForPlayer(player) end
            end
            if playerAddedConn then playerAddedConn:Disconnect() end
            if playerRemovingConn then playerRemovingConn:Disconnect() end
            playerAddedConn = Players.PlayerAdded:Connect(function(player)
                if player ~= LocalPlayer then createESPForPlayer(player) end
            end)
            playerRemovingConn = Players.PlayerRemoving:Connect(removeESP)
        else
            if playerAddedConn then playerAddedConn:Disconnect(); playerAddedConn = nil end
            if playerRemovingConn then playerRemovingConn:Disconnect(); playerRemovingConn = nil end
        end
    end

    local easterEggTriggered = false
    local easterEggClicked = {}
    local totalProfileCount = 9

    local function triggerEasterEgg()
        if easterEggTriggered then return end
        easterEggTriggered = true
        if LocalPlayer.Character then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 40; hum.JumpPower = 40 end
        end
        LocalPlayer.CharacterAdded:Connect(function(char)
            local hum = char:WaitForChild("Humanoid", 5)
            if hum then hum.WalkSpeed = 40; hum.JumpPower = 40 end
        end)
        espHighlightEnabled = true
        showNames = true
        showHealth = true
        rebuildAllESP()
        infiniteJumpEnabled = true
    end

    local tabProfile = Window:Tab("资料区", "85887401411044")
    local sectionProfile = tabProfile:Section("款脚本身份", {Y = "94054854845750", F = "94054854845750"}, true)

    local function onProfileClick(name)
        easterEggClicked[name] = true
        local count = 0
        for _ in pairs(easterEggClicked) do count = count + 1 end
        if count >= totalProfileCount then triggerEasterEgg() end
    end

    sectionProfile:Image({Title = "付款", Subtitle = "款脚本作者", Description = {"身份：小款没吃饱", "Q群：1087878073", "我真求你了"}, Icon = "rbxassetid://72464253114782", IconColor = Color3.fromRGB(255,255,255), StrokeColor = Color3.fromRGB(255,215,0), Callback = function() Window:Notification("提示", "你点击了付款的资料", "Info", 2) onProfileClick("付款")
end})
    
    sectionProfile:Image({Title = "中皮", Subtitle = "款脚本副作者", Description = {"身份：脚本哥", "无", "无"}, Icon = "rbxassetid://83204773411249", IconColor = Color3.fromRGB(255,255,255), StrokeColor = Color3.fromRGB(255,215,0), Callback = function() Window:Notification("提示", "你点击了中皮的资料", "Info", 2) onProfileClick("中皮")
end})
    
    sectionProfile:Image({Title = "风御", Subtitle = "殺脚本作者", Description = {"身份：疯子（刺猬）", "殺脚本主群819104139", "殺脚本副群1094790583"}, Icon = "rbxassetid://89381853103913", IconColor = Color3.fromRGB(255,255,255), StrokeColor = Color3.fromRGB(255,215,0), Callback = function() Window:Notification("提示", "你点击了殺脚本作者的资料", "Info", 2) onProfileClick("风御")
end})
    
    sectionProfile:Image({Title = "小番", Subtitle = "管理员", Description = {"身份：番茄🍅", "小番牛逼", "Xiaofannb666"}, Icon = "rbxassetid://138242046027117", IconColor = Color3.fromRGB(255,255,255), StrokeColor = Color3.fromRGB(255,215,0), Callback = function() Window:Notification("提示", "你点击了小番的资料", "Info", 2) onProfileClick("小番")
end})
    
    sectionProfile:Image({Title = "小汪", Subtitle = "管理员", Description = {"身份：小汪", "小汪牛逼", "Xiaowangnb666"}, Icon = "rbxassetid://111514022930794", IconColor = Color3.fromRGB(255,255,255), StrokeColor = Color3.fromRGB(255,215,0), Callback = function() Window:Notification("提示", "你点击了小汪的资料", "Info", 2) onProfileClick("小汪")
end})
    
    sectionProfile:Image({Title = "奕夕", Subtitle = "测试人员", Description = {"身份：虚荣屠夫", "他们说我的饥饿是个问题", "事情变得开始有趣起来了"}, Icon = "rbxassetid://133051318196418", IconColor = Color3.fromRGB(255,255,255), StrokeColor = Color3.fromRGB(255,215,0), Callback = function() Window:Notification("提示", "你点击了奕夕的资料", "Info", 2) onProfileClick("奕夕")
end})
    
    sectionProfile:Image({Title = "只爱", Subtitle = "测试人员", Description = {"身份：奶烙", "小只爱", "3f"}, Icon = "rbxassetid://106483682176624", IconColor = Color3.fromRGB(255,255,255), StrokeColor = Color3.fromRGB(255,215,0), Callback = function() Window:Notification("提示", "你点击了只爱的资料", "Info", 2) onProfileClick("只爱")
end})
    
    sectionProfile:Image({Title = "我是Noob", Subtitle = "管理员", Description = {"身份：Noob", "我爱脚本", "玩脚本这一块"}, Icon = "rbxassetid://118200262618824", IconColor = Color3.fromRGB(255,255,255), StrokeColor = Color3.fromRGB(255,215,0), Callback = function() Window:Notification("提示", "你点击了我是Noob的资料", "Info", 2) onProfileClick("我是Noob")
end})
    
    sectionProfile:Image({Title = "cube", Subtitle = "管理员", Description = {"身份：披萨员", "pizza！", "立方体"}, Icon = "rbxassetid://104898690520306", IconColor = Color3.fromRGB(255,255,255), StrokeColor = Color3.fromRGB(255,215,0), Callback = function() Window:Notification("提示", "你点击了Pizza的资料", "Info", 2) onProfileClick("cube")
end})

    local tabCommon = Window:Tab("通用", "85043685370431")
    local sectionCommon = tabCommon:Section("自身修改", {Y = "127278444393372", F = "127278444393372"}, true)
    
    local aimEnabled, speedEnabled, jumpEnabled = false, false, false
    local speedValue, jumpValue = 16, 50
    local featureHeartbeat
    local function updateFeatureHeartbeat()
        local need = aimEnabled or speedEnabled or jumpEnabled
        if need and not featureHeartbeat then
            featureHeartbeat = RunService.Heartbeat:Connect(function()
                local char = LocalPlayer.Character
                if not char then return end
                local hum = char:FindFirstChildOfClass("Humanoid")
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root or not hum then return end
                if aimEnabled then
                    local nearest, dist = nil, math.huge
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                            local d = (root.Position - p.Character.Head.Position).Magnitude
                            if d < dist then dist = d; nearest = p.Character.Head end
                        end
                    end
                    if nearest then root.CFrame = CFrame.lookAt(root.Position, Vector3.new(nearest.Position.X, root.Position.Y, nearest.Position.Z)) end
                end
                if speedEnabled then hum.WalkSpeed = speedValue else hum.WalkSpeed = 16 end
                if jumpEnabled then hum.JumpPower = jumpValue else hum.JumpPower = 50 end
            end)
        elseif not need and featureHeartbeat then
            featureHeartbeat:Disconnect(); featureHeartbeat = nil
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = 16; hum.JumpPower = 50 end
            end
        end
    end
    LocalPlayer.CharacterAdded:Connect(function(char)
        if speedEnabled then task.wait(); local hum = char:FindFirstChildOfClass("Humanoid"); if hum then hum.WalkSpeed = speedValue end end
        if jumpEnabled then task.wait(); local hum = char:FindFirstChildOfClass("Humanoid"); if hum then hum.JumpPower = jumpValue end end
    end)
    
    sectionCommon:Toggle("改速度", false, function(v) speedEnabled = v; updateFeatureHeartbeat()
end)
    
    sectionCommon:Slider("速度数值", 0, 500, 16, function(v) speedValue = v; if speedEnabled and LocalPlayer.Character then local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if hum then hum.WalkSpeed = v end end end)
    
    sectionCommon:Toggle("改跳跃", false, function(v) jumpEnabled = v; updateFeatureHeartbeat()
end)
    
    sectionCommon:Slider("跳跃高度", 0, 500, 50, function(v) jumpValue = v; if jumpEnabled and LocalPlayer.Character then local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if hum then hum.JumpPower = v end end end)

    local sectionCommon2 = tabCommon:Section("通用功能", {Y = "89197120299249", F = "89197120299249"}, true)
    
    sectionCommon2:Button("款飞行", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/improved-sy/refs/heads/main/%E6%AE%BA%E9%A3%9E%E8%A1%8C.lua"))()
end)

    local sectionESP = tabCommon:Section("透视", {Y = "124176090938155", F = "124176090938155"}, true)
    sectionESP:Toggle("绿色边框", false, function(v) espHighlightEnabled = v; rebuildAllESP() end)
    sectionESP:Toggle("用户名", true, function(v) showNames = v; rebuildAllESP() end)
    sectionESP:Toggle("血量", true, function(v) showHealth = v; rebuildAllESP() end)

    local noclipEnabled = false
    local noclipHeartbeat, originalCollidableParts
    local function enableNoclip(char) if not char then return end; local parts = {}; for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") and p.CanCollide then table.insert(parts, p); p.CanCollide = false end end; originalCollidableParts = parts end
    local function disableNoclip(char) if originalCollidableParts then for _, p in ipairs(originalCollidableParts) do if p and p.Parent then p.CanCollide = true end end; originalCollidableParts = nil end end
    sectionCommon2:Toggle("穿墙模式（永久）", false, function(v)
        noclipEnabled = v
        if v then
            if LocalPlayer.Character then enableNoclip(LocalPlayer.Character) end
            noclipHeartbeat = RunService.Heartbeat:Connect(function()
                if noclipEnabled and LocalPlayer.Character and originalCollidableParts then
                    for _, p in ipairs(originalCollidableParts) do if p and p.Parent then p.CanCollide = false end end
                end
            end)
        else
            if LocalPlayer.Character then disableNoclip(LocalPlayer.Character) end
            if noclipHeartbeat then noclipHeartbeat:Disconnect(); noclipHeartbeat = nil end
        end
    end)

    local invisibleEnabled = false
    local function setInvisible(char, inv) if char then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.LocalTransparencyModifier = inv and 1 or 0 end end end end
    sectionCommon2:Toggle("隐身", false, function(v) invisibleEnabled = v; if LocalPlayer.Character then setInvisible(LocalPlayer.Character, v) end end)
    LocalPlayer.CharacterAdded:Connect(function(char) if invisibleEnabled then task.wait(); setInvisible(char, true) end end)

    UserInputService.JumpRequest:Connect(function()
        if infiniteJumpEnabled and LocalPlayer.Character then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end)
    sectionCommon2:Toggle("无限跳", false, function(v) infiniteJumpEnabled = v end)

    sectionCommon2:Button("死亡笔记", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()
end)
    
    sectionCommon2:Button("自死", function() if LocalPlayer.Character then local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if hum then hum.Health = 0 end end 
end)
    
    sectionCommon2:Button("踏空行走", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
end)
    
    sectionCommon2:Button("视角可提超广角", function() workspace.CurrentCamera.FieldOfView = 100
end)
    
    sectionCommon2:Button("铁拳", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
end)
    
    sectionCommon2:Toggle("反挂机", false, function(v) if v then loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))() end
end)
    
    sectionCommon2:Button("汉化", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Wlzhmaa/UWU/refs/heads/main/Chinese%20translation"))()
end)
    
    sectionCommon2:Button("汉化Dex", function() loadstring(game:HttpGet("https://gitee.com/cmbhbh/cmbh/raw/master/Bex.lua"))()
end)

    local sectionAim = tabCommon:Section("自瞄区域", {Y = "134293959597321", F = "134293959597321"}, true)
    
    sectionAim:Button("阿尔宙斯同款自瞄", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/sgbs/main/%E4%B8%81%E4%B8%81%20%E6%B1%89%E5%8C%96%E8%87%AA%E7%9E%84.txt"))()
end)
    
    sectionAim:Toggle("自瞄（瞄准头部）", false, function(v) aimEnabled = v; updateFeatureHeartbeat()
end)

    local sectionFling = tabCommon:Section("甩飞区域", {Y = "113899846067098", F = "113899846067098"}, true)
    local antiKnockbackEnabled = false
    sectionFling:Toggle("防甩飞（无碰撞箱）", false, function(v)
        antiKnockbackEnabled = v
        if v then
            if LocalPlayer.Character then local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart"); if root then root.CanCollide = false end end
            LocalPlayer.CharacterAdded:Connect(function(char) if antiKnockbackEnabled then local root = char:WaitForChild("HumanoidRootPart"); root.CanCollide = false end end)
        else
            if LocalPlayer.Character then local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart"); if root then root.CanCollide = true end end
        end
    end)
    
    sectionFling:Button("甩飞(先开飞行再开)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%97%8B%E8%BD%AC.lua"))()
end)
    
    sectionFling:Toggle("甩飞所有人", false, function(v) if v then loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))() end 
end)

    local tabFun = Window:Tab("娱乐(FE)", "117911709021357")
    local sectionFun = tabFun:Section("FE以及娱乐功能", {Y = "113580079129703", F = "113580079129703"}, true)
    
    sectionFun:Button("C00lgui", function() loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)() 
end)
    
    sectionFun:Button("可口可乐", function()  loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Coca-Cola-Tool-34866"))()
end)
    
    sectionFun:Button("M 47", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/sinret/rbxscript.com-scripts-reuploads-/main/ak47", true))()
end)
    
    sectionFun:Button("电脑键盘", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
end)
    
    sectionFun:Button("飞檐走壁", function() loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)
    
    sectionFun:Button("光剑", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Crucible-Sword-only-R6-87032"))()
end)
    
    local sectionFun2 = tabFun:Section("动作类", {Y = "101403657260817", F = "101403657260817"}, true)
    
    sectionFun2:Button("动作", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-7yd7-I-Emote-Script-48024"))()
end)
   
   sectionFun2:Button("打架(R6)", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-no-more-games-tool-not-fe-80285"))()
end)
   
    sectionFun2:Button("SCP-096", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-SCP-096-36948"))()
end)
    
    sectionFun2:Button("前后空翻动作", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E5%89%8D%E5%90%8E%E7%A9%BA%E7%BF%BB.txt"))()
end)
    
    sectionFun2:Button("祖国人", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/giobolqvvi1/homelander-by-GioBolqv1/refs/heads/main/homelander.lua"))()
end)
    
    sectionFun2:Button("撸管R15", function() loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)
    
    sectionFun2:Button("撸管R6", function() loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)
    
    sectionFun2:Button("打人", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-THE-REAL-dropkick-177199"))()
end)

    local sectionTransform = tabFun:Section("变身区", {Y = "100730903157896", F = "100730903157896"}, true)
    sectionTransform:Button("Hacklord魔王", function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-1x1x1x1-lord-by-White-Hat-71150"))()
    end)
    
          sectionTransform:Button("史蒂夫（只支持R6形象）", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ian49972/SCRIPTS/refs/heads/main/Steve"))()
    end)

          sectionTransform:Button("人形汽车(变车)", function()
       loadstring(game:HttpGet("https://pastefy.app/UqDEIOpO/raw"))()
    end)

          sectionTransform:Button("John Doe[脚本生成器]（只支持R6形象）", function()
        loadstring(game:HttpGet("https://pastebin.com/raw/mMCS4Zne"))()
    end)

          sectionTransform:Button("John Doe脚本生成器有动作（只支持R6形象）", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-X/Function/refs/heads/main/john%20Doe.lua"))()
    end)



    local tabMusic = Window:Tab("音乐", "98485449573808")
    local currentSound
    local function stopSound() if currentSound then currentSound:Stop(); currentSound:Destroy(); currentSound = nil end end
    local function playSoundById(id, notifyName)
        stopSound()
        if not id or id == "" then return end
        currentSound = Instance.new("Sound")
        currentSound.SoundId = id
        currentSound.Volume = 1
        currentSound.Parent = LocalPlayer:WaitForChild("PlayerGui")
        currentSound:Play()
        local ref = currentSound
        ref.Ended:Connect(function() if currentSound == ref then currentSound = nil end ref:Destroy() end)
        if notifyName then Window:Notification("音乐", "正在播放：" .. notifyName, "Success", 3) end
    end
    local sectionHall = tabMusic:Section("音乐大厅", {Y = "102502304372289", F = "102502304372289"}, true)
    local musicLibrary = {
        {name = "雨爱", id = "rbxassetid://79277371759525"},
        {name = "起风了", id = "rbxassetid://99498025749186"},
        {name = "鸟之诗", id = "rbxassetid://113665010217108"},
        {name = "唯一", id = "rbxassetid://138570939058838"},
        {name = "azure与Two time", id = "rbxassetid://77715601943266"},
        {name = "最好的我", id = "rbxassetid://75047041148646"},
    }
    local selectedHall = musicLibrary[1].name
    local hallNames = {}
    for _, m in ipairs(musicLibrary) do table.insert(hallNames, m.name) end
    sectionHall:Dropdown("🎵 选择音乐", hallNames, function(choice) selectedHall = choice end)
    sectionHall:Button("▶ 播放", function() for _, m in ipairs(musicLibrary) do if m.name == selectedHall then playSoundById(m.id, m.name) break end end end)
    sectionHall:Button("⏸ 暂停", function() if currentSound and currentSound.IsPlaying then currentSound:Pause() end end)
    sectionHall:Button("▶ 继续", function() if currentSound and not currentSound.IsPlaying then currentSound:Resume() end end)
    local customMusicId = ""
    local sectionCustomMusic = tabMusic:Section("音乐ID", {Y = "92109853056999", F = "92109853056999"}, true)
    sectionCustomMusic:Textbox("输入音乐ID（纯数字）", "例如：12345678", function(v) customMusicId = v end)
    sectionCustomMusic:Button("播放自定义音乐", function() playSoundById("rbxassetid://" .. customMusicId, "自定义音乐") end)
    sectionCustomMusic:Button("暂停音乐", function() if currentSound and currentSound.IsPlaying then currentSound:Pause() end end)
    sectionCustomMusic:Button("继续播放", function() if currentSound and not currentSound.IsPlaying then currentSound:Resume() end end)
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
    sectionBattle:Button("▶ 播放", function() for _, s in ipairs(battleSounds) do if s.name == selectedBattle then playSoundById(s.id, s.name) break end end end)
    sectionBattle:Button("⏸ 暂停", function() if currentSound and currentSound.IsPlaying then currentSound:Pause() end end)
    sectionBattle:Button("▶ 继续", function() if currentSound and not currentSound.IsPlaying then currentSound:Resume() end end)

    local tabOtherScripts = Window:Tab("其他脚本", "115947871467249")
    local sectionOther = tabOtherScripts:Section("通用", {Y = "129170176484820", F = "129170176484820"}, true)
    
    sectionOther:Button("皮脚本", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
end)
    
    sectionOther:Button("叶脚本", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua"))()
end)
    
    sectionOther:Button("落叶中心", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/krlpl/Deciduous-center-LS/main/%E8%90%BD%E5%8F%B6%E4%B8%AD%E5%BF%83%E6%B7%B7%E6%B7%86.txt"))()
end)
    
    sectionOther:Button("(殺)通用", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-X/_Hub_/refs/heads/X/sha.lua"))()
end)
    local sectionSpecial = tabOtherScripts:Section("殺脚本", {Y = "84848865030433", F = "84848865030433"}, true)
    
    sectionSpecial:Button("(殺)被遗弃", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-X/Max/refs/heads/X/fsk.lua"))()
end)
    
    sectionSpecial:Button("(殺)成果记忆", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-X/Max/refs/heads/X/OM.lua"))() 
end)
    
    sectionSpecial:Button("(殺)撕咬之夜", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-X/Max/refs/heads/X/BBN.lua"))()
end)
    
    sectionSpecial:Button("(殺)死亡之死", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-X/Max/refs/heads/X/DOD.lua"))() 
end)

    local tabConfig = Window:Tab("配置管理")
    local sectionConfig = tabConfig:Section("配置设置")
    Window.CurrentConfig = "None"
    local ConfigName = ""
    sectionConfig:Textbox("配置名字", "输入配置名", function(v) ConfigName = v end)
    local dropdownObj, ConfigPaths = nil, {}
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
    dropdownObj = sectionConfig:Dropdown("选择配置", {"None"}, function(v) Window.CurrentConfig = v end)
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
        ["暗色"] = "Dark", ["白色"] = "White", ["紫色"] = "Purple",
        ["蓝色"] = "Blue", ["红色"] = "Red", ["黄色"] = "Yellow", ["绿色"] = "Green"
    }
    local themeDisplay = {}
    for display, _ in pairs(themeMap) do table.insert(themeDisplay, display) end
    sectionUI:Dropdown("主题颜色", themeDisplay, function(v) library:SetTheme(themeMap[v]) end)
    sectionUI:Keybind("菜单键绑定", Enum.KeyCode.RightShift, function(v) Window:SetKeybind(v) end)
    sectionUI:Button("摧毁界面", function() Window:Destroy() end)
end

continueStartup()