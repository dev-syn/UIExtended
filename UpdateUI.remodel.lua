---@diagnostic disable: undefined-global
local game = remodel.readPlaceFile("UIExtended.rbxlx");
remodel.createDirAll("lib/PrebuiltUI");

local UIExtendedUIs = game.StarterGui:FindFirstChild("UIExtended");

for _,ui in ipairs(UIExtendedUIs:GetChildren()) do
    remodel.writeModelFile("lib/PrebuiltUI/"..ui.Name..".rbxmx",ui);
end