
if _G[HubName].IsLoaded then return end

-- Services
local PathfindingService = game:GetService("PathfindingService")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Paths
local LocalPlayer = Players.LocalPlayer
local GemsFolder: Folder = workspace.Gems
local DrinkEvent: RemoteEvent = ReplicatedStorage.Events.DrinkEvent 
local PrestigeEvent: RemoteEvent = ReplicatedStorage.Events.PrestigeEvent 

-- Variables
local AdminList = {1027666240,1620422855,3335828,1438362857,12206611}

-- Functions
function EquipBestDrink()
    
    pcall(function()
        
        local Character = LocalPlayer.Character
        local Humanoid = Character.Humanoid
        local Backpack = LocalPlayer.Backpack
        local ToEquip

        Humanoid:UnequipTools()

        for _, Tool: Tool in pairs(Backpack:GetChildren()) do
            
            if Tool.Name == "Burp" then continue end

            ToEquip = ToEquip or Tool

            local ToEquipPower = ToEquip.add.Value
            local CurrentPower = Tool.add.Value

            if CurrentPower > ToEquipPower then ToEquip = Tool end

        end

        Humanoid:EquipTool(ToEquip)

    end)

end

-- Code
-- Anti AFK
LocalPlayer.Idled:Connect(function()

    if _G["MangoHub"]["BurpingSimulator2"]["AntiAFK"] then

        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)

        task.wait()

        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)

    end

end)

-- Anti Kick
task.spawn(function()
    
    local GameMetatable = getrawmetatable(game)
    local NameCall = GameMetatable.__namecall

    setreadonly(GameMetatable, false)

    GameMetatable.__namecall = newcclosure(function(self, ...)

        local Method = getnamecallmethod()

        if Method == "Kick" and _G["MangoHub"]["BurpingSimulator2"]["AntiKick"] then
            task.wait(9e9)
            return
        end

        return NameCall(self, ...)
        
    end)

    hookfunction(LocalPlayer.Kick, newcclosure(function()
        if _G["MangoHub"]["BurpingSimulator2"]["AntiKick"] then
            task.wait(9e9)
        end
    end))

end)

-- Auto Gems
task.spawn(function()

    while task.wait(0.1) do
        if not _G["MangoHub"]["BurpingSimulator2"]["AutoGems"] then continue end
        pcall(function()
            local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart

            local TouchInterest = GemsFolder:FindFirstChild("TouchInterest", true)

            firetouchinterest(HumanoidRootPart, TouchInterest.Parent, 1)
            firetouchinterest(HumanoidRootPart, TouchInterest.Parent, 0)
        end)

    end

end)

-- Auto Drink
task.spawn(function()
    
    while task.wait(0.1) do
        
        if _G["MangoHub"]["BurpingSimulator2"]["AutoDrink"] then
            DrinkEvent:FireServer()
        end

    end

end)

-- Auto Prestige
task.spawn(function()
    
    while task.wait(0.1) do
        
        if _G["MangoHub"]["BurpingSimulator2"]["AutoPresteige"] then
            PrestigeEvent:FireServer()
        end

    end

end)

-- Auto Equip
task.spawn(function()
    
    while task.wait(0.5) do
        if _G["MangoHub"]["BurpingSimulator2"]["AutoEquip"] then
            EquipBestDrink()
        end
    end

end)

-- Auto Leave
Players.PlayerAdded:Connect(function(Player: Player)
    
    local id = Player.UserId

    if table.find(AdminList, id) and _G["MangoHub"]["BurpingSimulator2"]["AutoLeave"] then
        
        game:Shutdown()

    end

end)

-- Hide
task.spawn(function()
    
    while task.wait(0.5) do
        
        if _G["MangoHub"]["BurpingSimulator2"]["Hide"] then
            
            pcall(function()
                
                local Character = LocalPlayer.Character
                local HumanoidRootPart = Character.HumanoidRootPart

                HumanoidRootPart.Anchored = true
                Character:PivotTo(CFrame.new(0,-250,0))

            end)

        end

    end

end)
