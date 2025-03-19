local card1 = _G["Card1Button"]  -- Получаем кнопку
local card2 = _G["Card2Button"]  -- Получаем кнопку
local card3 = _G["Card3Button"]  -- Получаем кнопку

local flipped1 = false
local flipped2 = false
local flipped3 = false

--	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00flipped1!|r") 
		
if card1 then
    if not card1.bg then
        card1.bg = card1:CreateTexture(nil, "BACKGROUND")
        card1.bg:SetAllPoints(card1) 
    end
    
	card1.bg:SetTexture("Interface\\AddOns\\PalaceOfAssassins\\textures\\contract for murder.tga")

	-- Создаем анимационную группу
    local animGroup = card1:CreateAnimationGroup()
	
    -- 1. Этап: Сужение карты (эффект переворота)
    local scaleOut = animGroup:CreateAnimation("Scale")
    scaleOut:SetDuration(0.25)  -- Время уменьшения
    scaleOut:SetScale(0.1, 1)   -- Сжимаем только по ширине
    scaleOut:SetOrigin("CENTER", 0, 0)

	-- 2. Этап: Смена текстуры (происходит в момент полной узкой карты)
    local textureSwitch = animGroup:CreateAnimation("Alpha")
    textureSwitch:SetDuration(0)  -- Мгновенная смена
    textureSwitch:SetStartDelay(0.25)  -- Ждем, пока карта уменьшится
    textureSwitch:SetScript("OnPlay", function() 
		-- Переключаем текстуры после завершения анимации
        if flipped1 then
			card1.bg:SetTexture("Interface\\AddOns\\PalaceOfAssassins\\textures\\contract for murder.tga")
		else
			card1.bg:SetTexture("Interface\\AddOns\\PalaceOfAssassins\\textures\\card.tga")
		end
		flipped1 = not flipped1  -- Меняем состояние карты
    end)
	
	-- 3. Этап: Возвращение карты в нормальный размер
    local scaleIn = animGroup:CreateAnimation("Scale")
    scaleIn:SetDuration(0.25)  -- Время увеличения
    scaleIn:SetScale(10, 1)    -- Увеличиваем только по ширине обратно
    scaleIn:SetOrigin("CENTER", 0, 0)
    scaleIn:SetStartDelay(0.25)  -- Запускаем после смены текстуры

    card1:SetScript("OnClick", function(self)
		animGroup:Play()
    end)
end
			
if card2 then
    if not card2.bg then
        card2.bg = card2:CreateTexture(nil, "BACKGROUND")
        card2.bg:SetAllPoints(card2) 
    end
    
	card2.bg:SetTexture("Interface\\AddOns\\PalaceOfAssassins\\textures\\guild of alientors.tga")

	-- Создаем анимационную группу
    local animGroup = card2:CreateAnimationGroup()
	
    -- 1. Этап: Сужение карты (эффект переворота)
    local scaleOut = animGroup:CreateAnimation("Scale")
    scaleOut:SetDuration(0.25)  -- Время уменьшения
    scaleOut:SetScale(0.1, 1)   -- Сжимаем только по ширине
    scaleOut:SetOrigin("CENTER", 0, 0)

	-- 2. Этап: Смена текстуры (происходит в момент полной узкой карты)
    local textureSwitch = animGroup:CreateAnimation("Alpha")
    textureSwitch:SetDuration(0)  -- Мгновенная смена
    textureSwitch:SetStartDelay(0.25)  -- Ждем, пока карта уменьшится
    textureSwitch:SetScript("OnPlay", function() 
		-- Переключаем текстуры после завершения анимации
        if flipped2 then
			card2.bg:SetTexture("Interface\\AddOns\\PalaceOfAssassins\\textures\\guild of alientors.tga")
		else
			card2.bg:SetTexture("Interface\\AddOns\\PalaceOfAssassins\\textures\\card.tga")
		end
		flipped2 = not flipped2  -- Меняем состояние карты
    end)
	
	-- 3. Этап: Возвращение карты в нормальный размер
    local scaleIn = animGroup:CreateAnimation("Scale")
    scaleIn:SetDuration(0.25)  -- Время увеличения
    scaleIn:SetScale(10, 1)    -- Увеличиваем только по ширине обратно
    scaleIn:SetOrigin("CENTER", 0, 0)
    scaleIn:SetStartDelay(0.25)  -- Запускаем после смены текстуры

    card2:SetScript("OnClick", function(self)
		animGroup:Play()
    end)
end		
	
