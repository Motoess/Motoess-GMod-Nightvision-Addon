local PANEL = {}

function PANEL:Init()
    local sw, sh = ScrW(), ScrH()

    self:SetSize(sw * 0.8, sh * 0.7)
    self:Center()
    self:SetTitle("")
    self:SetVisible(true)
    self:SetDraggable(false)
    self:ShowCloseButton(false)
    self:MakePopup()

    local swSelf, shSelf = self:GetWide(), self:GetTall()

    self.scrollPanel = vgui.Create("DScrollPanel", self)
    self.scrollPanel:SetSize(swSelf * 0.1, shSelf * 0.5)
    self.scrollPanel:Dock(TOP)
    --self.scrollPanel.Paint = function(s,w,h)
       -- draw.RoundedBox(0, 0, 0, w, h, Color(70, 70, 70, 99))
    --end

    self.listLayout = vgui.Create("DListLayout", self.scrollPanel)
    self.listLayout:Dock(FILL)

    self:CreateNVGColorMenu()

    local vbar = self.scrollPanel:GetVBar()
    vbar:SetWide(10)
    vbar:SetHideButtons(true)
    vbar.btnGrip.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 200))
    end
    vbar.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
    end

    local closeButton = vgui.Create("Motoess.NVGButton")
    closeButton:SetParent(self)
    closeButton:SetSize(swSelf * 0.1, shSelf * 0.05)
    closeButton:SetPos(swSelf * 0.88, shSelf * 0.925)
    closeButton:SetLabelText("C L O S E")
    closeButton.DoClick = function()
        self:Remove()
    end

    local nvgToggleButton = vgui.Create("Motoess.NVGButton.EXTRAS")
    nvgToggleButton:SetParent(self)
    nvgToggleButton:SetSize(swSelf * 0.075, shSelf * 0.05)
    nvgToggleButton:SetPos(swSelf * 0.465, shSelf * 0.925)
    nvgToggleButton:SetLabelText("Toggle")
    nvgToggleButton.DoClick = function()
        surface.PlaySound("garrysmod/ui_click.wav")
        RunConsoleCommand("motus_nightvision")
    end
    nvgToggleButton.Paint = function(s, w, h)
        local butCol = color_white
        local toggleText = ""

        if LocalPlayer():GetNWBool("MotoessNVGs") then
            butCol = Color(98, 202, 72)
            toggleText = "Enabled"
        else
            butCol = Color(202, 72, 72)
            toggleText = "Disabled"
        end

        local bgColor = s:IsHovered() and Color(22, 22, 22) or Color(41, 41, 41)
        draw.RoundedBox(0, 0, 0, w, h, bgColor)
        draw.RoundedBox(0, 0, 0, w, h * 0.05, butCol)
    
        draw.SimpleText(toggleText, "motoess_orbitron", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local nvgBindButton = vgui.Create("Motoess.NVGButton.EXTRAS")
    nvgBindButton:SetParent(self)
    nvgBindButton:SetSize(swSelf * 0.075, shSelf * 0.05)
    nvgBindButton:SetPos(swSelf * 0.775, shSelf * 0.925)
    nvgBindButton:SetLabelText("Bind")
    nvgBindButton.DoClick = function()
        surface.PlaySound("garrysmod/ui_click.wav")
    
        local ply = LocalPlayer()
        local copyText = "bind n motus_nightvision"

        SetClipboardText(copyText)

        ply:ChatPrint("Motus Systems: Copied - " .. copyText)
        ply:ChatPrint("Paste the bind you copied in your console.")
    end

    nvgBindButton.Paint = function(s, w, h)
        local butCol = Motoess.GetNVGColor()

        local bgColor = s:IsHovered() and Color(22, 22, 22) or Color(41, 41, 41)
        draw.RoundedBox(0, 0, 0, w, h, bgColor)
        draw.RoundedBox(0, 0, 0, w, h * 0.05, butCol)
    
        draw.SimpleText("Copy Bind", "motoess_orbitron", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local nvgDisableHud = vgui.Create("Motoess.NVGButton.EXTRAS")
    nvgDisableHud:SetParent(self)
    nvgDisableHud:SetSize(swSelf * 0.075, shSelf * 0.05)
    nvgDisableHud:SetPos(swSelf * 0.465, shSelf * 0.84)
    nvgDisableHud:SetLabelText("Bind")
    nvgDisableHud.DoClick = function()
        surface.PlaySound("garrysmod/ui_click.wav")
        RunConsoleCommand("motus_nightvision_togglehud")
    end

    nvgDisableHud.Paint = function(s, w, h)
        local butCol = color_white
        local toggleText = ""

        if Motoess.DisabledHud then
            butCol = Color(202, 72, 72)
            toggleText = "HUD Disabled"
        else
            butCol = Color(98, 202, 72)
            toggleText = "HUD Enabled"
        end

        local bgColor = s:IsHovered() and Color(22, 22, 22) or Color(41, 41, 41)
        draw.RoundedBox(0, 0, 0, w, h, bgColor)
        draw.RoundedBox(0, 0, 0, w, h * 0.05, butCol)
    
        draw.SimpleText(toggleText, "motoess_orbitron_small", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

function PANEL:CreateNVGColorMenu()
    local sw, sh = ScrW(), ScrH()

    local buttonHeight = 40
    local margin = 20

    self.listLayout:Clear()

    for index, config in ipairs(Motoess.nightvisionConfigs) do
        local colorName = config.name
        local button = vgui.Create("Motoess.NVGButton")
        button:SetParent(self.listLayout)
        button:SetSize(200, buttonHeight)
        button:SetLabelText("Color " .. colorName)
        button:Dock(TOP)
        button:DockMargin(sw * 0.2, 0, sw * 0.2, margin)

        button.OnCursorEntered = function()
            surface.PlaySound("garrysmod/ui_hover.wav")
        end
        button.DoClick = function()
            surface.PlaySound("garrysmod/ui_click.wav")
            RunConsoleCommand("motus_nightvision_color", tostring(index))
        end
    end
end

function PANEL:Paint(w, h)
    local frameCol = Motoess.GetNVGColor()
    local frameBg = Color(25, 25, 25)

    local textColorFart = Color(255, 255, 255, math.random(150, 255))

    draw.RoundedBox(0, 0, 0, w, h, frameBg)

    draw.RoundedBox(0, 0, 0, w, h * 0.01, frameCol)
    draw.RoundedBox(0, w * 0.075, h * 0.539, w * 0.85, h * 0.0025, frameCol)
    draw.RoundedBox(0, 0, h * 0.991, w, h * 0.01, frameCol)

    surface.SetDrawColor(textColorFart)
    surface.SetMaterial(Material("motoess_nvgs/motus_skull_shit.png"), "smooth")
    surface.DrawTexturedRect(w * 0.065, h * 0.825, w * 0.05, h * 0.1)

    draw.SimpleText(Motoess.VersionName, "motoess_sicret", w * 0.0875, h * 0.97, textColorFart, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    draw.SimpleText("-=Motus Systems=-", "motoess_orbitron", w * 0.09, h * 0.94, textColorFart, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

vgui.Register("Motoess.NVGFrame", PANEL, "DFrame")