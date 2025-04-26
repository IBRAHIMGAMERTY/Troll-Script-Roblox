-- Made By Ai (Troll Script But Gui)
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

local MY_USER_ID = 4379806260
local TROLL_SCRIPT_URL = "https://raw.githubusercontent.com/IBRAHIMGAMERTY/Troll-Script-Roblox/Troll-Scripts-Folder/Troll Script.Lua"

local LocalPlayer = Players.LocalPlayer
local PlayerGui = nil
local success, pg = pcall(function() return LocalPlayer:WaitForChild("PlayerGui", 10) end)
if success and pg then
    PlayerGui = pg
else
    warn("PlayerGui not found after waiting.")
end

local function loadAndRunTrollScript(targetPlayerName)
    local success, result = pcall(function()
        local scriptContent = game:HttpGetAsync(TROLL_SCRIPT_URL)
        local scriptFunction, loadError = loadstring(scriptContent)
        if scriptFunction then
            print("Successfully loaded external script.")
            local execSuccess, execError = pcall(scriptFunction)
            if not execSuccess then
                warn("Error executing external script:", execError)
                if PlayerGui then
                    StarterGui:SetCore("SendNotification", {
                        Title = "Script Error",
                        Text = "Failed to execute the external script: " .. tostring(execError),
                        Duration = 5,
                        Icon = "rbxassetid://13047423804"
                    })
                end
            else
                 print("External script executed.")
                 if targetPlayerName and PlayerGui then
                     StarterGui:SetCore("SendNotification", {
                        Title = "Script Executed",
                        Text = "Troll script executed targeting " .. targetPlayerName,
                        Duration = 5,
                        Icon = "rbxassetid://13047423809"
                    })
                 elseif PlayerGui then
                     StarterGui:SetCore("SendNotification", {
                        Title = "Script Executed",
                        Text = "Troll script executed.",
                        Duration = 5,
                        Icon = "rbxassetid://13047423809"
                    })
                 end
            end
        else
            warn("Error loading external script:", loadError)
             if PlayerGui then
                StarterGui:SetCore("SendNotification", {
                    Title = "Script Error",
                    Text = "Failed to load the external script: " .. tostring(loadError),
                    Duration = 5,
                    Icon = "rbxassetid://13047423804"
                })
            end
        end
    end)
    if not success then
        warn("Error fetching external script:", result)
         if PlayerGui then
            StarterGui:SetCore("SendNotification", {
                Title = "Network Error",
                Text = "Failed to fetch the external script from URL: " .. tostring(result),
                Duration = 5,
                Icon = "rbxassetid://13047423811"
            })
        end
    end
