--	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00flipped1!|r") 

PalaceOfAssassins = {}

local Status = {
    EMPTY = "EMPTY",
    FULL = "FULL"
}

local MissionType = {
    ASSASSINATION = "Убийство цели",
    ESPIONAGE = "Сбор информации",
    SABOTAGE = "Саботаж",
    RESCUE = "Спасательная операция",
    THEFT = "Кража",
    SEARCHING = "Поиск",
    INFILTRATION = "Проникновение",
    DEFENSE = "Оборона",
    ESCORT = "Сопровождение",
    ELIMINATION = "Уничтожение отряда",
    RECONNAISSANCE = "Разведка"
}

local TEXTURES = {
	rank0 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\icon_block.tga",
	rank1 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\1. Shadow.tga",
	rank2 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\2. Ghost.tga",
	rank3 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\3. Whisper.tga",
	rank4 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\4. Blade of Twilight.tga",
	rank5 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\5. Night Wanderer.tga",
	rank6 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\6. Darkness.tga",
	rank7 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\7. Faceless.tga",
	rank8 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\8. Shadow Dancer.tga",
	rank9 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\9. Black Raven.tga",
	rank10 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\10. Keeper of Darkness.tga",
	rank11 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\11. Lord of Darkness.tga",
	rank12 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\12. Reaper of Death.tga",
	rank13 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\13. God of Death.tga",
	bandits = "Interface\\AddOns\\PalaceOfAssassins\\textures\\bandits.tga",
	bookOfTheDead = "Interface\\AddOns\\PalaceOfAssassins\\textures\\book of the dead.tga",
	card = "Interface\\AddOns\\PalaceOfAssassins\\textures\\card.tga",
	contractForMurder = "Interface\\AddOns\\PalaceOfAssassins\\textures\\contract for murder.tga",
	excommunicado = "Interface\\AddOns\\PalaceOfAssassins\\textures\\excommunicado.tga",
	guildOfAlientors = "Interface\\AddOns\\PalaceOfAssassins\\textures\\guild of alientors.tga",
	lordOfTerritory = "Interface\\AddOns\\PalaceOfAssassins\\textures\\lord of territory.tga",
	masterMathiasShaw = "Interface\\AddOns\\PalaceOfAssassins\\textures\\master mathias shaw.tga",
	orgrimmarGuard = "Interface\\AddOns\\PalaceOfAssassins\\textures\\orgrimmar guard.tga",
	ripper = "Interface\\AddOns\\PalaceOfAssassins\\textures\\ripper.tga",
	skull2 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\skull2.tga",
	skull4 = "Interface\\AddOns\\PalaceOfAssassins\\textures\\skull4.tga",
	tabletOfYogg_saron = "Interface\\AddOns\\PalaceOfAssassins\\textures\\tablet of yogg_saron.tga",
	completed = "Interface\\AddOns\\PalaceOfAssassins\\textures\\completed.tga",
	testOfCourage = "Interface\\AddOns\\PalaceOfAssassins\\textures\\test of Courage.tga",
	thebookOfForgottenDarkness = "Interface\\AddOns\\PalaceOfAssassins\\textures\\the book of forgotten darkness.tga"
}

local POA = _G["POA_Main"]  
local card1 = _G["Card1Button"] 
local card2 = _G["Card2Button"]  -- Получаем кнопку
local card3 = _G["Card3Button"]  -- Получаем кнопку
local banner = _G["POA_Banner"]  -- Получаем кнопку 
local paper = _G["POA_Paper"] 
local paperRiddleText = _G["POA_PaperRiddleText"]	
local paperCoordinatesText = _G["POA_PaperCoordinatesText"]	
local complite1,complite2,complite3

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")  		-- Проверяем, наводится ли игрок на NPC
frame:RegisterEvent("PLAYER_TARGET_CHANGED")  		-- Проверяем, если игрок взял NPC в таргет
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")  -- Отслеживаем боевые события
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")  	-- Проверяем успешное использование предмета

