-- ==================== 全局服务（仅此一处定义） ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ==================== 卡密验证界面 ====================
local CORRECT_KEY = "付款牛逼"
local BATTLE_KEYS = {"付款逗比", "小款逗比", "小款傻逼", "付款傻逼"}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "卡密验证"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 230)
frame.Position = UDim2.new(0.5, -150, 0.5, -115)
frame.BackgroundColor3 = Color3.fromRGB(30, 0, 60)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local glow = Instance.new("Frame")
glow.Size = UDim2.new(1, 0, 1, 0)
glow.BackgroundColor3 = Color3.fromRGB(80, 0, 140)
glow.BackgroundTransparency = 0.6
glow.BorderSizePixel = 0
glow.Parent = frame
local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 12)
glowCorner.Parent = glow

task.spawn(function()
    while glow and glow.Parent do
        TweenService:Create(glow, TweenInfo.new(1.5), {BackgroundTransparency = 0.85}):Play()
        task.wait(1.5)
        TweenService:Create(glow, TweenInfo.new(1.5), {BackgroundTransparency = 0.4}):Play()
        task.wait(1.5)
    end
end)

local stroke = Instance.new("UIStroke")
stroke.Thickness = 3
stroke.LineJoinMode = Enum.LineJoinMode.Round
stroke.Parent = frame

local rainbowColors = {
    Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 165, 0),
    Color3.fromRGB(255, 255, 0), Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 255, 255), Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(128, 0, 128)
}
local ci = 1
task.spawn(function()
    while frame.Parent do
        stroke.Color = rainbowColors[ci]
        ci = ci % #rainbowColors + 1
        task.wait(0.3)
    end
end)

local title1 = Instance.new("TextLabel")
title1.Size = UDim2.new(1, 0, 0, 30)
title1.Position = UDim2.new(0, 0, 0, 15)
title1.BackgroundTransparency = 1
title1.Text = "款脚本已被🔒住，输入卡密才可使用🤓"
title1.TextColor3 = Color3.fromRGB(255, 255, 255)
title1.Font = Enum.Font.SourceSansBold
title1.TextSize = 16
title1.Parent = frame

local title2 = Instance.new("TextLabel")
title2.Size = UDim2.new(1, 0, 0, 30)
title2.Position = UDim2.new(0, 0, 0, 45)
title2.BackgroundTransparency = 1
title2.Text = "请输入卡密🔑"
title2.TextColor3 = Color3.fromRGB(255, 255, 255)
title2.Font = Enum.Font.SourceSansBold
title2.TextSize = 20
title2.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -40, 0, 40)
textBox.Position = UDim2.new(0, 20, 0, 90)
textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
textBox.PlaceholderText = "输入卡密..."
textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
textBox.Font = Enum.Font.SourceSans
textBox.TextSize = 18
textBox.Parent = frame
local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 6)
boxCorner.Parent = textBox

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 0, 20)
statusText.Position = UDim2.new(0, 0, 0, 140)
statusText.BackgroundTransparency = 1
statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
statusText.Font = Enum.Font.SourceSans
statusText.TextSize = 14
statusText.Parent = frame

local confirmBtn = Instance.new("TextButton")
confirmBtn.Size = UDim2.new(1, -40, 0, 36)
confirmBtn.Position = UDim2.new(0, 20, 0, 170)
confirmBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
confirmBtn.TextColor3 = Color3.fromRGB(80, 0, 140)
confirmBtn.Text = "验 证"
confirmBtn.Font = Enum.Font.SourceSansBold
confirmBtn.TextSize = 18
confirmBtn.Parent = frame
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = confirmBtn

-- ==================== 黑客启动特效 ====================
local function showStartupEffect()
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
    topText.Text = "付款验证中..."
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
        loadMainScript()
    end)
end

-- ==================== 愤怒模式特效 ====================
local function isBattleKey(key)
    for _, bk in ipairs(BATTLE_KEYS) do
        if key == bk then return true end
    end
    return false
end

