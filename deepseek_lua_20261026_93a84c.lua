--[[
  THEOO HUB — Palaiyot si Theoo Edition
  Features: Silent Aim + Smoothness, Fixed Godmode, ESP, Noclip (Stopped), Minecraft, Anti-Kick
]]

if not game:IsLoaded() then game.Loaded:Wait() end

-- ANTI-KICK (MEGGD)
task.spawn(function()
    pcall(function()
        local url = "https://raw.githubusercontent.com/SUUUUUS00000/MEGGD-Anti-kick/refs/heads/main/MEGGD%20Best%20Anti-kick.lua"
        local runner = loadstring(game:HttpGet(url))
        if type(runner) == "function" then runner(); print("[Anti-Kick] Loaded.") end
    end)
end)

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace        = game:GetService("Workspace")
local CoreGui          = game:GetService("CoreGui")
local TweenService     = game:GetService("TweenService")
local LocalPlayer      = Players.LocalPlayer
local Camera           = Workspace.CurrentCamera

-- SPLASH SCREEN — "Palaiyot si Theoo"
local oldSplash = CoreGui:FindFirstChild("TheooSplash")
if oldSplash then oldSplash:Destroy() end
local SplashGui = Instance.new("ScreenGui", CoreGui)
SplashGui.Name = "TheooSplash"; SplashGui.ResetOnSpawn = false; SplashGui.IgnoreGuiInset = true
local SplashBg = Instance.new("Frame", SplashGui)
SplashBg.Size = UDim2.new(1,0,1,0); SplashBg.BackgroundColor3 = Color3.fromRGB(10,10,15); SplashBg.BorderSizePixel = 0
local SplashText = Instance.new("TextLabel", SplashBg)
SplashText.Size = UDim2.new(1,0,0,60); SplashText.Position = UDim2.new(0,0,0.5,-30)
SplashText.BackgroundTransparency = 1; SplashText.Text = "Palaiyot si Theoo"
SplashText.TextColor3 = Color3.fromRGB(200,200,255); SplashText.Font = Enum.Font.GothamBlack; SplashText.TextSize = 32; SplashText.TextTransparency = 1
TweenService:Create(SplashText, TweenInfo.new(0.5), {TextTransparency=0}):Play()
task.delay(2.5, function()
    TweenService:Create(SplashBg, TweenInfo.new(0.5), {BackgroundTransparency=1}):Play()
    TweenService:Create(SplashText, TweenInfo.new(0.5), {TextTransparency=1}):Play()
    task.wait(0.5)
    SplashGui:Destroy()
end)

-- CONFIG
local Config = {
    SilentAim = false, AimSmooth = 0.35, FovSize = 200,
    Godmode = false, Noclip = false, ESP = false, Minecraft = false
}
local SA = { targetPart = nil, namecallOld = nil, hookActive = false }
local Highlights, mcRestores = {}, {}
local NoClipConnection = nil
local GodmodeConn = nil

-- AIM ASSIST
local function GetTarget()
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    local bestPart, bestScore = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local part = p.Character:FindFirstChild("Head") or p.Character:FindFirstChild("HumanoidRootPart")
                if part then
                    local scr, on = Camera:WorldToViewportPoint(part.Position)
                    if on and scr.Z > 0 then
                        local dSq = (scr.X-center.X)^2 + (scr.Y-center.Y)^2
                        if dSq <= Config.FovSize^2 and dSq < bestScore then
                            bestScore = dSq; bestPart = part
                        end
                    end
                end
            end
        end
    end
    return bestPart
end

local function InstallSA()
    if SA.hookActive then return end
    SA.namecallOld = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        if Config.SilentAim and not checkcaller() then
            local args = {...}
            if getnamecallmethod() == "FireServer" then
                for i, v in ipairs(args) do
                    if typeof(v) == "CFrame" and SA.targetPart then
                        local goal = CFrame.lookAt(v.Position, SA.targetPart.Position)
                        args[i] = v:Lerp(goal, Config.AimSmooth)
                    end
                end
                return SA.namecallOld(self, unpack(args))
            end
        end
        return SA.namecallOld(self, ...)
    end))
    SA.hookActive = true
end

-- GODMODE (fixed — no slow-mo, no walk glitch)
local function ToggleGodmode(state)
    if GodmodeConn then GodmodeConn:Disconnect() GodmodeConn = nil end
    if not state then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.MaxHealth = 100; hum.Health = 100 end
            local ff = char:FindFirstChildOfClass("ForceField")
            if ff then ff:Destroy() end
        end
        return
    end
    GodmodeConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        hum.MaxHealth = math.huge
        if hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
        local ff = char:FindFirstChildOfClass("ForceField")
        if not ff then
            ff = Instance.new("ForceField")
            ff.Visible = false
            ff.Parent = char
        end
    end)
end

-- NOCLIP (STOPPED — CanCollide true)
local function ToggleNoclip(state)
    if NoClipConnection then NoClipConnection:Disconnect() NoClipConnection = nil end
    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

-- ESP
local function UpdateESP()
    if not Config.ESP then
        for _, hl in pairs(Highlights) do if hl then hl:Destroy() end end
        Highlights = {}
        return
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and (not Highlights[plr] or not Highlights[plr].Parent) then
            local hl = Instance.new("Highlight")
            hl.FillColor = Color3.fromRGB(255,182,213); hl.OutlineColor = Color3.new(1,1,1)
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = plr.Character; Highlights[plr] = hl
        end
    end
end