frame:SetScript("OnEvent", function(self, event, unit, _, spellID)
	if event == "ADDON_LOADED" and unit == "PalaceOfAssassins" then
		-- Загружаем сохранённые данные при старте аддона
		PalaceOfAssassins:OnLoad()
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then	
		-- Третий этап
		local trackedMobs = {  -- Список отслеживаемых мобов
			["Карманник"] = 0, --16
			["Бандит"] = 0, --8
			["Морган Вымогатель"] = 0, --1
			["Эрлан Драджмур"] = 0, --1
			["Сурена Каледон"] = 0, --1
			["Джек Мертвозуб"] = 0 --1
		}
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
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
		if unit == "player" then  -- Проверяем только каст игрока
			local trackedItemID = 206002  -- ID Таблички Йогг-Сарона
			local itemName = GetItemInfo(trackedItemID)  -- Получаем имя предмета по ID
			if itemName and spellID and GetSpellInfo(spellID) == itemName then
				print("|cff00ff00Ты использовал " .. itemName .. "! Берегись последствий...|r")
			end
		end
    end
end)

-- Инициализация базы данных
function PalaceOfAssassins:OnLoad()
	POA:Hide()
	banner:Hide()
	paper:Hide()
	
	PalaceOfAssassinsDB.showPaper = true
	
	--print(PalaceOfAssassinsDB.missions[1].texture)
	
	if card1 then		
		if not card1.bg then	
			card1.bg = card1:CreateTexture(nil, "BACKGROUND")
			card1.bg:SetAllPoints(card1) 
		end
		
		card1.bg:SetTexture(PalaceOfAssassinsDB.missions[1].texture)

		-- Добавляем текстуру сверху
		complite1 = btn:CreateTexture(nil, "OVERLAY")
		complite1:SetTexture("Interface\\Icons\\INV_Sword_04")
		complite1:SetSize(32, 32)
		complite1:SetPoint("CENTER") -- Можно заменить на "TOP", "LEFT", и т.д.
		complite1:Hide()

		-- Создаем анимационную группу
		local animGroup = card1:CreateAnimationGroup()
		
		-- 1. Этап: Сужение карты (эффект переворота)
		local scaleOut = animGroup:CreateAnimation("Scale")
		scaleOut:SetDuration(0.25)  -- Время уменьшения
		scaleOut:SetScale(0.1, 1)   -- Сжимаем т олько по ширине
		scaleOut:SetOrigin("CENTER", 0, 0)

		-- 2. Этап: Смена текстуры (происходит в момент полной узкой карты)
		local textureSwitch = animGroup:CreateAnimation("Alpha")
		textureSwitch:SetDuration(0)  -- Мгновенная смена
		textureSwitch:SetStartDelay(0.25)  -- Ждем, пока карта уменьшится
		textureSwitch:SetScript("OnPlay", function() 
			-- Переключаем текстуры после завершения анимации
			if PalaceOfAssassinsDB.missions[1].flipped1 then
				card1.bg:SetTexture(PalaceOfAssassinsDB.missions[1].texture)
			else
				card1.bg:SetTexture(TEXTURES.card)
			end
			PalaceOfAssassinsDB.missions[1].flipped1 = not PalaceOfAssassinsDB.missions[1].flipped1  -- Меняем состояние карты
		end)
		
		-- 3. Этап: Возвращение карты в нормальный размер
		local scaleIn = animGroup:CreateAnimation("Scale")
		scaleIn:SetDuration(0.25)  -- Время увеличения
		scaleIn:SetScale(10, 1)    -- Увеличиваем только по ширине обратно
		scaleIn:SetOrigin("CENTER", 0, 0)
		scaleIn:SetStartDelay(0.25)  -- Запускаем после смены текстуры

		card1:SetScript("OnClick", function(self)
			if PalaceOfAssassinsDB.missions[1].isFinished then 
				animGroup:Play()
			end
		end)
	end	
	
	if card2 then		
		if not card2.bg then	
			card2.bg = card2:CreateTexture(nil, "BACKGROUND")
			card2.bg:SetAllPoints(card2) 
		end
		
		card2.bg:SetTexture(PalaceOfAssassinsDB.missions[2].texture)
		
		-- Добавляем текстуру сверху
		local complite = btn:CreateTexture(nil, "OVERLAY")
		complite:SetTexture("Interface\\Icons\\INV_Sword_04")
		complite:SetSize(50, 50)
		complite:SetPoint("CENTER") -- Можно заменить на "TOP", "LEFT", и т.д.

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
			if PalaceOfAssassinsDB.missions[2].flipped1 then
				card2.bg:SetTexture(PalaceOfAssassinsDB.missions[2].texture)
			else
				card2.bg:SetTexture(TEXTURES.card)
			end
			PalaceOfAssassinsDB.missions[2].flipped1 = not PalaceOfAssassinsDB.missions[2].flipped1  -- Меняем состояние карты
		end)
		
		-- 3. Этап: Возвращение карты в нормальный размер
		local scaleIn = animGroup:CreateAnimation("Scale")
		scaleIn:SetDuration(0.25)  -- Время увеличения
		scaleIn:SetScale(10, 1)    -- Увеличиваем только по ширине обратно
		scaleIn:SetOrigin("CENTER", 0, 0)
		scaleIn:SetStartDelay(0.25)  -- Запускаем после смены текстуры

		card2:SetScript("OnClick", function(self)
			if PalaceOfAssassinsDB.missions[2].isFinished then 
				animGroup:Play()
			end
		end)
	end
	
	if card3 then		
		if not card3.bg then	
			card3.bg = card3:CreateTexture(nil, "BACKGROUND")
			card3.bg:SetAllPoints(card3) 
		end
		
		card3.bg:SetTexture(PalaceOfAssassinsDB.missions[3].texture)

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
			if PalaceOfAssassinsDB.missions[3].flipped1 then
				card3.bg:SetTexture(PalaceOfAssassinsDB.missions[3].texture)
			else
				card3.bg:SetTexture(TEXTURES.card)
			end
			PalaceOfAssassinsDB.missions[3].flipped1 = not PalaceOfAssassinsDB.missions[3].flipped1  -- Меняем состояние карты
		end)
		
		-- 3. Этап: Возвращение карты в нормальный размер
		local scaleIn = animGroup:CreateAnimation("Scale")
		scaleIn:SetDuration(0.25)  -- Время увеличения
		scaleIn:SetScale(10, 1)    -- Увеличиваем только по ширине обратно
		scaleIn:SetOrigin("CENTER", 0, 0)
		scaleIn:SetStartDelay(0.25)  -- Запускаем после смены текстуры

		card3:SetScript("OnClick", function(self)
			if PalaceOfAssassinsDB.missions[3].isFinished then 
				animGroup:Play()
			end
		end)
	end	
	
	-- Устанавливаем большой текст
	local riddleText = "В мире, где свет и порядок живут,\n\nГде стены извечно город несут.\n\nГерои народ свой всегда защищают,\n\nОт зла и угроз его охраняют.\n\nЛьвы украшают знамена вокруг,\n\nВеликий бастион всех людских круг.\n\nКак город зовётся, что в грозах стоит,\n\nГде воля и доблесть, где меч не молчит?\n"
	local coordinatesText = "75.8,59.8"

	paperRiddleText:SetText(riddleText)			
	paperCoordinatesText:SetText(coordinatesText)

    if not PalaceOfAssassinsDB then
		local faction, localizedFaction = UnitFactionGroup("player") -- Получаем фракцию (Horde/Alliance)
		local name = UnitName("player") -- Имя игрока
		local server = GetRealmName() -- Сервер игрока
	
        PalaceOfAssassinsDB = {  -- Создаем базу данных, если ее нет
			rank = 0, -- Ранг игрока (число или строка)
			showPaper = true,
			all = {},
			isRecruit = true, -- Логическая переменная (true/false)
			player = { -- Вложенный объект
				faction = faction, 
				name = name, 
				server = server,
			},
			missions = {
				{ 
					isFinished = false,
					flipped1 = false,
					card = card1,
					status = Status.EMPTY,
					createdName = "",
					createdDate = "", -- os.date("%Y-%m-%d %H:%M:%S") 2025-03-11 14:30:45
					type = nil,  
					texture = TEXTURES.card 
				},
				{ 
					isFinished = false,
					flipped1 = false,
					card = card2,
					status = Status.EMPTY,
					createdName = "",
					createdDate = "", -- os.date("%Y-%m-%d %H:%M:%S") 2025-03-11 14:30:45
					type = nil,  
					texture = TEXTURES.card 
				},
				{ 
					isFinished = false,
					flipped1 = false,
					card = card3,
					status = Status.EMPTY,
					createdName = "",
					createdDate = "", -- os.date("%Y-%m-%d %H:%M:%S") 2025-03-11 14:30:45
					type = nil,  
					texture = TEXTURES.card 
				}
			}
		}
    end
	
	if PalaceOfAssassinsDB.showPaper then
		paper:Show()
	end
