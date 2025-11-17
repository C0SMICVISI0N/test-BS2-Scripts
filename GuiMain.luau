
-- Services
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

-- Variables
local Teleports = {
    ["Spawn"] = CFrame.new(2214, 453, 83);
    ["Second Island"] = CFrame.new(1165, 452, -30);
    ["Candy Island"] = CFrame.new(-1470, 452, -3);
    ["Moon Base"] = CFrame.new(-2108, 7968, -219);
}

-- Paths
local LocalPlayer = Players.LocalPlayer

-- Library
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Mango Hub  |",
    SubTitle = "Burping Simulator 2 v" .. game.PlaceVersion,
    TabWidth = 100,
    Size = UDim2.fromOffset(450, 300),
    Acrylic = _G["MangoHub"]["Theme"]["Blur"], -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.LeftAlt -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    AutoFarm = Window:AddTab({ Title = "Auto Farm", Icon = "repeat" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}



local Options = Fluent.Options

-- Player Section
local MovementSection = Tabs.Player:AddSection("Movement")
local SpeedSlider = Tabs.Player:AddSlider("SpeedSlider", {Title = "Speed", Default = 16, Min = 5, Max = 150, Rounding = 1})
local JumpPowerSlider = Tabs.Player:AddSlider("JumpPowerSlider", {Title = "Jump Power", Default = 50, Min = 5, Max = 300, Rounding = 1})
--local FlyToggle = Tabs.Player:AddToggle("FlyToggle", {Title = "Fly", Default = false })
--local Noclip = Tabs.Player:AddToggle("NoclipToggle", {Title = "Noclip", Default = false })

local PlayerMiscSection = Tabs.Player:AddSection("Misc")
Tabs.Player:AddButton({
    Title = "Server Hop",
    Description = "Rejoins the game on a random server",
    Callback = function()
        TeleportService:Teleport(game.PlaceId)
    end
})
local TeleportDropdown = Tabs.Player:AddDropdown("TeleportDropdown", {
    Title = "Teleport",
    Description = "Select Destanation",
    Values = {"Spawn", "Second Island", "Candy Island", "Moon Base"},
    Multi = false,
    Default = "None",
})
local ScriptDropdown = Tabs.Player:AddDropdown("ScriptDropdown", {
    Title = "Script",
    Description = "Select script to load.",
    Values = {"Inf Yeild"},
    Multi = false,
    Default = "None",
})

-- Auto Farm Tab
local FarmSection = Tabs.AutoFarm:AddSection("Auto Farm")
local AutoDrink = Tabs.AutoFarm:AddToggle("AutoDrink", {Title = "Auto Drink", Default = _G["MangoHub"]["BurpingSimulator2"]["AutoDrink"] })
local AutoEquip = Tabs.AutoFarm:AddToggle("AutoEquip", {Title = "Auto Equip", Default = _G["MangoHub"]["BurpingSimulator2"]["AutoEquip"] })
local AutoPresteige = Tabs.AutoFarm:AddToggle("AutoPresteige", {Title = "Auto Presteige", Default = _G["MangoHub"]["BurpingSimulator2"]["AutoPresteige"] })
local AutoGems = Tabs.AutoFarm:AddToggle("AutoGems", {Title = "Auto Gems", Default = _G["MangoHub"]["BurpingSimulator2"]["AutoGems"] })

local FarmUtilsSection = Tabs.AutoFarm:AddSection("Auto Farm Utilitys")
local AntiAFK = Tabs.AutoFarm:AddToggle("AntiAFK", {Title = "Anti AFK", Default = _G["MangoHub"]["BurpingSimulator2"]["AntiAFK"] })
local AntiKick = Tabs.AutoFarm:AddToggle("AntiKick", {Title = "Anti Kick", Default = _G["MangoHub"]["BurpingSimulator2"]["AntiKick"] })
local AdminAutoLeave = Tabs.AutoFarm:AddToggle("AdminAutoLeave", {Title = "Auto Leave", Description = "Leaves if admin joins.", Default = _G["MangoHub"]["BurpingSimulator2"]["AutoLeave"] })

local MiscSection = Tabs.AutoFarm:AddSection("Misc")
local Hide = Tabs.AutoFarm:AddToggle("Hide", {Title = "Hide", Default = _G["MangoHub"]["BurpingSimulator2"]["Hide"] })

-- Settings Tab
local ThemeSection = Tabs.Settings:AddSection("Theme")
local ToggleBlur = Tabs.Settings:AddToggle("ToggleBlur", {Title = "Blur", Default = _G["MangoHub"]["Theme"]["Blur"] })
local ToggleTransparency = Tabs.Settings:AddToggle("ToggleTransparency", {Title = "Transparency", Default = _G["MangoHub"]["Theme"]["Transparency"] })


Window:SelectTab(1)

-- Player Tab Code
SpeedSlider:OnChanged(function(Speed: number)
    
    local Character = LocalPlayer.Character
    local Humanoid = Character.Humanoid

    Humanoid.WalkSpeed = Speed

end)

JumpPowerSlider:OnChanged(function(JumpPower: number)
    
    local Character = LocalPlayer.Character
    local Humanoid = Character.Humanoid

    Humanoid.JumpPower = JumpPower

end)

TeleportDropdown:OnChanged(function(Location: string)
    local cframe = Teleports[Location]

    pcall(function()
        
        LocalPlayer.Character:PivotTo(cframe)

    end)

end)

-- Auto Farm Tab Code
AntiAFK:OnChanged(function()
    _G["MangoHub"]["BurpingSimulator2"]["AntiAFK"] = Options.AntiAFK.Value
end)
AntiKick:OnChanged(function()
    _G["MangoHub"]["BurpingSimulator2"]["AntiKick"] = Options.AntiKick.Value
end)

AutoGems:OnChanged(function()
    _G["MangoHub"]["BurpingSimulator2"]["AutoGems"] = Options.AutoGems.Value
end)
AutoDrink:OnChanged(function()
    _G["MangoHub"]["BurpingSimulator2"]["AutoDrink"] = Options.AutoDrink.Value
end)
AutoPresteige:OnChanged(function()
    _G["MangoHub"]["BurpingSimulator2"]["AutoPresteige"] = Options.AutoPresteige.Value
end)
AutoEquip:OnChanged(function()
    _G["MangoHub"]["BurpingSimulator2"]["AutoEquip"] = Options.AutoEquip.Value
end)

Hide:OnChanged(function()
    _G["MangoHub"]["BurpingSimulator2"]["Hide"] = Options.Hide.Value

    if not Options.Hide.Value then
        
        local cframe = Teleports["Spawn"]

        pcall(function()

            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character.HumanoidRootPart

            if HumanoidRootPart.Anchored then

                HumanoidRootPart.Anchored = false
                
                Character:PivotTo(cframe)

            end

        end)

    end

end)
AdminAutoLeave:OnChanged(function()
    _G["MangoHub"]["BurpingSimulator2"]["AutoLeave"] = Options.AdminAutoLeave.Value
end)

-- Settings Tab Code
ToggleBlur:OnChanged(function()
    Fluent:ToggleAcrylic(Options.ToggleBlur.Value)
    _G["MangoHub"]["Theme"]["Blur"] = Options.ToggleBlur.Value
end)
ToggleTransparency:OnChanged(function()
    Fluent:ToggleTransparency(Options.ToggleTransparency.Value)
    _G["MangoHub"]["Theme"]["Transparency"] = Options.ToggleTransparency.Value
end)