end
local function createOwnerGui()
    if not PlayerGui then
        warn("createOwnerGui called but PlayerGui is not available.")
        return
    end
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TrollControlGui"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 420, 0, 220)
    mainFrame.Position = UDim2.new(0.5, -210, 0.5, -110)
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 37, 40)
    mainFrame.BorderColor3 = Color3.fromRGB(20, 20, 22)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Visible = true
    mainFrame.ClipsDescendants = true
    mainFrame.BackgroundTransparency = 1
    mainFrame.Parent = screenGui
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 12)
    frameCorner.Parent = mainFrame
    local frameGradient = Instance.new("UIGradient")
    frameGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(55, 58, 64)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 42, 46))
    }
    frameGradient.Rotation = 90
    frameGradient.Parent = mainFrame
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, -20, 0, 40)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamSemibold
    titleLabel.Text = "Who Do You Want To Troll Today?"
    titleLabel.TextColor3 = Color3.fromRGB(230, 230, 235)
    titleLabel.TextSize = 20
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.Parent = mainFrame
    local usernameInput = Instance.new("TextBox")
    usernameInput.Name = "UsernameInput"
    usernameInput.Size = UDim2.new(1, -40, 0, 40)
    usernameInput.Position = UDim2.new(0, 20, 0, 65)
    usernameInput.BackgroundColor3 = Color3.fromRGB(30, 31, 34)
    usernameInput.BorderColor3 = Color3.fromRGB(60, 62, 68)
    usernameInput.BorderSizePixel = 1
    usernameInput.Font = Enum.Font.SourceSans
    usernameInput.PlaceholderText = "Enter Username..."
    usernameInput.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
    usernameInput.TextColor3 = Color3.fromRGB(210, 215, 220)
    usernameInput.TextSize = 16
    usernameInput.ClearTextOnFocus = false
    usernameInput.Parent = mainFrame
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = usernameInput
    local function setupButtonHover(button, normalColor, hoverColor)
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.15), { BackgroundColor3 = hoverColor }):Play()
        end)
        button.MouseLeave:Connect(function()
             TweenService:Create(button, TweenInfo.new(0.15), { BackgroundColor3 = normalColor }):Play()
        end)
    end
    local submitButton = Instance.new("TextButton")
    submitButton.Name = "SubmitButton"
    submitButton.Size = UDim2.new(0.5, -25, 0, 40)
    submitButton.Position = UDim2.new(0, 20, 1, -60)
    local submitNormalColor = Color3.fromRGB(34, 139, 34)
    local submitHoverColor = Color3.fromRGB(46, 160, 46)
    submitButton.BackgroundColor3 = submitNormalColor
    submitButton.BorderSizePixel = 0
    submitButton.Font = Enum.Font.GothamBold
    submitButton.Text = "Target Player"
    submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitButton.TextSize = 16
    submitButton.Parent = mainFrame
    local submitCorner = Instance.new("UICorner")
    submitCorner.CornerRadius = UDim.new(0, 8)
    submitCorner.Parent = submitButton
    setupButtonHover(submitButton, submitNormalColor, submitHoverColor)
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.5, -25, 0, 40)
    closeButton.Position = UDim2.new(0.5, 5, 1, -60)
    local closeNormalColor = Color3.fromRGB(196, 40, 40)
    local closeHoverColor = Color3.fromRGB(210, 55, 55)
    closeButton.BackgroundColor3 = closeNormalColor
    closeButton.BorderSizePixel = 0
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Text = "Close"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 16
    closeButton.Parent = mainFrame
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeButton
    setupButtonHover(closeButton, closeNormalColor, closeHoverColor)
    screenGui.Parent = PlayerGui
    mainFrame.BackgroundTransparency = 1
    local fadeInInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local fadeInGoal = { BackgroundTransparency = 0 }
    local fadeInTween = TweenService:Create(mainFrame, fadeInInfo, fadeInGoal)
    fadeInTween:Play()
    submitButton.MouseButton1Click:Connect(function()
        local targetUsername = usernameInput.Text
        if targetUsername and targetUsername ~= "" then
            local targetPlayer = Players:FindFirstChild(targetUsername)
            if targetPlayer then
                print("Target player found:", targetPlayer.Name)
                loadAndRunTrollScript(targetPlayer.Name)
            else
                warn("Player not found:", targetUsername)
                 if PlayerGui then
                    StarterGui:SetCore("SendNotification", {
                        Title = "Error",
                        Text = "Player '" .. targetUsername .. "' not found in this server.",
                        Duration = 5,
                        Icon = "rbxassetid://13047423811"
                    })
                 end
            end
            usernameInput.Text = ""
        else
             if PlayerGui then
                StarterGui:SetCore("SendNotification", {
                    Title = "Input Error",
                    Text = "Please enter a username.",
                    Duration = 3,
                    Icon = "rbxassetid://13047423811"
                })
             end
        end
    end)
    closeButton.MouseButton1Click:Connect(function()
        local fadeOutInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        local fadeOutGoal = { BackgroundTransparency = 1 }
        local fadeOutTween = TweenService:Create(mainFrame, fadeOutInfo, fadeOutGoal)
        local completedConnection
        completedConnection = fadeOutTween.Completed:Connect(function()
            if screenGui and screenGui.Parent then
                screenGui:Destroy()
            end
            if completedConnection then completedConnection:Disconnect() end
        end)
        fadeOutTween:Play()
    end)
end

if not LocalPlayer then
    warn("LocalPlayer not found! This script must run as a LocalScript.")
    return
end

if not PlayerGui then
    warn("Script stopped because PlayerGui could not be found.")
    return
end

if LocalPlayer.UserId == 0 then
    LocalPlayer:GetPropertyChangedSignal("UserId"):Wait()
end

if LocalPlayer.UserId == MY_USER_ID then
    print("Owner detected. Creating GUI.")
    task.wait(0.1)
    createOwnerGui()
else
    print("Not the owner. Attempting to load troll script immediately.")
    loadAndRunTrollScript(nil)
end
