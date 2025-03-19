local function LoadTopSectionTextures()
    if TopFrame1Texture then
        TopFrame1Texture:SetTexture("Interface\\AddOns\\PalaceOfAssassins\\textures\\card.tga")
    end
    if TopFrame2Texture then
        TopFrame2Texture:SetTexture("Interface\\AddOns\\PalaceOfAssassins\\textures\\card.tga")
    end
    if TopFrame3Texture then
        TopFrame3Texture:SetTexture("Interface\\AddOns\\PalaceOfAssassins\\textures\\card.tga")
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", LoadTopSectionTextures)
