-- UNIVERSAL SCRIPT BY ARTAR
-- Стиль: Черно-белый (ЧБ)

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Переменные
local speedValue = 16
local isShiftPressed = false
local infiniteJumpEnabled = true

-- 1. Создание основного интерфейса (ЧБ стиль)
local gui = Instance.new("ScreenGui")
gui.Name = "ArtarUniversalUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Главная рамка (черная с белой обводкой)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 200)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Можно перетаскивать мышкой
mainFrame.Parent = gui

-- Обводка рамки (белая)
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 1
stroke.Parent = mainFrame

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.Text = "UNIVERSAL MENU"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = mainFrame

-- Текст: Speed Limit
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 0, 20)
speedLabel.Position = UDim2.new(0, 0, 0, 40)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.Text = "Speed Limit (16-500):"
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextSize = 12
speedLabel.Parent = mainFrame

-- Поле ввода скорости (TextBox)
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0, 180, 0, 30)
speedBox.Position = UDim2.new(0, 20, 0, 65)
speedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.PlaceholderText = "Enter speed (e.g. 100)"
speedBox.Text = "16"
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 14
speedBox.Parent = mainFrame

-- Логика ввода скорости
speedBox.FocusLost:Connect(function()
	local num = tonumber(speedBox.Text)
	if num then
		if num > 500 then num = 500 end
		if num < 16 then num = 16 end
		speedValue = num
		speedBox.Text = tostring(num)
	else
		speedBox.Text = tostring(speedValue)
	end
end)

-- Кнопка Infinite Jump (Toggle)
local jumpBtn = Instance.new("TextButton")
jumpBtn.Size = UDim2.new(0, 180, 0, 35)
jumpBtn.Position = UDim2.new(0, 20, 0, 110)
jumpBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
jumpBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
jumpBtn.Text = "Infinite Jump: ON"
jumpBtn.Font = Enum.Font.GothamBold
jumpBtn.TextSize = 14
jumpBtn.Parent = mainFrame

jumpBtn.MouseButton1Click:Connect(function()
	infiniteJumpEnabled = not infiniteJumpEnabled
	if infiniteJumpEnabled then
		jumpBtn.Text = "Infinite Jump: ON"
		jumpBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		jumpBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
	else
		jumpBtn.Text = "Infinite Jump: OFF"
		jumpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		jumpBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
	end
end)

-- Информация о Shift
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 0, 20)
infoLabel.Position = UDim2.new(0, 0, 0, 150)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
infoLabel.Text = "Hold [SHIFT] to use Speed"
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 11
infoLabel.Parent = mainFrame

-- Подпись "by artar"
local signature = Instance.new("TextLabel")
signature.Size = UDim2.new(1, 0, 0, 15)
signature.Position = UDim2.new(0, 0, 1, -18)
signature.BackgroundTransparency = 1
signature.TextColor3 = Color3.fromRGB(150, 150, 150)
signature.Text = "by artar"
signature.Font = Enum.Font.Gotham
signature.TextSize = 10
signature.Parent = mainFrame

-- 2. Логика работы скрипта (Бесконечный прыжок и скорость)

-- Отслеживание нажатия Shift
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
		isShiftPressed = true
	end
end)

UIS.InputEnded:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
		isShiftPressed = false
	end
end)

-- Бесконечный прыжок
UIS.JumpRequest:Connect(function()
	if infiniteJumpEnabled then
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)

-- Изменение скорости (работает только когда зажат Shift)
RunService.RenderStepped:Connect(function()
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if isShiftPressed then
				humanoid.WalkSpeed = speedValue
			else
				humanoid.WalkSpeed = 16 -- Стандартная скорость, когда Shift отпущен
			end
		end
	end
end)
