local frame = CreateFrame("Button", "DragFrame2", UIParent)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    -- The code below makes the frame visible, and is not necessary to enable dragging.
    frame:SetPoint("CENTER"); frame:SetWidth(64); frame:SetHeight(64);
local tex = frame:CreateTexture("ARTWORK");
    tex:SetAllPoints();
    --tex:SetHighlightTexture("Interface/Minimap/UI-Minimap-ZoomButton-Highlight")
    tex:SetTexture("Interface\\Icons\\Inv_misc_bone_skull_01")
    tex:SetMask("Interface/COMMON/Indicator-Yellow.png")
    tex:SetAlpha(0.5);

local button = CreateFrame("Button", "AuM", UIParent, "SecureActionButtonTemplate");
    button:SetPoint("CENTER", 50)
    button:SetSize(250, 50);
    button:SetMovable(true);
    button:EnableMouse(true);
    
    button:RegisterForDrag("LeftButton")
    button:SetScript("OnDragStart", frame.StartMoving)
    button:SetScript("OnDragStop", frame.StopMovingOrSizing)

    button:SetScript("OnMouseDown", function(self, btn)
        if btn == "RightButton" then
            button:Hide();
        end
    end)

local ntex = button:CreateTexture()
    ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
    ntex:SetTexCoord(0, 0.625, 0, 0.6875)
    ntex:SetAllPoints()	
button:SetNormalTexture(ntex)
button:Hide();
frame:SetScript("OnClick", function()
    Run()
end)

function Run()
    local timeSpanHour = 6;
    local timeSpanMin = 40;
    local baseDay = 12;

    local hour, minute = GetGameTime()
    local day = date("%d")
    local currentTimeInMin = (day*60*60) + (hour*60) + minute;

    local boss = 
        {
            [1]  = { ["name"] = "Skadi the Ruthless",           ["coorX"] = "57,8",     ["coorY"] = "56,1", ["day"] =  12, ["hour"] = 17, ["min"] = 40},
            [2]  = { ["name"] = "Ingvar the Plunderer",         ["coorX"] = "52,4",     ["coorY"] = "52,6", ["day"] =  12, ["hour"] = 18, ["min"] = 0},
            [3]  = { ["name"] = "Prince Keleseth",              ["coorX"] = "54,0",     ["coorY"] = "44,7", ["day"] =  12, ["hour"] = 18, ["min"] = 20},
            [4]  = { ["name"] = "The Black Knight",             ["coorX"] = "64,8",     ["coorY"] = "22,1", ["day"] =  12, ["hour"] = 18, ["min"] = 40},
            [5]  = { ["name"] = "Bronjahm",                     ["coorX"] = "70,7",     ["coorY"] = "38,4", ["day"] =  12, ["hour"] = 19, ["min"] = 0},
            [6]  = { ["name"] = "Scourgelord Tyrannus",         ["coorX"] = "47,2",     ["coorY"] = "66,1", ["day"] =  12, ["hour"] = 19, ["min"] = 20},
            [7]  = { ["name"] = "Forgemaster Garfrost",         ["coorX"] = "58,6",     ["coorY"] = "72,5", ["day"] =  12, ["hour"] = 19, ["min"] = 40},
            [8]  = { ["name"] = "Marwyn",                       ["coorX"] = "58,2",     ["coorY"] = "83,4", ["day"] =  12, ["hour"] = 20, ["min"] = 0},
            [9]  = { ["name"] = "Falric",                       ["coorX"] = "50,2",     ["coorY"] = "87,9", ["day"] =  12, ["hour"] = 20, ["min"] = 20},
            [10] = { ["name"] = "The Prophet Tharon'ja",        ["coorX"] = "80,1",     ["coorY"] = "61,2", ["day"] =  12, ["hour"] = 20, ["min"] = 40},
            [11] = { ["name"] = "Novos the Summoner",           ["coorX"] = "77,8",     ["coorY"] = "66,1", ["day"] =  12, ["hour"] = 21, ["min"] = 0},
            [12] = { ["name"] = "Trollgore",                    ["coorX"] = "58,3",     ["coorY"] = "39,4", ["day"] =  12, ["hour"] = 21, ["min"] = 20},
            [13] = { ["name"] = "Krik'thir the Gatewatcher",    ["coorX"] = "67,5",     ["coorY"] = "58,0", ["day"] =  12, ["hour"] = 21, ["min"] = 40},
            [14] = { ["name"] = "Prince Taldaram",              ["coorX"] = "29,6",     ["coorY"] = "62,2", ["day"] =  12, ["hour"] = 22, ["min"] = 0},
            [15] = { ["name"] = "Elder Nadox",                  ["coorX"] = "44,2",     ["coorY"] = "49,1", ["day"] =  12, ["hour"] = 22, ["min"] = 20},
            [16] = { ["name"] = "Noth the Plaguebringer",       ["coorX"] = "31,6",     ["coorY"] = "70,5", ["day"] =  12, ["hour"] = 22, ["min"] = 40},
            [17] = { ["name"] = "Patchwerk",                    ["coorX"] = "36,5",     ["coorY"] = "67,4", ["day"] =  12, ["hour"] = 23, ["min"] = 0},
            [18] = { ["name"] = "Blood Queen Lana'thel",        ["coorX"] = "49,7",     ["coorY"] = "32,7", ["day"] =  12, ["hour"] = 23, ["min"] = 20},
            [19] = { ["name"] = "Professor Putricide",          ["coorX"] = "57,1",     ["coorY"] = "30,3", ["day"] =  12, ["hour"] = 23, ["min"] = 40},
            [20] = { ["name"] = "Lady Deathwhisper",            ["coorX"] = "51,1",     ["coorY"] = "78,5", ["day"] =  13, ["hour"] = 0, ["min"] = 0}
        };


    for id, item in pairs(boss) do
        local bossDay = item.day;
        local bossHour = item.hour;
        local bossMin = item.min;
        local found = false;

        for i = 1, 10 do
            bossMin = bossMin + timeSpanMin
            bossHour = bossHour + timeSpanHour

            if bossMin >= 60 then
                bossMin = bossMin - 60
                bossHour = bossHour + 1
            end
            if bossHour >= 24 then
                bossHour = bossHour - 24
                bossDay = bossDay + 1
            end
            bossTimeInMin = (bossDay*60*60) + (bossHour*60) + bossMin

            if (bossTimeInMin - currentTimeInMin <= 20 and bossTimeInMin - currentTimeInMin >= 0) then
                found = true
                break
            end
        end
        if (found==true) then
            bossHourText = bossHour
            bossMinText = bossMin
            if bossHour == 0 then
                bossHourText = "00"
            end
            if bossMin == 0 then
                bossMinText = "00"
            end
            local macroText = "/way "..item.coorX..", "..item.coorY.." "..item.name.." ( "..bossHourText..":"..bossMinText.." )"
            button:SetAttribute("type", "macro") 
            button:SetAttribute("macrotext", macroText);
            button:RegisterForClicks("LeftButtonUp");
            button:SetText(item.name.." ( "..bossHourText..":"..bossMinText.." )")
            button:SetNormalFontObject("GameFontHighlight")
            button:Show()
            break
        end
    end
end