if card3 then
    if not card3.bg then
        card3.bg = card3:CreateTexture(nil, "BACKGROUND")
        card3.bg:SetAllPoints(card3) 
    end
    
	card3.bg:SetTexture("Interface\\AddOns\\PalaceOfAssassins\\textures\\lord of territory.tga")

	-- Создаем анимационную группу
    local animGroup = card3:CreateAnimationGroup()
	
    -- 1. Этап: Сужение карты (эффект переворота)
    local scaleOut = animGroup:CreateAnimation("Scale")
    scaleOut:SetDuration(0.25)  -- Время уменьшения
    scaleOut:SetScale(0.1, 1)   -- Сжимаем только по ширине
    scaleOut:SetOrigin("CENTER", 0, 0)

	-- 2. Этап: Смена текстуры (происходит в момент полной узкой карты)
    local textureSwitch = animGroup:CreateAnimation("Alpha")
    textureSwitch:SetDuration(0)  -- Мгновенная смена
    textureSwitch:SetStartDelay(0.25)  -- Ждем, пока карта уменьшится
    textureSwitch:SetScript("OnPlay", function() 
		-- Переключаем текстуры после завершения анимации
        if flipped3 then
			card3.bg:SetTexture("Interface\\AddOns\\PalaceOfAssassins\\textures\\lord of territory.tga")
		else
			card3.bg:SetTexture("Interface\\AddOns\\PalaceOfAssassins\\textures\\card.tga")
		end
		flipped3 = not flipped3  -- Меняем состояние карты
    end)
	
	-- 3. Этап: Возвращение карты в нормальный размер
    local scaleIn = animGroup:CreateAnimation("Scale")
    scaleIn:SetDuration(0.25)  -- Время увеличения
    scaleIn:SetScale(10, 1)    -- Увеличиваем только по ширине обратно
    scaleIn:SetOrigin("CENTER", 0, 0)
    scaleIn:SetStartDelay(0.25)  -- Запускаем после смены текстуры

    card3:SetScript("OnClick", function(self)
		animGroup:Play()
    end)
end


--Да, через аддон можно отследить, находится ли рядом определённый NPC. 
--Для этого используются API-функции WoW Lua, которые позволяют проверять 
--существ NPC в радиусе игрока.
local POA = _G["POA_Frame"]   

-- Третий этап
local trackedMobs = {  -- Список отслеживаемых мобов
    ["Карманник"] = 0, --16
    ["Бандит"] = 0, --8
    ["Морган Вымогатель"] = 0, --1
    ["Эрлан Драджмур"] = 0, --1
    ["Сурена Каледон"] = 0, --1
    ["Джек Мертвозуб"] = 0 --1
}

-- Первый этап
local trackedPhrase = "i am looking for the god of death..."
local targetNPC = "Мастер Матиас Шоу"  -- Задаем имя нужного NPC
local frame = CreateFrame("Frame")

frame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")  -- Проверяем, наводится ли игрок на NPC
frame:RegisterEvent("PLAYER_TARGET_CHANGED")  -- Проверяем, если игрок взял NPC в таргет
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")  -- Отслеживаем боевые события

frame:SetScript("OnEvent", function(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _, subEvent, _, _, _, _, _, destGUID, destName = CombatLogGetCurrentEventInfo()
        if subEvent == "UNIT_DIED" and destName and trackedMobs[destName] then
			trackedMobs[destName] = trackedMobs[destName] + 1
			print("|cff00ff00Ты убил " .. destName .. "! Всего: " .. trackedMobs[destName] .. "|r")
        end
    elseif event == "PLAYER_TARGET_CHANGED" or event == "UPDATE_MOUSEOVER_UNIT" then
        local name = UnitName("target")  -- Получаем имя юнита
		if name and name == targetNPC then
			print("|cff00ff00Первый этап завершен!|r")
		end
    end
end)

-- Второй этап
SLASH_POA1 = "/poa"  -- Создаём команду /poa I am looking for the god of death...

-- Функция обработки команды
SlashCmdList["POA"] = function(msg)
    local name = UnitName("target")  -- Получаем имя юнита
    if msg and msg ~= "" then
		local str = msg:lower()
		if name and name == targetNPC and str == trackedPhrase then
			print("|cff00ff00Второй этап завершен!|r")
		else
			print("..." .. targetNPC .. " странно поглядывает на тебя.")
		end
    end
end


--[[
​В мире World of Warcraft есть скрытые предметы, связанные с темами смерти и богов, которые можно найти без необходимости сражаться с врагами. Один из таких предметов — Книга мёртвых. Эта книга расположена в Сумеречном лесу (Duskwood) в локации Сумеречный монастырь (Twilight Grove). Она лежит на полу рядом с разрушенным алтарём и содержит записи о древних богах и ритуалах, связанных со смертью.​

Другой интересный предмет — Табличка Йогг-Сарона, спрятанная в подземелье Ульдуар. Эта табличка содержит надписи, связанные с древним богом Йогг-Сароном, известным как «Бог Смерти» в лоре игры. Чтобы найти её, необходимо исследовать боковые комнаты в зале Йогг-Сарона.​

Также стоит отметить Книгу забытой тьмы, спрятанную в локации Лес Тероккар (Terokkar Forest). Эта книга находится в руинах Аукиндона и содержит тексты о древних богах и обрядах, связанных со смертью.​

Эти предметы не требуют сражений для их получения и предоставляют интересные сведения о лоре игры, связанных с темами смерти и богов.
]]