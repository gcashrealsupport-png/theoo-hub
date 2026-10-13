-- Recovered Luau source by ZeroVector
local tbl = {
    title = "Theoo Hub",
    sub = "key system",
    keys = {"theoo"},
    keysUrl = "",
    scriptUrl = "https://api.x8stuff.lol/scripts/bleh.txt",
    discord = "https://discord.gg/bmU6YtzzVm",
    keyLink = "https://discord.gg/bmU6YtzzVm",
    saveFile = "theoo_key.txt",
    remember = true,
}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local localPlayer = Players.LocalPlayer

local function fn()
    local ok, result = pcall(function()
        local v = gethui
        local hui = v and gethui()
        return hui
    end)

    if ok and result then
        return result
    end

    local ok2, result2 = pcall(function()
        return localPlayer:WaitForChild("PlayerGui")
    end)

    if ok2 and result2 then
        return result2
    end
    return game:GetService("CoreGui")
end

local function fn2(arg)
    local v = tostring
    local str = arg or ""
    return v(str):gsub("^%s+", ""):gsub("%s+$", "")
end

local v = nil

local function fn3()
    if tbl.keysUrl == "" then
        return nil
    end

    if v then
        return v
    end
    local response = nil

    pcall(function()
        response = game:HttpGet(tbl.keysUrl)
    end)

    if type(response) ~= "string" or response == "" then
        return nil
    end
    local tbl2 = {}

    for match in response:gmatch("[^\r\n]+") do
        local v2 = fn2(match)

        if v2 ~= "" and v2:sub(1, 1) ~= "#" then
            tbl2[v2:upper()] = true
        end
    end

    v = tbl2
    return tbl2
end

local function fn4(arg)
    local v2 = fn2(arg)
    if v2 == "" then
        return false
    end
    local str = v2:upper()

    for i, key in ipairs(tbl.keys) do
        if fn2(key):upper() == str then
            return true
        end
    end

    local v3 = fn3()
    if v3 and v3[str] then
        return true
    end
    return false
end

local function fn5(arg)
    if tbl.remember then
        pcall(function()
            writefile(tbl.saveFile, fn2(arg))
        end)
    end
end

