-- UNIVERSAL SCRIPT BY ARTAR
-- Стиль: Черно-белый (ЧБ) с плавными углами

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Переменные
local speedValue = 45
local isShiftPressed = false
local infiniteJumpEnabled = false
local isMinimized = false
local isClosed = false -- Состояние: меню закрыто

-- 1. Создание основного интерфейса (ЧБ стиль)
local gui = Instance.new("ScreenGui")
gui.Name = "ArtarUniversalUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- ===== КНОПКА ОТКРЫТИЯ МЕНЮ (появляется, когда меню закрыто) =====
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 20, 0.5, -25)
openBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Text = "⚙"
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 24
openBtn.BorderSizePixel = 0
openBtn.Visible = false -- Изначально скрыта
openBtn.Parent = gui

-- Закругленные углы для кнопки открытия
local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 10)
openCorner.Parent = openBtn

-- Обводка для кнопки открытия
local openStroke = Instance.new("UIStroke")
openStroke.Color = Color3.fromRGB(255, 255, 255)
openStroke.Thickness = 1
openStroke.Parent = openBtn

-- ===== ГЛАВНОЕ МЕНЮ =====
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 210)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -105)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

-- Закругленные углы
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

-- Обводка
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 1
stroke.Parent = mainFrame

-- Верхняя панель
local topPanel = Instance.new("Frame")
topPanel.Size = UDim2.new(1, 0, 0, 30)
topPanel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
topPanel.BorderSizePixel = 0
topPanel.Parent = mainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 10)
topCorner.Parent = topPanel

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.Text = "UNIVERSAL MENU"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topPanel

-- Кнопка сворачивания (—)
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -60, 0, 0)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
minimizeBtn.Text = "—"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.Parent = topPanel

-- Кнопка закрытия (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = topPanel

-- Контейнер для контента
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, -30)
contentFrame.Position = UDim2.new(0, 0, 0, 30)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Текст: Speed Limit
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 0, 20)
speedLabel.Position = UDim2.new(0, 0, 0, 10)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.Text = "Speed Limit (16-500):"
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextSize = 12
speedLabel.Parent = contentFrame

-- Поле ввода скорости
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0, 180, 0, 30)
speedBox.Position = UDim2.new(0, 20, 0, 35)
speedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.PlaceholderText = "Enter speed"
speedBox.Text = tostring(speedValue)
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 14
speedBox.BorderSizePixel = 0
speedBox.Parent = contentFrame

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 6)
boxCorner.Parent = speedBox

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

-- Кнопка Infinite Jump
local jumpBtn = Instance.new("TextButton")
jumpBtn.Size = UDim2.new(0, 180, 0, 35)
jumpBtn.Position = UDim2.new(0, 20, 0, 80)
jumpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
jumpBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
jumpBtn.Text = "Infinite Jump: OFF"
jumpBtn.Font = Enum.Font.GothamBold
jumpBtn.TextSize = 14
jumpBtn.BorderSizePixel = 0
jumpBtn.Parent = contentFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = jumpBtn

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
infoLabel.Position = UDim2.new(0, 0, 0, 120)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
infoLabel.Text = "Hold [SHIFT] to use Speed"
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 11
infoLabel.Parent = contentFrame

-- Подпись "by artar"
local signature = Instance.new("TextLabel")
signature.Size = UDim2.new(1, 0, 0, 15)
signature.Position = UDim2.new(0, 0, 1, -18)
signature.BackgroundTransparency = 1
signature.TextColor3 = Color3.fromRGB(150, 150, 150)
signature.Text = "by artar"
signature.Font = Enum.Font.Gotham
signature.TextSize = 10
signature.Parent = contentFrame

-- ===== ЛОГИКА СВОРАЧИВАНИЯ =====
minimizeBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	if isMinimized then
		contentFrame.Visible = false
		mainFrame.Size = UDim2.new(0, 220, 0, 30)
		minimizeBtn.Text = "+"
	else
		contentFrame.Visible = true
		mainFrame.Size = UDim2.new(0, 220, 0, 210)
		minimizeBtn.Text = "—"
	end
end)

-- ===== ЛОГИКА ЗАКРЫТИЯ МЕНЮ (полное отключение функций) =====
closeBtn.MouseButton1Click:Connect(function()
	isClosed = true
	mainFrame.Visible = false -- Скрываем меню
	openBtn.Visible = true -- Показываем кнопку открытия
	
	-- ОТКЛЮЧАЕМ ВСЕ ФУНКЦИИ
	infiniteJumpEnabled = false
	isShiftPressed = false
	
	-- Возвращаем скорость к стандартной
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = 16
		end
	end
	
	-- Сбрасываем визуал кнопки джампа
	jumpBtn.Text = "Infinite Jump: OFF"
	jumpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	jumpBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
end)

-- ===== ЛОГИКА ОТКРЫТИЯ МЕНЮ =====
openBtn.MouseButton1Click:Connect(function()
	isClosed = false
	mainFrame.Visible = true
	openBtn.Visible = false
	-- Разворачиваем меню до полного размера
	isMinimized = false
	contentFrame.Visible = true
	mainFrame.Size = UDim2.new(0, 220, 0, 210)
	minimizeBtn.Text = "—"
end)

-- ===== 2. ЛОГИКА РАБОТЫ ФУНКЦИЙ (с проверкой isClosed) =====

-- Отслеживание Shift
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed or isClosed then return end -- Не работает, если меню закрыто
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
	if infiniteJumpEnabled and not isClosed then -- Не работает, если меню закрыто
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)

-- Изменение скорости
RunService.RenderStepped:Connect(function()
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			-- Если меню закрыто ИЛИ Shift не зажат -> стандартная скорость
			if isClosed or not isShiftPressed then
				humanoid.WalkSpeed = 16
			else
				humanoid.WalkSpeed = speedValue
			end
		end
	end
end)
