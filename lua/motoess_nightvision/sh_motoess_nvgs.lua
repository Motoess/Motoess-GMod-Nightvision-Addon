Motoess.VersionName = "NVGs_V5"

Motoess.nightvisionConfigs = {
    [1] = {
        name = "Green",
        nvgindicatorcol = Color(100, 255, 100, 150),
        ["$pp_colour_brightness"] = 0.01,
        ["$pp_colour_contrast"] = 1.5,
        ["$pp_colour_colour"] = 1,
        ["$pp_colour_addr"] = -1,
        ["$pp_colour_addg"] = 0,
        ["$pp_colour_addb"] = -1,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    },
    [2] = {
        name = "Blue",
        nvgindicatorcol = Color(100, 255, 255, 150),
        ["$pp_colour_brightness"] = 0.6,
        ["$pp_colour_contrast"] = 0.6,
        ["$pp_colour_colour"] = 0.15,
        ["$pp_colour_addr"] = -1,
        ["$pp_colour_addg"] = -0.6,
        ["$pp_colour_addb"] = 0.2,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    },
    [3] = {
        name = "Red",
        nvgindicatorcol = Color(255, 100, 100, 150),
        ["$pp_colour_brightness"] = 0.6,
        ["$pp_colour_contrast"] = 1,
        ["$pp_colour_colour"] = 0.15,
        ["$pp_colour_addr"] = 0.2,
        ["$pp_colour_addg"] = -1,
        ["$pp_colour_addb"] = -1,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    },
    [4] = {
        name = "Cyan",
        nvgindicatorcol = Color(150, 255, 255, 150),
        ["$pp_colour_brightness"] = 0.4,
        ["$pp_colour_contrast"] = 0.6,
        ["$pp_colour_colour"] = 0.15,
        ["$pp_colour_addr"] = -1,
        ["$pp_colour_addg"] = 0.1,
        ["$pp_colour_addb"] = 0,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    },
    [5] = {
        name = "Yellow",
        nvgindicatorcol = Color(253, 255, 150, 150),
        ["$pp_colour_brightness"] = 0.4,
        ["$pp_colour_contrast"] = 0.6,
        ["$pp_colour_colour"] = 0.25,
        ["$pp_colour_addr"] = -(1 - 253 / 255) * 1.5,
        ["$pp_colour_addg"] = -(1 - 255 / 255) * 1.5,
        ["$pp_colour_addb"] = -(1 - 150 / 255) * 1.5,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    },
    [6] = {
        name = "Orange",
        nvgindicatorcol = Color(255, 166, 0, 150),
        ["$pp_colour_brightness"] = 0.9,
        ["$pp_colour_contrast"] = 0.6,
        ["$pp_colour_colour"] = 0.25,
        ["$pp_colour_addr"] = -(1 - 255 / 255) * 1.5,
        ["$pp_colour_addg"] = -(1 - 94 / 255) * 1.5,
        ["$pp_colour_addb"] = -(1 - 0 / 255) * 1.5,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    },
    [7] = {
        name = "Purple",
        nvgindicatorcol = Color(204, 150, 255, 150),
        ["$pp_colour_brightness"] = 0.4,
        ["$pp_colour_contrast"] = 0.6,
        ["$pp_colour_colour"] = 0.25,
        ["$pp_colour_addr"] = -(1 - 204 / 255) * 1.5,
        ["$pp_colour_addg"] = -(1 - 150 / 255) * 1.5,
        ["$pp_colour_addb"] = -(1 - 255 / 255) * 1.5,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    },
    [8] = {
        name = "Hot Pink",
        nvgindicatorcol = Color(255, 71, 200, 150),
        ["$pp_colour_brightness"] = 0.7,
        ["$pp_colour_contrast"] = 0.6,
        ["$pp_colour_colour"] = 0.25,
        ["$pp_colour_addr"] = -(1 - 255 / 255) * 1.5,
        ["$pp_colour_addg"] = -(1 - 71 / 255) * 1.5,
        ["$pp_colour_addb"] = -(1 - 172 / 255) * 1.5,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    },
    [9] = {
        name = "Crystal - Ur weird if u use this",
        nvgindicatorcol = Color(255, 255, 255, 150),
        ["$pp_colour_brightness"] = 0.2,
        ["$pp_colour_contrast"] = 0.4,
        ["$pp_colour_colour"] = 2,
        ["$pp_colour_addr"] = -(1 - 255 / 255) * 1.5,
        ["$pp_colour_addg"] = -(1 - 255 / 255) * 1.5,
        ["$pp_colour_addb"] = -(1 - 255 / 255) * 1.5,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    }
}

function Motoess.GetNVGColor()
    local rgbspeed = 20
    local hudColor = GetConVar("motus_nightvision_color"):GetInt()

    if hudColor >= 1 and hudColor <= #Motoess.nightvisionConfigs then
        local config = Motoess.nightvisionConfigs[hudColor]
        local nvgColor = config.nvgindicatorcol

        if IsColor(nvgColor) then
            return nvgColor
        else
            return Motoess.nightvisionConfigs[1].nvgindicatorcol
        end
    /*elseif hudColor == 7 then
        local rgbcolorshift = HSVToColor((CurTime() * rgbspeed) % 360, 1, 1)
        return rgbcolorshift*/
    else
        return Motoess.nightvisionConfigs[1].nvgindicatorcol
    end
end

function Motoess.GetColorTab()
    local colorIndex = GetConVar("motus_nightvision_color"):GetInt()

    local config = Motoess.nightvisionConfigs[colorIndex]
    if not config then
        --print("[Motoess] Invalid col:", colorIndex)
        config = Motoess.nightvisionConfigs[1]
    end

    return config
end
