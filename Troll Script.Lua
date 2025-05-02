-- Made By Ai (Troll Script)

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterPlayer = game:GetService("StarterPlayer")
local Random = Random.new()
local ContentProvider = game:GetService("ContentProvider")
local Workspace = game:GetService("Workspace")

StarterPlayer.CameraMode = Enum.CameraMode.LockFirstPerson

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")
local workspaceCamera = Workspace.CurrentCamera or game.Workspace.CurrentCamera

local defaultFOV = 70
local defaultWalkSpeed = 16
local slowWalkSpeed = 8

local creepyTexts = {
	"Why You Did This",
	"Why Are You Here",
	"There Is No Exit",
	"You Can't Find The Exit",
    "Look Behind You",
    "Are You Alone?",
    "He's Watching You",
    "There's No escape Now",
    "Join Us"
}

local randomTextGUI = Instance.new("ScreenGui")
randomTextGUI.Name = "RandomTextGUI"
randomTextGUI.ResetOnSpawn = false
randomTextGUI.IgnoreGuiInset = true
randomTextGUI.Parent = playerGui
randomTextGUI.Enabled = false

local randomTextLabel = Instance.new("TextLabel")
randomTextLabel.Name = "RandomTextLabel"
randomTextLabel.Parent = randomTextGUI
print("Parent of randomTextLabel:", randomTextLabel.Parent)

randomTextLabel.TextColor3 = Color3.new(1, 0, 0)
randomTextLabel.BackgroundTransparency = 1
randomTextLabel.TextTransparency = 0
randomTextLabel.TextScaled = true

randomTextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
randomTextLabel.Size = UDim2.new(0.3, 0, 0.1, 0)
randomTextLabel.ZIndex = 20
randomTextLabel.Visible = false

local function displayOnScreenText(text)
	local notification = Instance.new("TextLabel")
	notification.Parent = playerGui
	notification.BackgroundColor3 = Color3.new(0, 0, 0)
	notification.BackgroundTransparency = 1
	notification.BorderSizePixel = 0
	notification.Font = Enum.Font.SourceSansBold
	notification.Text = text
	notification.TextColor3 = Color3.new(1, 1, 1)
	notification.TextScaled = true
	notification.TextSize = 25
	notification.Size = UDim2.new(0, 200, 0, 50)
	notification.Position = UDim2.new(0.5, -100, 0.5, -25)
	notification.ZIndex = 15
	notification.TextTransparency = 1

	local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tweenIn = TweenService:Create(notification, tweenInfo, {TextTransparency = 0})
	local tweenOut = TweenService:Create(notification, tweenInfo, {Transparency = 1})

	tweenIn:Play()

	task.wait(1)
    if notification and notification.Parent then
		tweenOut:Play()
		tweenOut.Completed:Connect(function()
			if notification and notification.Parent then
				notification:Destroy()
			end
		end)
    else
        if tweenOut and tweenOut.Completed.Connected then
             tweenOut.Completed:Disconnect()
        end
    end
end

Lighting.FogEnd = 300
Lighting.FogColor = Color3.new(0, 0, 0)
Lighting.ClockTime = 14

