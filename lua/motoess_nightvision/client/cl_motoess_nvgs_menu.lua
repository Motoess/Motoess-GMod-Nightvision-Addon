include("vgui/cl_motoess_button.lua")
include("vgui/cl_motoess_frame.lua")

local function CreateNVGMenu()
    local frame = vgui.Create("Motoess.NVGFrame")
    frame:CreateNVGColorMenu(Motoess.nightvisionConfigs)
end

concommand.Add("motoess_nvg_menu", CreateNVGMenu)

list.Set( "DesktopWindows", "Motoess NVG Menu", {
	title = "Motoess NVG Menu",
	icon = "motoess_nvgs/motus_skull_shit.png",
	init = function( icon, window )
		RunConsoleCommand("motoess_nvg_menu")
	end
} )