local function showBattleEffect()
    local effectGui = Instance.new("ScreenGui")
    effectGui.Name = "战斗特效"
    effectGui.ResetOnSpawn = false
    effectGui.Parent = LocalPlayer.PlayerGui

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    bg.BackgroundTransparency = 0.2
    bg.BorderSizePixel = 0
    bg.Parent = effectGui

    local topText = Instance.new("TextLabel")
    topText.Size = UDim2.new(1, 0, 0, 60)
    topText.Position = UDim2.new(0, 0, 0.05, 0)
    topText.BackgroundTransparency = 1
    topText.Text = "开启战斗模式😡"
    topText.TextColor3 = Color3.fromRGB(255, 0, 0)
    topText.Font = Enum.Font.SourceSansBold
    topText.TextSize = 36
    topText.Parent = effectGui

    task.spawn(function()
        while topText.Parent do
            TweenService:Create(topText, TweenInfo.new(0.3), {TextTransparency = 0.6}):Play()
            task.wait(0.3)
            TweenService:Create(topText, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
            task.wait(0.3)
        end
    end)

    local rainData = {}
    for i = 1, 60 do
        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Text = "😡"
        label.TextColor3 = Color3.fromRGB(255, 30, 30)
        label.Font = Enum.Font.SourceSansBold
        label.TextSize = 20
        label.TextTransparency = 0.1
        label.Parent = effectGui
        label.Position = UDim2.new(math.random(), 0, 1 + math.random() * 0.5, 0)
        table.insert(rainData, {label = label, speed = 0.4 + math.random() * 2})
    end

    local connection = RunService.Heartbeat:Connect(function(dt)
        for _, data in ipairs(rainData) do
            local lbl = data.label
            if lbl and lbl.Parent then
                local newY = lbl.Position.Y.Scale - data.speed * dt
                if newY < -0.3 then
                    lbl.Position = UDim2.new(math.random(), 0, 1 + math.random() * 0.3, 0)
                else
                    lbl.Position = UDim2.new(lbl.Position.X.Scale, 0, newY, 0)
                end
            end
        end
    end)

    task.delay(4, function()
        connection:Disconnect()
        effectGui:Destroy()
        LocalPlayer:Kick("错误代码：款以愤怒")
    end)
end

-- ==================== 验证逻辑 ====================
local function tryVerify()
    local inputKey = textBox.Text
    if inputKey == "" then
        statusText.Text = "⚠️ 请输入卡密"
    elseif isBattleKey(inputKey) then
        screenGui:Destroy()
        showBattleEffect()
    elseif inputKey == CORRECT_KEY then
        screenGui:Destroy()
        showStartupEffect()
    else
        statusText.Text = "❌ 卡密无效，请重试"
        textBox.Text = ""
    end
end

confirmBtn.MouseButton1Click:Connect(tryVerify)
textBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then tryVerify() end
end)