local dayToNightInfo = TweenInfo.new(15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local dayToNightTween = TweenService:Create(Lighting, dayToNightInfo, {ClockTime = 1})
dayToNightTween:Play()

dayToNightTween.Completed:Connect(function()
	Lighting.Ambient = Color3.new(0.1, 0.1, 0.1)
    Lighting.OutdoorAmbient = Color3.new(0.1, 0.1, 0.1)
	Lighting.FogEnd = 60

	local backgroundSound = Instance.new("Sound")
	backgroundSound.Name = "BackgroundSound"
	backgroundSound.SoundId = "rbxassetid://9072301639"
	backgroundSound.Looped = true
	backgroundSound.Volume = 0.3
	backgroundSound.PlaybackSpeed = 0.8
	backgroundSound.Parent = Lighting
    ContentProvider:PreloadAsync({backgroundSound.SoundId}, function()
        if backgroundSound and backgroundSound.IsLoaded then backgroundSound:Play() else warn("Background sound not loaded or is nil!") end
    end)


	local fadeScreen = Instance.new("ScreenGui")
	fadeScreen.Name = "FadeScreen"
	fadeScreen.ResetOnSpawn = false
	fadeScreen.IgnoreGuiInset = true
	fadeScreen.Parent = playerGui

	local blackFrame = Instance.new("Frame")
	blackFrame.Name = "BlackFrame"
	blackFrame.BackgroundColor3 = Color3.new(0, 0, 0)
	blackFrame.Size = UDim2.new(1, 0, 1, 0)
    blackFrame.Position = UDim2.new(0, 0, 0, 0)
    blackFrame.AnchorPoint = Vector2.new(0, 0)
	blackFrame.ZIndex = 10
	blackFrame.Transparency = 1
	blackFrame.Parent = fadeScreen

	task.wait(0.1)

	local fadeInTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local fadeInTween = TweenService:Create(blackFrame, fadeInTweenInfo, {Transparency = 0})
	fadeInTween:Play()
	fadeInTween.Completed:Wait()

    local platform = Instance.new("Part")
    platform.Name = "ScaryPlatform"
    platform.Anchored = true
    platform.Size = Vector3.new(1500, 1, 1500)
    platform.Position = Vector3.new(0, 500, 0)
    platform.Material = Enum.Material.Grass
    platform.Color = Color3.fromRGB(50, 205, 50)
    platform.Parent = Workspace

    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    humanoidRootPart.CFrame = CFrame.new(platform.Position + Vector3.new(0, platform.Size.Y/2 + 2.5, 0))

    localPlayer.CameraMode = Enum.CameraMode.LockFirstPerson

    local humanoid = character:WaitForChild("Humanoid")
    if humanoid then
        humanoid.JumpPower = 0
        humanoid.WalkSpeed = defaultWalkSpeed
    end

	local platformKickDebounce = false
    local checkPositionConnection = nil
	local function checkPlayerPosition()
		if platformKickDebounce then return end
		local char = localPlayer.Character
		if not char or not char.Parent then return end
		local hrp_player = char:FindFirstChild("HumanoidRootPart")
		if not hrp_player then return end
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if not hum then return end
		local plat = Workspace:FindFirstChild("ScaryPlatform")
		if not plat then return end

		local currentY = hrp_player.Position.Y
		local platformTopY = plat.Position.Y + (plat.Size.Y / 2)

		local kickCondition = false
		if (currentY > platformTopY + 7 or currentY < platformTopY - 0.5) or (hum.Health <= 0) then
			kickCondition = true
		end

		if kickCondition then
			platformKickDebounce = true
            if checkPositionConnection then
                checkPositionConnection:Disconnect()
                checkPositionConnection = nil
            end
            if platform and platform.Parent then
                platform:Destroy()
            end

			local redFadeScreen = Instance.new("ScreenGui")
			redFadeScreen.Name = "RedFadeScreen_PlatformKick"
			redFadeScreen.ResetOnSpawn = false
			redFadeScreen.IgnoreGuiInset = true
			redFadeScreen.Parent = playerGui
			local redFrame = Instance.new("Frame")
			redFrame.Name = "RedFrame"
			redFrame.BackgroundColor3 = Color3.new(1, 0, 0)
			redFrame.Size = UDim2.new(1, 0, 1, 0)
            redFrame.Position = UDim2.new(0, 0, 0, 0)
            redFrame.AnchorPoint = Vector2.new(0, 0)
			redFrame.ZIndex = 25
			redFrame.Transparency = 1
			redFrame.Parent = redFadeScreen

			local redFadeInTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local redFadeInTween = TweenService:Create(redFrame, redFadeInTweenInfo, {Transparency = 0})
			redFadeInTween:Play()

			task.wait(1)
			localPlayer:Kick("N̵̢͝į̷̇̅ͅc̷̯̟͌̑e̶͇̒͊ ̸̳̩̀̾Ţ̸̭̕r̸̰̪̈͒ÿ̷̦̲̔ ̸͖̮͒͘T̴̝͖́o̶̲͒̍ ̷̻͙͋Ë̵̩s̶̨̃c̷̰̉̚ā̸͖̩p̶̛͍̯͠e̶̤̬̓̊")
		end
	end
	checkPositionConnection = RunService.Heartbeat:Connect(checkPlayerPosition)

	task.wait(1)

	local fadeOutTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local fadeOutTween = TweenService:Create(blackFrame, fadeOutTweenInfo, {Transparency = 1})
	fadeOutTween:Play()
	fadeOutTween.Completed:Connect(function()
		if fadeScreen and fadeScreen.Parent then fadeScreen:Destroy() end

		task.wait(10)

		local entity = Instance.new("Model")
		entity.Name = "ScaryEntity"
		entity.Parent = Workspace

		local entityHumanoid = Instance.new("Humanoid")
		entityHumanoid.Parent = entity
		entityHumanoid.DisplayName = localPlayer.DisplayName .. " Dark Soul"
		entityHumanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
		entityHumanoid.WalkSpeed = 35
        entityHumanoid.RigType = Enum.HumanoidRigType.R6

        local headSize = Vector3.new(2, 1, 1)
        local torsoSize = Vector3.new(2, 2, 1)
        local limbSize = Vector3.new(1, 2, 1)

		local hrp = Instance.new("Part")
		hrp.Name = "HumanoidRootPart"
		hrp.Size = Vector3.new(2, 2, 1)
		hrp.Transparency = 1
		hrp.CanCollide = false
		hrp.Anchored = false
		hrp.Parent = entity
		entity.PrimaryPart = hrp

		local torso = Instance.new("Part")
		torso.Name = "Torso"
		torso.Size = torsoSize
		torso.Color = Color3.new(0, 0, 0)
		torso.Material = Enum.Material.Plastic
		torso.Transparency = 0
        torso.CanCollide = true
        torso.Anchored = false
		torso.Parent = entity
        local torsoMesh = Instance.new("BlockMesh")
        torsoMesh.Parent = torso

		local head = Instance.new("Part")
		head.Name = "Head"
		head.Size = headSize
		head.Color = Color3.new(0, 0, 0)
		head.Material = Enum.Material.Plastic
		head.Transparency = 0
        head.CanCollide = false
		head.Parent = entity
        local headMesh = Instance.new("BlockMesh")
        headMesh.Parent = head

		local face = Instance.new("Decal")
		face.Face = Enum.NormalId.Front
		face.Texture = "rbxassetid://180660043"
		face.Parent = head

		local leftArm = Instance.new("Part")
		leftArm.Name = "Left Arm"
		leftArm.Size = limbSize
		leftArm.Color = Color3.new(0, 0, 0)
		leftArm.Material = Enum.Material.Plastic
		leftArm.Transparency = 0
        leftArm.CanCollide = false
		leftArm.Parent = entity
        local laMesh = Instance.new("BlockMesh")
        laMesh.Parent = leftArm

		local rightArm = Instance.new("Part")
		rightArm.Name = "Right Arm"
		rightArm.Size = limbSize
		rightArm.Color = Color3.new(0, 0, 0)
		rightArm.Material = Enum.Material.Plastic
		rightArm.Transparency = 0
        rightArm.CanCollide = false
		rightArm.Parent = entity
        local raMesh = Instance.new("BlockMesh")
        raMesh.Parent = rightArm

		local leftLeg = Instance.new("Part")
		leftLeg.Name = "Left Leg"
		leftLeg.Size = limbSize
		leftLeg.Color = Color3.new(0, 0, 0)
		leftLeg.Material = Enum.Material.Plastic
		leftLeg.Transparency = 0
        leftLeg.CanCollide = false
		leftLeg.Parent = entity
        local llMesh = Instance.new("BlockMesh")
        llMesh.Parent = leftLeg

		local rightLeg = Instance.new("Part")
		rightLeg.Name = "Right Leg"
		rightLeg.Size = limbSize
		rightLeg.Color = Color3.new(0, 0, 0)
		rightLeg.Material = Enum.Material.Plastic
		rightLeg.Transparency = 0
        rightLeg.CanCollide = false
		rightLeg.Parent = entity
        local rlMesh = Instance.new("BlockMesh")
        rlMesh.Parent = rightLeg

        local spawnOffset = Vector3.new(Random:NextInteger(-100, 100), 0, Random:NextInteger(-100, 100)).Unit * 150
        if platform and platform.Parent then
            hrp.CFrame = platform.CFrame * CFrame.new(0, platform.Size.Y/2 + torso.Size.Y/2, 0) + spawnOffset
        else
             hrp.CFrame = CFrame.new(0, 505, 0) + spawnOffset
        end

        torso.CFrame = hrp.CFrame
        head.CFrame = torso.CFrame * CFrame.new(0, torso.Size.Y/2 + head.Size.Y/2, 0)
        leftArm.CFrame = torso.CFrame * CFrame.new(-(torso.Size.X/2 + leftArm.Size.X/2), 0, 0)
        rightArm.CFrame = torso.CFrame * CFrame.new( (torso.Size.X/2 + rightArm.Size.X/2), 0, 0)
        leftLeg.CFrame = torso.CFrame * CFrame.new(-(torso.Size.X/2 - leftLeg.Size.X/2), -(torso.Size.Y/2 + leftLeg.Size.Y/2), 0)
        rightLeg.CFrame = torso.CFrame * CFrame.new( (torso.Size.X/2 - rightLeg.Size.X/2), -(torso.Size.Y/2 + rightLeg.Size.Y/2), 0)

		local rootWeld = Instance.new("WeldConstraint")
        rootWeld.Name = "RootWeld"
		rootWeld.Part0 = hrp
		rootWeld.Part1 = torso
		rootWeld.Parent = hrp

		local headWeld = Instance.new("WeldConstraint")
        headWeld.Name = "HeadWeld"
		headWeld.Part0 = torso
		headWeld.Part1 = head
		headWeld.Parent = torso

		local laWeld = Instance.new("WeldConstraint")
        laWeld.Name = "LeftArmWeld"
		laWeld.Part0 = torso
		laWeld.Part1 = leftArm
		laWeld.Parent = torso

		local raWeld = Instance.new("WeldConstraint")
        raWeld.Name = "RightArmWeld"
		raWeld.Part0 = torso
		raWeld.Part1 = rightArm
		raWeld.Parent = torso

		local llWeld = Instance.new("WeldConstraint")
        llWeld.Name = "LeftLegWeld"
		llWeld.Part0 = torso
		llWeld.Part1 = leftLeg
		llWeld.Parent = torso

		local rlWeld = Instance.new("WeldConstraint")
        rlWeld.Name = "RightLegWeld"
		rlWeld.Part0 = torso
		rlWeld.Part1 = rightLeg
		rlWeld.Parent = torso

		local smoke = Instance.new("ParticleEmitter")
		smoke.Name = "BlackSmoke"
		smoke.Texture = "rbxassetid://944880899"
		smoke.Color = ColorSequence.new(Color3.new(0, 0, 0))
        smoke.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 8), NumberSequenceKeypoint.new(1, 15)})
		smoke.Rate = 30
		smoke.Lifetime = NumberRange.new(0.5, 1.5)
        smoke.SpreadAngle = Vector2.new(360, 360)
		smoke.Parent = torso

		local redOverlayScreen = Instance.new("ScreenGui")
		redOverlayScreen.Name = "RedOverlayScreen"
		redOverlayScreen.ResetOnSpawn = false
		redOverlayScreen.IgnoreGuiInset = true
		redOverlayScreen.Parent = playerGui
		local redOverlayFrame = Instance.new("Frame")
		redOverlayFrame.Name = "RedOverlayFrame"
		redOverlayFrame.BackgroundColor3 = Color3.new(1, 0, 0)
		redOverlayFrame.Size = UDim2.new(1, 0, 1, 0)
        redOverlayFrame.Position = UDim2.new(0, 0, 0, 0)
        redOverlayFrame.AnchorPoint = Vector2.new(0, 0)
		redOverlayFrame.ZIndex = 12
		redOverlayFrame.Transparency = 1
		redOverlayFrame.Parent = redOverlayScreen

		local chaseSound = Instance.new("Sound")
		chaseSound.Name = "ChaseSound"
		chaseSound.SoundId = "rbxassetid://7255999109"
		chaseSound.Looped = true
		chaseSound.Volume = 0.7
		chaseSound.Parent = hrp

		local jumpScareSound = Instance.new("Sound")
		jumpScareSound.Name = "JumpScareSound"
		jumpScareSound.SoundId = "rbxassetid://85271883712040"
		jumpScareSound.Looped = false
		jumpScareSound.Volume = 1
		jumpScareSound.Parent = hrp

		local laughingSound = Instance.new("Sound")
		laughingSound.Name = "LaughingSound"
		laughingSound.SoundId = "rbxassetid://7854285068"
		laughingSound.Looped = false
		laughingSound.Volume = 0.8
		laughingSound.Parent = hrp

        ContentProvider:PreloadAsync({chaseSound.SoundId, jumpScareSound.SoundId, laughingSound.SoundId}, function()
            print("Scary sounds preloaded.")
        end)

		local hasEntitySpawned = false
		local runTextCooldown = false
		local entityTouchDebounce = false
		local slowWalkCooldown = 0
		local isPlayerSlowed = false
		local isRedOverlayActive = false

		local entityTouchConnection = nil
        local entityTorso = entity:FindFirstChild("Torso")
		if entityTorso then
            entityTouchConnection = entityTorso.Touched:Connect(function(hit)
                if entityTouchDebounce then return end
                local hitPartParent = hit.Parent
                if not hitPartParent then return end
                local hitPlayer = Players:GetPlayerFromCharacter(hitPartParent)

                if hitPlayer and hitPlayer == localPlayer then
                    entityTouchDebounce = true

                    if jumpScareSound and jumpScareSound.IsLoaded then jumpScareSound:Play() else warn("Jumpscare sound not loaded or is nil!") end
                    if laughingSound and laughingSound.IsLoaded then laughingSound:Play() else warn("Laughing sound not loaded or is nil!") end

                    local redFadeScreen = Instance.new("ScreenGui")
                    redFadeScreen.Name = "RedFadeScreen_Jumpscare"
                    redFadeScreen.ResetOnSpawn = false
                    redFadeScreen.IgnoreGuiInset = true
                    redFadeScreen.Parent = playerGui
                    local redFrame = Instance.new("Frame")
                    redFrame.Name = "RedFrame"
                    redFrame.BackgroundColor3 = Color3.new(1, 0, 0)
                    redFrame.Size = UDim2.new(1, 0, 1, 0)
                    redFrame.Position = UDim2.new(0, 0, 0, 0)
                    redFrame.AnchorPoint = Vector2.new(0, 0)
                    redFrame.ZIndex = 25
                    redFrame.Transparency = 1
                    redFrame.Parent = redFadeScreen

                    local redFadeInTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local redFadeInTween = TweenService:Create(redFrame, redFadeInTweenInfo, {Transparency = 0})
                    redFadeInTween:Play()

                    task.wait(1.5)
                    localPlayer:Kick("T̵͍̀h̵̟̆̽á̷͎̫͑ǹ̵̺̓k̴̫̦̾s̶̝̆͊ ̵̲̳̆F̶̻͂̕ò̸̡̫͘r̷̡̍ ̷̲͒̎T̵̯̅̃ḣ̷̥͑e̵̪͝ ̴̺̊͠B̴͓͝ó̴̦d̵̛͖͗͜y̶̘̍̌")

                    if entityTouchConnection then
                        entityTouchConnection:Disconnect()
                        entityTouchConnection = nil
                    end
                end
                task.wait(1)
                entityTouchDebounce = false
            end)
        else
             warn("Torso not found for touch detection.")
        end

        local entityAIConnection = nil
		entityAIConnection = RunService.Heartbeat:Connect(function(dt)
			if not hasEntitySpawned then return end

            if not (entity and entity.Parent and entityHumanoid and entityHumanoid.Health > 0) then
                if chaseSound and chaseSound.IsPlaying then chaseSound:Stop() end
                if entityAIConnection then entityAIConnection:Disconnect(); entityAIConnection = nil end
                return
            end

            local playerChar = localPlayer.Character
            if not (playerChar and playerChar.Parent) then
                 if chaseSound and chaseSound.IsPlaying then chaseSound:Stop() end
                 return
            end

            local playerHRP = playerChar:FindFirstChild("HumanoidRootPart")
            local playerHumanoid = playerChar:FindFirstChildWhichIsA("Humanoid")
             if not (playerHRP and playerHumanoid and playerHumanoid.Health > 0) then
                 if chaseSound and chaseSound.IsPlaying then chaseSound:Stop() end
                 return
            end

            if not (hrp and entityHumanoid) then return end


			local targetPosition = playerHRP.Position
			local entityPosition = hrp.Position
			entityHumanoid:MoveTo(targetPosition)

			local distance = (targetPosition - entityPosition).Magnitude
			local redOverlayTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			if distance < 50 then
                if workspaceCamera then
                    if workspaceCamera.FieldOfView < 85 then
                        TweenService:Create(workspaceCamera, TweenInfo.new(0.5), {FieldOfView = 90}):Play()
                    end
                end
				if playerHumanoid.WalkSpeed ~= 24 and not isPlayerSlowed then
					playerHumanoid.WalkSpeed = 24
				end
				if not runTextCooldown then
					displayOnScreenText("Run")
					runTextCooldown = true
                    task.delay(3, function() runTextCooldown = false end)
				end

				if isRedOverlayActive == false then
					isRedOverlayActive = true
                    if redOverlayFrame then
					    TweenService:Create(redOverlayFrame, redOverlayTweenInfo, {Transparency = 0.5}):Play()
                    end
				end

				if chaseSound and not chaseSound.IsPlaying then
                    if chaseSound.IsLoaded then chaseSound:Play() else warn("Chase sound not loaded or is nil!") end
				end

				if not isPlayerSlowed and slowWalkCooldown <= 0 and Random:NextNumber(0, 1) < (0.05 * dt * 60) then
					local originalSpeed = playerHumanoid.WalkSpeed
                    playerHumanoid.WalkSpeed = slowWalkSpeed
					isPlayerSlowed = true
					local slowDuration = Random:NextNumber(1, 2.5)
                    task.delay(slowDuration, function()
                        local currentCharacter = localPlayer.Character
                        if currentCharacter and currentCharacter.Parent then
                             local currentHumanoid = currentCharacter:FindFirstChildWhichIsA("Humanoid")
                             if currentHumanoid and currentHumanoid.Health > 0 and currentHumanoid.WalkSpeed == slowWalkSpeed then
                                  local currentHRP = currentCharacter:FindFirstChild("HumanoidRootPart")
                                  local currentEntity = Workspace:FindFirstChild("ScaryEntity")
                                  local currentEntityHRP = currentEntity and currentEntity:FindFirstChild("HumanoidRootPart")

                                  if currentHRP and currentEntityHRP then
                                      local currentDist = (currentHRP.Position - currentEntityHRP.Position).Magnitude
                                      if currentDist < 50 then
                                          currentHumanoid.WalkSpeed = 24
                                      else
                                           currentHumanoid.WalkSpeed = defaultWalkSpeed
                                      end
                                  else
                                       currentHumanoid.WalkSpeed = defaultWalkSpeed
                                  end
                             end
                        end
                        isPlayerSlowed = false
                    end)
					slowWalkCooldown = Random:NextNumber(3, 7)
				elseif slowWalkCooldown > 0 then
					slowWalkCooldown = math.max(0, slowWalkCooldown - dt)
				end

			else
				if isRedOverlayActive == true then
					isRedOverlayActive = false
                    if redOverlayFrame then
					    TweenService:Create(redOverlayFrame, redOverlayTweenInfo, {Transparency = 1}):Play()
                    end
				end
				if chaseSound and chaseSound.IsPlaying then chaseSound:Stop() end

                if workspaceCamera then
                    if workspaceCamera.FieldOfView > defaultFOV then
                        TweenService:Create(workspaceCamera, TweenInfo.new(1), {FieldOfView = defaultFOV}):Play()
                    end
                end
				if not isPlayerSlowed and playerHumanoid.WalkSpeed ~= defaultWalkSpeed then
					playerHumanoid.WalkSpeed = defaultWalkSpeed
				end
			end
		end)

		task.wait(1)
		hasEntitySpawned = true

		randomTextGUI.Enabled = true
        randomTextLabel.Visible = true
		while task.wait() do
            if not randomTextGUI.Parent then break end

			local randomIndex = Random:NextInteger(1, #creepyTexts)
			randomTextLabel.Text = creepyTexts[randomIndex]

			local regions = {
				{xMin = 0.1, xMax = 0.4, yMin = 0.1, yMax = 0.4},
				{xMin = 0.6, xMax = 0.9, yMin = 0.1, yMax = 0.4},
				{xMin = 0.1, xMax = 0.4, yMin = 0.6, yMax = 0.9},
				{xMin = 0.6, xMax = 0.9, yMin = 0.6, yMax = 0.9}
			}

			local randomRegionIndex = Random:NextInteger(1, #regions)
			local selectedRegion = regions[randomRegionIndex]

			local randomX = Random:NextNumber(selectedRegion.xMin, selectedRegion.xMax)
			local randomY = Random:NextNumber(selectedRegion.yMin, selectedRegion.yMax)

			randomTextLabel.Position = UDim2.new(randomX, 0, randomY, 0)

			print("Showing text:", creepyTexts[randomIndex], "at X:", randomX, "Y:", randomY, "Region:", randomRegionIndex)
			task.wait(3)
            if not randomTextLabel.Parent then break end
			randomTextLabel.Text = ""
			task.wait(3)
		end
	end)
end)

print("Troll Script Initialized")
