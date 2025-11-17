local to_load = {
  "https://raw.githubusercontent.com/C0SMICVISI0N/test-BS2-Scripts/refs/heads/main/ConfigSetup.luau";
  "https://raw.githubusercontent.com/C0SMICVISI0N/test-BS2-Scripts/refs/heads/main/GuiMain.luau";
  "https://raw.githubusercontent.com/C0SMICVISI0N/test-BS2-Scripts/refs/heads/main/Main.luau";
}

for _, File: string in to_load do

  loadstring(game:HttpGet(File))()
  
end

_G[HubName].IsLoaded = true
