---@module UIExtended/lib/Types
local Types = require(script.Parent.Parent.Types);
type Slider = Types.Slider;

local UserInputService: UserInputService = game:GetService("UserInputService");
local RunService: RunService = game:GetService("RunService");

--[=[
    @class Slider
]=]
local Slider = {} :: Types.Schema_Slider;
Slider.__index = Slider;
Slider.ClassName = "Slider";

local SliderFrame = script.Parent.Parent.PrebuiltUI:FindFirstChild("Slider")::Frame;

--[[
    UI hierarchy

    Slider - Frame
        SliderBar - Frame
            SliderButton - TextButton
--]]
local UIExtended: Types.UIExtended;
local isInitialized: boolean = false;
function Slider.Init(uiExtended: Types.UIExtended)
    if isInitialized then return; end
    UIExtended = uiExtended;
    isInitialized = true;
end

local Cam: Camera = game.Workspace.CurrentCamera;
local BOUND_OFFSET: number = math.ceil(0.005 * Cam.ViewportSize.X);

local function isMouseInBoundsX(boundsFrame: Frame,mousePosX: number) : (boolean,number,number)
    -- Out of bounds X
    local frameAbsSizeX: number = boundsFrame.AbsoluteSize.X;
    -- Fail-safe for empty size frame
    if frameAbsSizeX == 0 then return false,0,0; end

    local startPosX: number = boundsFrame.AbsolutePosition.X - BOUND_OFFSET;
    local endPosX: number = boundsFrame.AbsolutePosition.X + frameAbsSizeX + BOUND_OFFSET;

    --print("\nmouse pos: ",mousePosX,"\ni: ",startPosX,"\nj: ",endPosX);
    return not (mousePosX < startPosX or mousePosX > endPosX),startPosX,endPosX;
end

function Slider.new() : Slider
    local self = {} :: Types.Object_Slider;
    self.Decimal = 0;
    self.isPressed = false;
    self.Frame = SliderFrame:Clone();
    self.SliderBar = self.Frame:FindFirstChild("SliderBar")::Frame;
    self.SliderPoint = self.SliderBar:FindFirstChild("SliderPoint")::Frame;
    self._Listeners = {
        UserInputService.InputBegan:Connect(function(input: InputObject)
            if not (input.UserInputType == Enum.UserInputType.MouseButton1) then return; end
            local inBounds: boolean = isMouseInBoundsX(self.Frame,input.Position.X);
            if inBounds then self.isPressed = true; end
        end),
        UserInputService.InputEnded:Connect(function(input: InputObject)
            if not (input.UserInputType == Enum.UserInputType.MouseButton1) then return; end
            self.isPressed = false;
        end),
        UserInputService.InputChanged:Connect(function(input: InputObject)
            if not (input.UserInputType == Enum.UserInputType.MouseMovement) then return; end
            if not self.isPressed then return; end
            local mousePosX: number = UserInputService:GetMouseLocation().X;
            -- Check if the mouse pos x is within the frame bounds pos x
            local inBounds: boolean,iX: number,jX: number = isMouseInBoundsX(self.Frame,mousePosX);
            if inBounds then
                if mousePosX == 0 then
                    self.SliderPoint.Position = UDim2.new(0,0,0.5,0);
                    self.Decimal = 0;
                else
                    mousePosX  = math.clamp(mousePosX,iX,jX);
                    -- Get the normalized value of mouse pos x - start pos x
                    local range: number = jX - iX;
                    local decimal: number = (mousePosX - iX) / range;
                    self.SliderPoint.Position = UDim2.new(decimal,0,0.5,0);
                    self.Decimal = math.floor(decimal * 100)/100;
                end
            end
        end);
    };
    return setmetatable(self::table,Slider::table)::Slider;
end

function Slider.SetParent()
    
end

function Slider.Destroy(self: Slider)
    if self.Frame then
        self.Frame:Destroy();
        self.Frame = nil::any;
    end
    if self._Listeners then
        for index: number,conn: RBXScriptConnection in ipairs(self._Listeners) do
            conn:Disconnect();
            self._Listeners[index] = nil;
        end
    end
end

return Slider;