end

function PalaceOfAssassins:Start()
	POA:Show()
	
	PalaceOfAssassinsDB.showPaper = false
	
	-- создать первое задание найти Мастера Шоу 
	PalaceOfAssassinsDB.missions[1].texture = TEXTURES.masterMathiasShaw	
	
	--print(PalaceOfAssassinsDB.missions[1].texture)
	
	--[[
	missions[1].status = Status.FULL	
	missions[1].createdName = PalaceOfAssassinsDB.player.name .. "-" ..	PalaceOfAssassinsDB.player.server
	missions[1].type = MissionType.SEARCHING	
	missions[1].createdDate = os.date("%Y-%m-%d %H:%M:%S")
	
	CardPrepare(card1, missions[1].texture)
	]]
end

-- Первый этап
local targetNPC = "Мастер Матиас Шоу"  -- Задаем имя нужного NPC

-- Второй этап
SLASH_POA1 = "/poa"  -- Создаём команду /poa I am looking for the god of death...

-- Функция обработки команды
SlashCmdList["POA"] = function(msg)
    local name = UnitName("target")  -- Получаем имя юнита
	PlaySound(569518, "Master") -- Звук завершения задания
    if msg and msg ~= "" then	
		local str = msg:lower()		
		local trackedPhrase = "i am looking for the god of death..."	
		if str == trackedPhrase then		
			if name and name == targetNPC then
				print("|cff00ff00Второй этап завершен!|r")
			else
				print("..." .. targetNPC .. " странно поглядывает на тебя.")
			end	
		elseif str == "open" then
			POA:Show()
		elseif str == "banner" then
			banner:Show()
			banner:SetAlpha(1)
			
			UIFrameFade(banner, {
				mode = "OUT",
				timeToFade = 4,
				startAlpha = 1,
				endAlpha = 0,
				finishedFunc = function()
					banner:Hide() -- Полностью скрываем фрейм
				end,
			})
		end
    end
