local plr: Player = game.Players.LocalPlayer;
local PlayerScripts: PlayerScripts = plr.PlayerScripts;

local UIExtendedModule = PlayerScripts:WaitForChild("UIExtended")::ModuleScript;
---@module UIExtended/lib/Types
local Types = require(UIExtendedModule:FindFirstChild("Types"));
local UIExtended: Types.UIExtended = require(PlayerScripts:WaitForChild("UIExtended"));

local UIObjects = UIExtendedModule:FindFirstChild("UIObjects")::Folder;
local Slider: Types.Schema_Slider = require(UIObjects:FindFirstChild("Slider"));

local testUI: ScreenGui = Instance.new("ScreenGui");
testUI.ResetOnSpawn = false;
testUI.Parent = plr.PlayerGui;

local testF: Frame = Instance.new("Frame");
testF.Size = UDim2.new(0.25,0,0.5,0);
testF.AnchorPoint = Vector2.new(0.5,0.5);
testF.Position = UDim2.new(0.5,0,0.5,0);
testF.Parent = testUI;

for i = 1,6 do
    local box: Frame = Instance.new("Frame");
    box.Name = string.format("box_%d",i);
    box.SizeConstraint = Enum.SizeConstraint.RelativeYY;
    box.Size = UDim2.new(0.1,0,0.1,0);
    box.Parent = testF;
end

--[[local testSlider: Types.Slider = Slider.new();
testSlider.Frame.Parent = testUI;--]]

local testUILayout: Types.UILayout = UIExtended.newUIObject("UILayout");
local E_UILayout: Types.Enums_UILayout = testUILayout.Enums;
testUILayout.VerticalAlignment = E_UILayout.VerticalAlignment.Center;
testUILayout:SetParent(testF);