pcall(function()
    local blehKey = fn():FindFirstChild("theoo_key")

    if blehKey then
        blehKey:Destroy()
    end
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "theoo_key"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999
screenGui.Parent = fn()
local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.55
frame.BorderSizePixel = 0
frame.Parent = screenGui
local frame2 = Instance.new("Frame")
frame2.AnchorPoint = Vector2.new(0.5, 0.5)
frame2.Position = UDim2.new(0.5, 0, 0.5, 0)
frame2.Size = UDim2.new(0, 330, 0, 296)
frame2.BackgroundColor3 = Color3.fromRGB(17, 17, 23)
frame2.BorderSizePixel = 0
frame2.ClipsDescendants = true
frame2.Parent = screenGui
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = frame2
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(255, 255, 255)
uiStroke.Transparency = 0.93
uiStroke.Thickness = 1
uiStroke.Parent = frame2
local frame3 = Instance.new("Frame")
frame3.Size = UDim2.new(1, 0, 0, 54)
frame3.BackgroundTransparency = 1
frame3.Parent = frame2
local textLabel = Instance.new("TextLabel")
textLabel.Position = UDim2.new(0, 18, 0, 12)
textLabel.Size = UDim2.new(1, -60, 0, 18)
textLabel.BackgroundTransparency = 1
textLabel.Font = Enum.Font.GothamBold
textLabel.TextSize = 14
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.Text = tbl.title
textLabel.Parent = frame3
local textLabel2 = Instance.new("TextLabel")
textLabel2.Position = UDim2.new(0, 18, 0, 30)
textLabel2.Size = UDim2.new(1, -60, 0, 14)
textLabel2.BackgroundTransparency = 1
textLabel2.Font = Enum.Font.Gotham
textLabel2.TextSize = 11
textLabel2.TextXAlignment = Enum.TextXAlignment.Left
textLabel2.TextColor3 = Color3.fromRGB(130, 130, 150)
textLabel2.Text = tbl.sub
textLabel2.Parent = frame3
local textButton = Instance.new("TextButton")
textButton.AnchorPoint = Vector2.new(1, 0)
textButton.Position = UDim2.new(1, -12, 0, 12)
textButton.Size = UDim2.new(0, 26, 0, 26)
textButton.BackgroundTransparency = 1
textButton.Font = Enum.Font.Gotham
textButton.TextSize = 14
textButton.TextColor3 = Color3.fromRGB(120, 120, 140)
textButton.Text = "x"
textButton.Parent = frame3

textButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local textLabel3 = Instance.new("TextLabel")
textLabel3.Position = UDim2.new(0, 18, 0, 60)
textLabel3.Size = UDim2.new(1, -36, 0, 12)
textLabel3.BackgroundTransparency = 1
textLabel3.Font = Enum.Font.GothamMedium
textLabel3.TextSize = 10
textLabel3.TextXAlignment = Enum.TextXAlignment.Left
textLabel3.TextColor3 = Color3.fromRGB(125, 125, 145)
textLabel3.Text = "LICENSE KEY"
textLabel3.Parent = frame2
local frame4 = Instance.new("Frame")
frame4.Position = UDim2.new(0, 18, 0, 76)
frame4.Size = UDim2.new(1, -36, 0, 42)
frame4.BackgroundColor3 = Color3.fromRGB(26, 26, 35)
frame4.BorderSizePixel = 0
frame4.Parent = frame2
local uiCorner2 = Instance.new("UICorner")
uiCorner2.CornerRadius = UDim.new(0, 8)
uiCorner2.Parent = frame4
local uiStroke2 = Instance.new("UIStroke")
uiStroke2.Color = Color3.fromRGB(50, 50, 65)
uiStroke2.Thickness = 1
uiStroke2.Parent = frame4
local textBox = Instance.new("TextBox")
textBox.BackgroundTransparency = 1
textBox.Position = UDim2.new(0, 12, 0, 0)
textBox.Size = UDim2.new(1, -24, 1, 0)
textBox.Font = Enum.Font.Code
textBox.TextSize = 13
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "Enter key..."
textBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 110)
textBox.Text = ""
textBox.ClearTextOnFocus = false
textBox.TextXAlignment = Enum.TextXAlignment.Left
textBox.Parent = frame4
local textLabel4 = Instance.new("TextLabel")
textLabel4.Position = UDim2.new(0, 18, 0, 122)
textLabel4.Size = UDim2.new(1, -36, 0, 14)
textLabel4.BackgroundTransparency = 1
textLabel4.Font = Enum.Font.Gotham
textLabel4.TextSize = 11
textLabel4.TextXAlignment = Enum.TextXAlignment.Left
textLabel4.TextColor3 = Color3.fromRGB(120, 120, 140)
textLabel4.Text = "Enter your key to continue"
textLabel4.Parent = frame2
local textButton2 = Instance.new("TextButton")
textButton2.Position = UDim2.new(0, 18, 0, 142)
textButton2.Size = UDim2.new(1, -36, 0, 44)
textButton2.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
textButton2.Font = Enum.Font.GothamMedium
textButton2.TextSize = 13
textButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton2.Text = "Verify"
textButton2.AutoButtonColor = false
textButton2.Parent = frame2
local uiCorner3 = Instance.new("UICorner")
uiCorner3.CornerRadius = UDim.new(0, 8)
uiCorner3.Parent = textButton2
local textButton3 = Instance.new("TextButton")
textButton3.Position = UDim2.new(0, 18, 0, 192)
textButton3.Size = UDim2.new(1, -36, 0, 40)
textButton3.BackgroundColor3 = Color3.fromRGB(26, 26, 35)
textButton3.Font = Enum.Font.Gotham
textButton3.TextSize = 12
textButton3.TextColor3 = Color3.fromRGB(170, 170, 190)
textButton3.Text = "Get Key"
textButton3.AutoButtonColor = false
textButton3.Parent = frame2
local uiCorner4 = Instance.new("UICorner")
uiCorner4.CornerRadius = UDim.new(0, 8)
uiCorner4.Parent = textButton3
local textLabel5 = Instance.new("TextLabel")
textLabel5.Position = UDim2.new(0, 18, 0, 238)
textLabel5.Size = UDim2.new(1, -36, 0, 46)
textLabel5.BackgroundTransparency = 1
textLabel5.Font = Enum.Font.Gotham
textLabel5.TextSize = 11
textLabel5.TextColor3 = Color3.fromRGB(95, 95, 115)
textLabel5.TextWrapped = true
textLabel5.TextYAlignment = Enum.TextYAlignment.Top
textLabel5.Text = "Need help? Join the Discord"
textLabel5.Parent = frame2
local uiScale = Instance.new("UIScale")
uiScale.Parent = screenGui

local function fn6()
    local currentCamera = workspace.CurrentCamera
    if not currentCamera then
        return
    end
    local viewportSize = currentCamera.ViewportSize
    local n = math.min(1, (viewportSize.X - 30) / 360, (viewportSize.Y - 30) / 330)
    uiScale.Scale = math.max(0.6, n)
end

pcall(fn6)

pcall(function()
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fn6)
end)

local function fn7(text, textColor3)
    textLabel4.Text = text
    textLabel4.TextColor3 = textColor3
end

