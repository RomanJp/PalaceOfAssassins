-- Saved Variables
PalaceOfAssassinsDB = PalaceOfAssassinsDB or { hasViewedStory = false }

local function LoadTopSectionTextures()
    if CardFrame1Texture then
        CardFrame1Texture:SetTexture("Interface\\AddOns\\PalaceOfAssassins\\Textures\\Texture1")
    end
    if CardFrame2Texture then
        CardFrame2Texture:SetTexture("Interface\\AddOns\\PalaceOfAssassins\\Textures\\Texture2")
    end
    if CardFrame3Texture then
        CardFrame3Texture:SetTexture("Interface\\AddOns\\PalaceOfAssassins\\Textures\\Texture3")
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", LoadTopSectionTextures)
