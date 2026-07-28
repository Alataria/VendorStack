local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")

local BUTTON_WIDTH = 100
local BUTTON_HEIGHT = 22
local PANEL_PADDING = 10

frame:SetScript("OnEvent", function(self, event, addonName)
    if StackSplitFrame and not StackSplitFrame.buyStackButton then

        local panel = CreateFrame("Frame", "StackSplitBuyStackPanel", StackSplitFrame, "BackdropTemplate")
        panel:SetPoint("TOPLEFT", StackSplitFrame, "BOTTOMLEFT", 0, 1)
        panel:SetPoint("TOPRIGHT", StackSplitFrame, "BOTTOMRIGHT", 0, 1)
        panel:SetHeight(BUTTON_HEIGHT + (PANEL_PADDING * 2))
        panel:SetFrameStrata(StackSplitFrame:GetFrameStrata())

        panel:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true, tileSize = 16, edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 },
        })
        panel:SetBackdropColor(0, 0, 0, 0.9)
        panel:SetBackdropBorderColor(0.55, 0.47, 0.3, 1)

        local btn = CreateFrame("Button", "StackSplitBuyStackButton", panel, "UIPanelButtonTemplate")
        btn:SetSize(BUTTON_WIDTH, BUTTON_HEIGHT)
        btn:SetPoint("CENTER", panel, "CENTER", 0, 0)
        btn:SetText("Buy Stack")

        btn:SetScript("OnClick", function()
            if StackSplitFrame.owner and StackSplitFrame.owner:GetParent() then
                local itemButton = StackSplitFrame.owner
                local id = itemButton:GetID()

                if id and GetMerchantItemLink(id) then
                    local link = GetMerchantItemLink(id)
                    local _, _, _, _, _, _, _, maxStack = GetItemInfo(link)
                    maxStack = maxStack or 1

                    if maxStack > 1 then
                        BuyMerchantItem(id, maxStack)
                    else
                        BuyMerchantItem(id, 1)
                    end

                end
            end
        end)

        StackSplitFrame.buyStackButton = btn
        StackSplitFrame.buyStackPanel = panel
    end
end)