-- MINECRAFT
local textures = { Slate="rbxassetid://8676746437", Grass="rbxassetid://9267183930", Sand="rbxassetid://12624140843", Wood="rbxassetid://3258599312", Brick="rbxassetid://10777285622", Concrete="rbxassetid://15622710576", CorrodedMetal="rbxassetid://7861269583", Metal="rbxassetid://12165061309", WoodPlanks="rbxassetid://8676581022" }
local function ToggleMinecraft(state)
    if state then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Transparency < 0.8 and not mcRestores[obj] then
                local tex = textures[obj.Material.Name]
                if tex then
                    mcRestores[obj] = {Color=obj.Color, Material=obj.Material}
                    obj.Color = Color3.fromRGB(254,253,255); obj.Material = Enum.Material.SmoothPlastic
                    local t = Instance.new("Texture", obj); t.Texture = tex; t.Face = Enum.NormalId.Top; t.StudsPerTileU = 6; t.StudsPerTileV = 6
                end
            end
        end
    else
        for part, data in pairs(mcRestores) do
            if part and part.Parent then
                part.Color = data.Color; part.Material = data.Material
                for _, c in ipairs(part:GetChildren()) do if c:IsA("Texture") then c:Destroy() end end
            end
        end
        mcRestores = {}
    end
end

-- UI
local Gui = Instance.new("ScreenGui", CoreGui)
Gui.Name = "TheooHub"; Gui.ResetOnSpawn = false
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0, 280, 0, 420); Main.Position = UDim2.new(0.5, -140, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(15,15,20); Main.Active = true; Main.Draggable = true; Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,10)
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,35); Title.BackgroundColor3 = Color3.fromRGB(25,25,35)
Title.Text = "Palaiyot si Theoo"; Title.TextColor3 = Color3.new(1,1,1); Title.Font = Enum.Font.GothamBold
Instance.new("UICorner", Title).CornerRadius = UDim.new(0,10)
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1,-20,1,-50); Scroll.Position = UDim2.new(0,10,0,45)
Scroll.BackgroundTransparency = 1; Scroll.CanvasSize = UDim2.new(0,0,0,550)
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0,5)

local function AddToggle(text, default, cb)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(1,0,0,32)
    btn.BackgroundColor3 = default and Color3.fromRGB(50,120,70) or Color3.fromRGB(60,60,70)
    btn.Text = text .. " [" .. (default and "ON" or "OFF") .. "]"
    btn.TextColor3 = Color3.new(1,1,1); btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    btn.Activated:Connect(function()
        default = not default
        btn.Text = text .. " [" .. (default and "ON" or "OFF") .. "]"
        btn.BackgroundColor3 = default and Color3.fromRGB(50,120,70) or Color3.fromRGB(60,60,70)
        if cb then cb(default) end
    end)
end

local function AddSlider(text, min, max, default, cb)
    local frame = Instance.new("Frame", Scroll)
    frame.Size = UDim2.new(1,0,0,50); frame.BackgroundColor3 = Color3.fromRGB(40,40,50)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1,-10,0,20); label.Position = UDim2.new(0,5,0,2)
    label.BackgroundTransparency = 1; label.Text = text .. ": " .. default
    label.TextColor3 = Color3.new(1,1,1); label.Font = Enum.Font.GothamBold; label.TextSize = 13
    local bar = Instance.new("Frame", frame)
    bar.Size = UDim2.new(0.9,0,0,8); bar.Position = UDim2.new(0.05,0,0,32)
    bar.BackgroundColor3 = Color3.fromRGB(80,80,90); Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)
    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((default-min)/(max-min),0,1,0); fill.BackgroundColor3 = Color3.fromRGB(100,150,255)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)
    local dragging = false
    bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local rel = math.clamp((i.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local val = math.floor((min + (max-min)*rel) * 100) / 100
            fill.Size = UDim2.new(rel,0,1,0); label.Text = text .. ": " .. val; cb(val)
        end
    end)
end

AddToggle("Silent Aim", false, function(s) Config.SilentAim = s; if s then InstallSA() end end)
AddSlider("Aim Smoothness", 0.05, 1, 0.35, function(v) Config.AimSmooth = v end)
AddSlider("FOV Size", 50, 500, 200, function(v) Config.FovSize = v end)
AddToggle("Godmode (Fixed)", false, ToggleGodmode)
AddToggle("Highlight ESP", false, function(s) Config.ESP = s end)
AddToggle("Noclip (STOPPED)", false, ToggleNoclip)
AddToggle("Real Minecraft", false, ToggleMinecraft)

-- ICON
local Icon = Instance.new("TextButton", Gui)
Icon.Size = UDim2.new(0, 50, 0, 50); Icon.Position = UDim2.new(0, 20, 0.5, -25)
Icon.BackgroundColor3 = Color3.fromRGB(25,25,35); Icon.Text = "T"
Icon.TextColor3 = Color3.new(1,1,1); Icon.Font = Enum.Font.GothamBold; Icon.TextSize = 24
Instance.new("UICorner", Icon).CornerRadius = UDim.new(1,0)
Instance.new("UIStroke", Icon).Color = Color3.fromRGB(100,120,255)
Icon.Activated:Connect(function() Main.Visible = not Main.Visible end)

-- LOOP
RunService.RenderStepped:Connect(function()
    if Config.SilentAim then SA.targetPart = GetTarget() else SA.targetPart = nil end
    UpdateESP()
end)

print("[Theoo Hub] Palaiyot si Theoo — Loaded.")