end

--[[
​В мире World of Warcraft есть скрытые предметы, связанные с темами смерти и богов, 
которые можно найти без необходимости сражаться с врагами. 

Один из таких предметов — Книга мёртвых. Эта книга расположена в Сумеречном лесу 
(Duskwood) в локации Сумеречный монастырь (Twilight Grove). Она лежит на полу рядом 
с разрушенным алтарём и содержит записи о древних богах и ритуалах, связанных со смертью.​

Другой интересный предмет — Табличка Йогг-Сарона, спрятанная в подземелье Ульдуар. 
Эта табличка содержит надписи, связанные с древним богом Йогг-Сароном, известным как 
«Бог Смерти» в лоре игры. Чтобы найти её, необходимо исследовать боковые комнаты в 
зале Йогг-Сарона.​

Также стоит отметить Книгу забытой тьмы, спрятанную в локации Лес Тероккар (Terokkar Forest). 
Эта книга находится в руинах Аукиндона и содержит тексты о древних богах и обрядах, 
связанных со смертью.​

Эти предметы не требуют сражений для их получения и предоставляют интересные сведения 
о лоре игры, связанных с темами смерти и богов.


При получении заданий использовать наратив "Хороший убийца должен уметь не только 
убивать, но и искать информацию. Хе-хе.. удачи парниша."
]]