-- ==================== 加载主功能（你的原版代码，未作任何功能改动） ====================
function loadMainScript()
    -- 以下是你原来完整的功能代码，唯一的安全改动是移除了重复的服务定义，并把汉化按钮放到了正确的位置

    -- 名单定义（保留）
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

    -- 根据身份确定标题、颜色，以及权限系统显示用的角色名
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

    -- 加载 UI 库 + 创建窗口
    local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/probable-happiness/refs/heads/main/VIP_Fenglib(2).lua"))()
    local Window = library:CreateWindow({
        Title = windowTitle,
        Subtitle = "付款制作必是精品",
        Keybind = Enum.KeyCode.RightShift,
        Icon = 80732857736726,
        Theme = "Dark",
        Background = "https://chaton-images.s3.us-east-2.amazonaws.com/Qx7Aun30ZRPmlXtXDE3adbBleR5buvwp8AbOFCoIU5TugqRw62Dn00B4rBtx00Vx_1578x932x261816.jpeg"
    })

    -- 修改标题颜色
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

    function IsAdminOrAuthor()
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
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = title
        label.TextColor3 = Color3.fromRGB(0, 255, 255)
        label.TextStrokeTransparency = 0
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.Font = Enum.Font.SourceSansBold
        label.TextScaled = true
        label.Parent = billboard
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

    -- 动态权限系统
    if IsAdminOrAuthor() and userRoleName then
        local tabAdminOnly = Window:Tab(userRoleName .. "权限")
        local sectionAdminOnly = tabAdminOnly:Section(userRoleName .. "专属功能", {Y = "0", F = "0"}, true)

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
        sectionAdminOnly:Toggle(userRoleName .. "穿墙", false, function(state) adminNoclipEnabled = state; updateAdminHeartbeat(); Window:Notification(userRoleName .. "权限", "穿墙 " .. (state and "开启" or "关闭"), "Success", 2) end)
        sectionAdminOnly:Button(userRoleName .. "飞行", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/improved-sy/refs/heads/main/%E6%AE%BA%E9%A3%9E%E8%A1%8C.lua"))(); Window:Notification(userRoleName .. "权限", "飞行已加载", "Success", 2) 
end)
        
        sectionAdminOnly:Slider(userRoleName .. "速度", 0, 500, 16, function(val) adminSpeedValue = val; if adminSpeedEnabled and LocalPlayer.Character then local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if hum then hum.WalkSpeed = val end end end)
        sectionAdminOnly:Toggle("启用" .. userRoleName .. "速度", false, function(state) adminSpeedEnabled = state; updateAdminHeartbeat(); Window:Notification(userRoleName .. "权限", "速度 " .. (state and "开启" or "关闭"), "Success", 2) 
end)
        sectionAdminOnly:Slider(userRoleName .. "跳跃高度", 0, 500, 50, function(val) adminJumpValue = val; if adminJumpEnabled and LocalPlayer.Character then local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if hum then hum.JumpPower = val end end 
end)
        sectionAdminOnly:Toggle("启用" .. userRoleName .. "跳跃", false, function(state) adminJumpEnabled = state; updateAdminHeartbeat(); Window:Notification(userRoleName .. "权限", "跳跃 " .. (state and "开启" or "关闭"), "Success", 2) 
end)
    end

    -- 资料库
    local tabProfile = Window:Tab("资料库", "85887401411044")
    local sectionProfile = tabProfile:Section("款脚本身份", {Y = "94054854845750", F = "94054854845750"}, true)
    
    sectionProfile:Image({Title = "付款", Subtitle = "款脚本作者", Description = {"身份：小款没吃饱", "Q群：1087878073", "我真求你了"}, Icon = "rbxassetid://94475465919781", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了付款的资料", "Info", 2)
end})
    
    sectionProfile:Image({Title = "中皮", Subtitle = "款脚本副作者", Description = {"身份：脚本哥", "无", "无"}, Icon = "rbxassetid://83204773411249", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了中皮的资料", "Info", 2)
end})
    
    sectionProfile:Image({Title = "风御", Subtitle = "殺脚本作者", Description = {"身份：疯子（刺猬）", "殺脚本主群819104139", "殺脚本副群1094790583"}, Icon = "rbxassetid://125810852185092", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了殺脚本作者的资料", "Info", 2)
end})
    
    sectionProfile:Image({Title = "小番", Subtitle = "管理员", Description = {"身份：番茄🍅", "小番牛逼", "xfnb666"}, Icon = "rbxassetid://138242046027117", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了小番的资料", "Info", 2)
end})
    
    sectionProfile:Image({Title = "奕夕", Subtitle = "测试人员", Description = {"身份：虚荣屠夫", "他们说我的饥饿是个问题", "事情变得开始有趣起来了"}, Icon = "rbxassetid://133051318196418", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了奕夕的资料", "Info", 2)
end})
    
    sectionProfile:Image({Title = "我是Noob", Subtitle = "管理员", Description = {"身份：Noob", "我爱脚本", "玩脚本这一块"}, Icon = "rbxassetid://118200262618824", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了我是Noob的资料", "Info", 2) 
end})
    
    sectionProfile:Image({Title = "直奔主题", Subtitle = "测试人员", Description = {"身份：脚本大蛇", "会宣传脚本", "神秘脚本大帝"}, Icon = "rbxassetid://91925613661490", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了直奔主题的资料", "Info", 2)
end})
    
    sectionProfile:Image({Title = "cube", Subtitle = "管理员", Description = {"身份：披萨员", "pizza！", "立方体"}, Icon = "rbxassetid://104898690520306", IconColor = Color3.fromRGB(255, 255, 255), StrokeColor = Color3.fromRGB(255, 215, 0), Callback = function() Window:Notification("提示", "你点击了Pizza的资料", "Info", 2)
end})

    -- 通用功能
    local tabCommon = Window:Tab("通用", "85043685370431")
    local sectionCommon = tabCommon:Section("通用功能", {Y = "127278444393372", F = "127278444393372"}, true)

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
            wait()
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = speedValue end
        end
        if jumpEnabled then
            wait()
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = jumpValue end
        end
    end)

    sectionCommon:Toggle("自瞄（瞄准头部）", false, function(state) aimEnabled = state; updateFeatureHeartbeat(); Window:Notification("自瞄", state and "已开启" or "已关闭", state and "Success" or "Info", 2) end)
    sectionCommon:Toggle("改速度", false, function(state) speedEnabled = state; updateFeatureHeartbeat(); Window:Notification("改速度", state and "已开启" or "已关闭", state and "Success" or "Info", 2) end)
    sectionCommon:Slider("速度数值", 0, 500, 16, function(val) speedValue = val; if speedEnabled and LocalPlayer.Character then local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if hum then hum.WalkSpeed = val end end end)
    sectionCommon:Toggle("改跳跃", false, function(state) jumpEnabled = state; updateFeatureHeartbeat(); Window:Notification("改跳跃", state and "已开启" or "已关闭", state and "Success" or "Info", 2) end)
    sectionCommon:Slider("跳跃高度", 0, 500, 50, function(val) jumpValue = val; if jumpEnabled and LocalPlayer.Character then local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if hum then hum.JumpPower = val end end end)
    sectionCommon:Button("款飞行", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/fhjhcfhhj/improved-sy/refs/heads/main/%E6%AE%BA%E9%A3%9E%E8%A1%8C.lua"))() end)

    -- ESP 透视
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
    sectionCommon:Toggle("透视（绿色轮廓+信息）", false, function(state)
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

    -- 穿墙
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
    sectionCommon:Toggle("穿墙模式（永久）", false, function(state)
        noclipEnabled = state
        if state then if LocalPlayer.Character then setCharacterCollision(LocalPlayer.Character, true) end; startNoclipLoop(); Window:Notification("穿墙", "已开启", "Success", 2)
        else if LocalPlayer.Character then setCharacterCollision(LocalPlayer.Character, false) end; stopNoclipLoop(); Window:Notification("穿墙", "已关闭", "Info", 2) end
    end)

    -- 隐身
    local invisibleEnabled = false
    local function setCharacterInvisible(character, invisible)
        if not character then return end
        for _, part in ipairs(character:GetDescendants()) do if part:IsA("BasePart") then part.LocalTransparencyModifier = invisible and 1 or 0 end end
    end
    if LocalPlayer then
        LocalPlayer.CharacterAdded:Connect(function(character) if invisibleEnabled then wait(); setCharacterInvisible(character, true) end end)
        if LocalPlayer.Character then setCharacterInvisible(LocalPlayer.Character, false) end
    end
    sectionCommon:Toggle("隐身", false, function(state)
        invisibleEnabled = state
        if state then if LocalPlayer.Character then setCharacterInvisible(LocalPlayer.Character, true) end; Window:Notification("隐身", "已开启", "Success", 2)
        else if LocalPlayer.Character then setCharacterInvisible(LocalPlayer.Character, false) end; Window:Notification("隐身", "已关闭", "Info", 2) end
    end)

    -- 无限跳
    local infiniteJumpEnabled = false
    UserInputService.JumpRequest:Connect(function()
        if infiniteJumpEnabled and LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end)
    sectionCommon:Toggle("无限跳", false, function(state) infiniteJumpEnabled = state; Window:Notification("无限跳", state and "已开启" or "已关闭", state and "Success" or "Info", 2) end)

    -- 其余功能
    sectionCommon:Button("死亡笔记", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()
end)
    
    sectionCommon:Button("踏空行走", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))() 
end)
   
     sectionCommon:Button("视角可提超广角", function() Workspace.CurrentCamera.FieldOfView = 100 
end)
   
   sectionCommon:Button("铁拳", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))() 
