local PANEL = {}

function PANEL:Init()
    self:SetText("")
    self.labelText = ""
end

function PANEL:SetLabelText(text)
    self.labelText = text
end

function PANEL:Paint(w, h)
    local butCol = Motoess.GetNVGColor()

    local bgColor = self:IsHovered() and Color(22, 22, 22) or Color(41, 41, 41)
    draw.RoundedBox(0, 0, 0, w, h, bgColor)
    draw.RoundedBox(0, 0, 0, w, h * 0.05, butCol)

    local prefix = "Color "
    local name = self.labelText:sub(#prefix + 1)

    surface.SetFont("motoess_orbitron")
    local totalTextWidth, _ = surface.GetTextSize(prefix .. name)

    local textX = w / 2 - totalTextWidth / 2

    local textColor = Color(255, 255, 255)
    for _, config in pairs(Motoess.nightvisionConfigs) do
        if config.name == name then
            textColor = config.nvgindicatorcol
            break
        end
    end

    draw.SimpleText(self.labelText, "motoess_orbitron", textX, h / 2, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    draw.SimpleText(name, "motoess_orbitron", textX + surface.GetTextSize(prefix), h / 2, textColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

vgui.Register("Motoess.NVGButton", PANEL, "DButton")

local EXTRAS = {}

function EXTRAS:Init()
    self:SetText("")
    self.labelText = ""
end

function EXTRAS:SetLabelText(text)
    self.labelText = text
end

vgui.Register("Motoess.NVGButton.EXTRAS", EXTRAS, "DButton")