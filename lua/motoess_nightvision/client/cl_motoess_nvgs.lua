if CLIENT then
    local function CreateFonts()
        surface.CreateFont("motoess_orbitron", {
            font = "Orbitron Medium",
            size = ScreenScale(7),
            weight = 500,
        })

        surface.CreateFont("motoess_orbitron_small", {
            font = "Orbitron Medium",
            size = ScreenScale(5),
            weight = 300,
        })

        surface.CreateFont("motoess_sicret", {
            font = "Sicret Mono PERSONAL Light",
            extended = false,
            size = ScreenScale(7),
            weight = 500,
            antialias = true,
            shadow = false
        })
    end

    CreateFonts()

    hook.Add("OnScreenSizeChanged", "Motoess.UpdateFontsOnResolutionChange", function() 
        CreateFonts() 
    end)

    local cache = {}

    function Motoess.UpdateCache(entity, state)
        if not entity:IsPlayer() then return end
        if state then
            table.insert(cache, entity)
        else
            for i = 1, #cache do
                if cache[i] == entity then table.remove(cache, i) end
            end
        end
    end


    CreateClientConVar("motus_nightvision_color", "1", true, false)


    function Motoess.drawVig()
        local ply = LocalPlayer()
        local nvColor = GetConVar("motus_nightvision_color"):GetInt()
    
        if ply:GetNWBool("MotoessNVGs") then
            DrawMaterialOverlay("overlays/vignette01", 1)
            DrawMaterialOverlay("overlays/vignette01", 1)
            DrawMaterialOverlay("overlays/vignette01", 1)
            DrawMaterialOverlay("overlays/vignette01", 1)

            /*if nvColor == 9 then
                DrawMaterialOverlay( "models/props_c17/fisheyelens", -0.03 )
            end*/
        else
            return
        end
    end
    hook.Add("RenderScreenspaceEffects", "Motoess.VigOverlay", Motoess.drawVig)


    hook.Add("RenderScreenspaceEffects", "Motus.NVGEffects", function()
        local ply = LocalPlayer()
        if ply:GetNWBool("MotoessNVGs") then
            local colorTab = Motoess.GetColorTab()
            DrawColorModify(colorTab)
    
            local nvColor = GetConVar("motus_nightvision_color"):GetInt()
            local maxIndex = #Motoess.nightvisionConfigs
    
            if nvColor == 1 or nvColor > maxIndex then -- if nvColor == 1 or nvColor > 9 then
                DrawBloom(0.3, 1, 4, 4, 1, 1, 1, 1, 1)
            elseif nvColor == 4 then
                DrawBloom(0, 1.25, 4, 2, 1, 1, 1, 1.5, 2)
            else
                DrawBloom(0, 0.9, 4, 2, 1, 1, 1, 1, 1)
            end
        end
    end)
    


    local motus_logo_skull_main = Material("materials/motoess_nvgs/motus_skull_shit.png", "unlitgeneric")
    local motus_logo_skull_glitch = Material("materials/motoess_nvgs/motus_skull_shit_glitch.png", "unlitgeneric")

    hook.Add("HUDPaint", "MotusIcon", function()
        local SW, SH = ScrW(), ScrH()
        local ply = LocalPlayer()

        if Motoess.DisabledHud then return end
    
        if ply:GetNWBool("MotoessNVGs") then

            draw.RoundedBox(50, SW * 0.438, SH * 0.94, SW * 0.12, SH * 0.05, Color(0, 0, 0, 100))

            draw.SimpleText("-=Motus Systems=-", "motoess_orbitron", SW * 0.495, SH * 0.95, Color(255, 255, 255, math.random(150, 255)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText(Motoess.VersionName, "motoess_sicret", SW * 0.4965, SH * 0.975, Color(255, 255, 255, math.random(150, 255)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            surface.SetDrawColor(255, 255, 255, math.random(50, 190))
            surface.SetMaterial(motus_logo_skull_glitch)
            surface.DrawTexturedRect(SW * 0.486, SH * 0.89, SW * 0.025, SH * 0.049)

            surface.SetDrawColor(255, 255, 255, math.random(100, 190))
            surface.SetMaterial(motus_logo_skull_main)
            surface.DrawTexturedRect(SW * 0.486, SH * 0.89, SW * 0.025, SH * 0.049)
        end
    end)

    hook.Add("NotifyShouldTransmit", "Motoess.PVS_Cache", function(entity, state) Motoess.UpdateCache(entity, state) end)
    hook.Add("EntityRemoved", "Motoess.PVS_Cache", function(entity) Motoess.UpdateCache(entity, false) end)

    hook.Add("RenderScreenspaceEffects", "MotoessNVGs.Rendering", function()
        for i = 1, #cache do
            local target = cache[i]
            if DisableHud == 1 then
                if target.MotoessNVGs then
                    target.MotoessNVGs:Remove()
                    target.MotoessNVGs = nil
                end
            end

            if target:GetNWBool("MotoessNVGs") then
                if target.MotoessNVGs then
                    local position = target:GetPos()
                    target.MotoessNVGs:SetPos(Vector(position[1], position[2], position[3] + 60) + target:GetForward() * 2)
                    target.MotoessNVGs:SetAngles(target:EyeAngles())
                    target.MotoessNVGs:SetBrightness(1.05)
                    target.MotoessNVGs:SetColor(255, 255, 255, 255)
                    target.MotoessNVGs:Update()
                else
                    target.MotoessNVGs = ProjectedTexture()
                    target.MotoessNVGs:SetTexture("effects/flashlight/square")
                    target.MotoessNVGs:SetFarZ(16000)
                    target.MotoessNVGs:SetFOV(140)
                end
            else
                if target.MotoessNVGs then
                    target.MotoessNVGs:Remove()
                    target.MotoessNVGs = nil
                end
            end
        end
    end)

    concommand.Add("motus_nightvision", function(ply, state)
        ply:SetNWBool("MotoessNVGs", not ply:GetNWBool("MotoessNVGs")) --if DisableHud == 1 then return ply:ChatPrint("[MOTUS SYSTEMS] Enable your VISR first.") end
        if ply:GetNWBool("MotoessNVGs") then
            ply:EmitSound("night_vision_on.wav", 75)
        else
            ply:EmitSound("night_vision_off_c.wav", 75)
        end
        return false
    end)

    concommand.Add("motus_nightvision_togglehud", function(ply, cmd, args)
        Motoess.DisabledHud = not Motoess.DisabledHud
        if Motoess.DisabledHud then
            ply:ChatPrint("Motus Systems: HUD disabled.")
        else
            ply:ChatPrint("Motus Systems: HUD enabled.")
        end
    end)
end