end)
    
    sectionCommon:Button("iw指今控制台", function() loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))() 
 end)
   
     sectionCommon:Button("旋转", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%97%8B%E8%BD%AC.lua"))() end)
   
     sectionCommon:Toggle("反挂机", false, function(state) loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))()
 end)
    
    sectionCommon:Button("工具挂", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Bebo-Mods/BeboScripts/main/StandAwekening.lua"))() 
 end)

    -- 娱乐
    local tabFun = Window:Tab("娱乐（FE）", "117911709021357")
    local sectionFun = tabFun:Section("娱乐功能", {Y = "113580079129703", F = "113580079129703"}, true)
    
    sectionFun:Button("打人", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-THE-REAL-dropkick-177199"))() 
 end)
    
    sectionFun:Button("M 47", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/sinret/rbxscript.com-scripts-reuploads-/main/ak47", true))() end)
    
    sectionFun:Button("动作", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-7yd7-I-Emote-Script-48024"))()
  end)
   
     sectionFun:Button("电脑键盘", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))() 
  end)
    
    sectionFun:Button("SCP-096", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-SCP-096-36948"))()
  end)
    
    sectionFun:Button("变车", function() loadstring(game:HttpGet("https://pastefy.app/UqDEIOpO/raw"))()
  end)
    
    sectionFun:Button("撸管R15", function() loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
  end)
    
    sectionFun:Button("撸管R6", function() loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))() 
  end)
   
     sectionFun:Button("飞檐走壁", function() loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))() 
  end)
   
     sectionFun:Button("汉化", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Wlzhmaa/UWU/refs/heads/main/Chinese%20translation"))() end)

    -- 配置管理
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

    -- UI设置
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