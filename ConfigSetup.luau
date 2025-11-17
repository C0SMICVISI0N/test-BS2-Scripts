
-- Services
local HttpService = game:GetService("HttpService")

-- Functions
function SetupConfig(HubName: string, Config: string, Defaults: {})

    local FileLocation = `{HubName}/{Config}.json`
    
    if not isfolder(HubName) then
        
        makefolder(HubName)

    end

    if not isfile(FileLocation) then
        
        writefile(FileLocation, "{}")

    end

    local File = HttpService:JSONDecode(readfile(FileLocation))

    for Key: string, Value: any in Defaults do
        
        if File[Key] == nil then File[Key] = Value end

    end

    _G[HubName] = _G[HubName] or {}

    if _G[HubName][Config] then
        
        for Key: string, Value: any in File do
            
            if _G[HubName][Config][Key] == nil then _G[HubName][Config][Key] = Value end

        end

    else

        _G[HubName][Config] = File

    end

    File = _G[HubName][Config]

    writefile(FileLocation, HttpService:JSONEncode(File))

end

function AutoSave(HubName: string)
    
    if not _G[HubName] then return end

    if _G[HubName].IsLoaded then return end

    while task.wait(15) do
        
        local Configs = _G[HubName]

        for Config: string, File: {} in Configs do
            
            local FileLocation = `{HubName}/{Config}.json`
            writefile(FileLocation, HttpService:JSONEncode(File))

        end

    end

end

-- init
SetupConfig("MangoHub", "Theme", {
    ["Blur"] = true;
    ["Transparency"] = true;
})

SetupConfig("MangoHub", "BurpingSimulator2", {
    ["AutoDrink"] = false;
    ["AutoEquip"] = false;
    ["AutoPresteige"] = false;
    ["AutoGems"] = false;
    ["AntiAFK"] = true;
    ["AntiKick"] = false;
    ["AutoLeave"] = false;
    ["Hide"] = false;
})

task.spawn(function()
    AutoSave("MangoHub")
end)