local function fn8()
    local position = frame2.Position
    frame2.Position = position + UDim2.new(0, -6, 0, 0)
    task.wait(0.03)
    frame2.Position = position + UDim2.new(0, 6, 0, 0)
    task.wait(0.03)
    frame2.Position = position + UDim2.new(0, -6, 0, 0)
    task.wait(0.03)
    frame2.Position = position + UDim2.new(0, 6, 0, 0)
    task.wait(0.03)
    frame2.Position = position + UDim2.new(0, -6, 0, 0)
    task.wait(0.03)
    frame2.Position = position
end

textBox.Focused:Connect(function()
    TweenService:Create(uiStroke2, TweenInfo.new(0.15), {Color = Color3.fromRGB(88, 101, 242)}):Play()
end)

textBox.FocusLost:Connect(function()
    TweenService:Create(uiStroke2, TweenInfo.new(0.2), {Color = Color3.fromRGB(50, 50, 65)}):Play()
end)

textButton2.MouseEnter:Connect(function()
    TweenService:Create(textButton2, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(100, 112, 250)}):Play()
end)

textButton2.MouseLeave:Connect(function()
    TweenService:Create(textButton2, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(88, 101, 242)}):Play()
end)

local flag = false
local n = 0
local n2 = 0
local v2 = nil

frame3.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local x = input.Position.X
        local y = input.Position.Y
        local position = frame2.Position
        flag = true
        n = x
        n2 = y
        v2 = position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                flag = false
            end
        end)
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if flag and v2 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        frame2.Position = UDim2.new(v2.X.Scale, v2.X.Offset + input.Position.X - n, v2.Y.Scale, v2.Y.Offset + input.Position.Y - n2)
    end
end)

local flag2 = false

local function fn9()
    local response = nil

    pcall(function()
        response = game:HttpGet(tbl.scriptUrl)
    end)

    if type(response) ~= "string" or response == "" then
        pcall(function()
            response = game:HttpGetAsync(tbl.scriptUrl)
        end)
    end

    if type(response) == "string" and response ~= "" then
        if not response:lower():find("<html") then
            local chunk = loadstring(response)

            if not chunk then
                fn7("Main script error", Color3.fromRGB(255, 110, 110))
                flag2 = false
                textButton2.Text = "Verify"
                return
            end

            fn7("Loading...", Color3.fromRGB(110, 230, 160))
            task.wait(0.2)

            pcall(function()
                screenGui:Destroy()
            end)

            pcall(chunk)
            return
        end

        fn7("Script link returned a webpage", Color3.fromRGB(255, 110, 110))
        flag2 = false
        textButton2.Text = "Verify"
        return
    end

    fn7("Couldn't download main script", Color3.fromRGB(255, 110, 110))
    flag2 = false
    textButton2.Text = "Verify"
end

local function fn10()
    if flag2 then
        return
    end
    local v3 = fn2(textBox.Text)

    if v3 == "" then
        fn7("Paste your key first", Color3.fromRGB(255, 110, 110))
        task.spawn(fn8)
        return
    end

    flag2 = true
    textButton2.Text = "Checking..."
    fn7("Checking...", Color3.fromRGB(140, 140, 160))

    task.spawn(function()
        task.wait(0.3)

        if fn4(v3) then
            fn5(v3)
            textButton2.Text = "Verified"
            fn9()
        else
            fn7("Wrong key, try again", Color3.fromRGB(255, 110, 110))
            task.spawn(fn8)
            flag2 = false
            textButton2.Text = "Verify"
        end
    end)
end

textButton2.MouseButton1Click:Connect(fn10)

textBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        fn10()
    end
end)

textButton3.MouseButton1Click:Connect(function()
    local keyLink = tbl.keyLink ~= "" and tbl.keyLink or tbl.discord

    if setclipboard then
        pcall(setclipboard, keyLink)
    end

    fn7("Key link copied to clipboard", Color3.fromRGB(110, 230, 160))
end)

frame.BackgroundTransparency = 1
frame2.BackgroundTransparency = 1
TweenService:Create(frame, TweenInfo.new(0.25), {BackgroundTransparency = 0.55}):Play()
TweenService:Create(frame2, TweenInfo.new(0.25), {BackgroundTransparency = 0}):Play()

local v3 = (function()
    if not tbl.remember then
        return nil
    end

    local ok, result = pcall(function()
        local v3 = isfile
        local v4 = v3 and isfile(tbl.saveFile)
        return v4
    end)

    if ok and result then
        local ok2, result2 = pcall(function()
            return readfile(tbl.saveFile)
        end)

        if ok2 and fn2(result2) ~= "" then
            return fn2(result2)
        end
    end

    return nil
end)()

if v3 and fn4(v3) then
    textBox.Text = v3
    fn7("Saved key found, logging in...", Color3.fromRGB(110, 230, 160))
    task.wait(0.7)

    if screenGui.Parent then
        flag2 = true
        textButton2.Text = "Checking..."
        fn9()
    end
end
