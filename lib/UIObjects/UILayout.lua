---@module UIExtended/lib/Types
local Types = require(script.Parent.Parent.Types);
export type UILayout = Types.UILayout;

--[=[
    @class UILayout

    This class is very similar to [UIListLayout] it was designed really just to
    use an initial scaled sizing that would be converted to offset sizing based off of the [GuiObject].
]=]
local UILayout = {}::Types.Schema_UILayout;
UILayout.__index = UILayout;
UILayout.ClassName = "UILayout";

--[=[
    @interface I_FillDirection
    @within UILayout
    @tag enum-like

    .Horizontal 0 -- Fill in the left to right direction
    .Vertical 1 -- Fill in the top to bottom direction
]=]
local FillDirection: Types.FillDirection = {
    Horizontal = 0,
    Vertical = 1
};

--[=[
    @interface I_HorizontalAlignment
    @within UILayout
    @tag enum-like

    .Center 0 -- Aligns to the X center of the element
    .Left 1 -- Aligns to the left of the element
    .Right 2 -- Aligns to the right of the element
]=]
local HorizontalAlignment: Types.HorizontalAlignment = {
    Center = 0,
    Left = 1,
    Right = 2
};

--[=[
    @interface I_VerticalAlignment
    @within UILayout
    @tag enum-like

    .Center 0 -- Aligns to the Y center of the element
    .Top 1 -- Aligns to the top of the element
    .Bottom 2 -- Aligns to the bottom of the element
]=]
local VerticalAlignment: Types.VerticalAlignment = {
    Center = 0,
    Top = 1,
    Bottom = 2
};

--[=[
    @interface I_SortOrder
    @within UILayout
    @tag enum-like

    .Name 0
    .LayoutOrder 1
]=]
local SortOrder: Types.SortOrder = {
    Name = 0,
    LayoutOrder = 1
};

--[=[
    @interface I_Enums
    @within UILayout
    @tag enum-like

    .FillDirection I_FillDirection
    .HorizontalAlignment I_HorizontalAlignment
    .VerticalAlignment I_VerticalAlignment
    .SortOrder I_SortOrder
]=]
local _Enums: Types.Enums_UILayout = {
    FillDirection = FillDirection,
    HorizontalAlignment = HorizontalAlignment,
    VerticalAlignment = VerticalAlignment,
    SortOrder = SortOrder
};
--[=[
    @prop Enums I_Enums
    @within UILayout
    @tag enum-like

    This is a property that stores the [UILayout] Enums that can be used
    to access the enum values.
]=]
UILayout.Enums = _Enums;

function UILayout.Init()

end

--[=[
    This function creates a new [UILayout] object.

    :::note

    More about the staticPadding parameter can be read at [UILayout._isStaticPadding].

    `The 'Show Private' box at the top of this doc page must be enabled to see it.`

    :::
]=]
function UILayout.new() : UILayout
    local self = {}::Types.Object_UILayout;
    --[=[
        @prop _isStaticPadding boolean
        @within UILayout
        @tag object-prop
        @private

        This is an internal property that determines if the [UILayout] should take
        the [UILayout._Padding] -> [UDim.Scaled] property as an initial scale
        that is converted to offset for cases where you want the element to be
        sized according to the parent [ScrollingFrame] but only it's original size.
    ]=]
    self._isStaticPadding = false;
    --[=[
        @prop _Padding UDim
        @within UILayout
        @tag object-prop
        @private

        This is an internal property which behaves exactly like [UIListLayout.Padding].
        #### UIListLayout.Padding:

        >Determines the amount of free space between each element.
        Can be set either using scale (Percentage of parent's size in the current direction)
        or offset (a static spacing value, similar to pixel size).
    ]=]
    self._Padding = UDim.new(0,0);
    --[=[
        @prop AbsoluteContentSize Vector2
        @within UILayout
        @tag object-prop

        This property which behaves exactly like [UIListLayout.AbsoluteContentSize].
        #### UIListLayout.AbsoluteContentSize:

        >The AbsoluteContentSize property of a [UIGridStyleLayout] shows
        how much space the elements of the grid are taking up, including any padding created by the grid.
        This property is particularly useful to size containers of grids such as [Frames](https://developer.roblox.com/en-us/api-reference/class/Frame) to make
        sure they aren't any larger than the grid itself.
    ]=]
    self.AbsoluteContentSize = Vector2.new();
    --[=[
        @prop FillDirection I_FillDirection
        @within UILayout
        @tag object-prop

        This property is handled exactly like [UIListLayout.FillDirection].
        #### UIListLayout.FillDirection

        >The FillDirection property determines the axis in which
        UI elements are laid out. Horizontal will arrange elements from left to right,
        while Vertical will arrange from top to bottom. To reverse elements (for instance, arrange right to left)
        you will need to reverse the sorting. This can be done by negating
        the child UI elements' [GuiObject.LayoutOrder] values
        when [UIGridStyleLayout.SortOrder] is set to LayoutOrder.

        :::note

        You can use the `enum-like` table [UILayout.I_FillDirection] for the [UILayout.FillDirection].

        :::
    ]=]
    self.FillDirection = FillDirection.Vertical;
    --[=[
        @prop HorizontalAlignment number
        @within UILayout
        @tag object-prop

        This property is handled exactly like [UIListLayout.HorizontalAlignment].
        #### UIListLayout.HorizontalAlignment:

        >The HorizontalAlignment property determines the X-axis alignment of the laid-out grid of UI elements, much like TextLabel.TextXAlignment does with TextLabel.Text.

        :::note

        You can use the `enum-like` table [UILayout.E_HorizontalAlignment] for the [UILayout.HorizontalAlignment].

        :::
    ]=]
    self.HorizontalAlignment = HorizontalAlignment.Center;
    --[=[
        @prop VerticalAlignment number
        @within UILayout
        @tag object-prop

        This property is handled exactly like [UIListLayout.VerticalAlignment].
        #### UIListLayout.VerticalAlignment:

        >The VerticalAlignment property determines the Y-axis alignment of the laid-out grid of UI elements,
        much like [TextLabel.TextYAlignment] does with [TextLabel.Text].

        :::note

        You can use the `enum-like` table [UILayout.E_VerticalAlignment] for the [UILayout.VerticalAlignment].

        :::
    ]=]
    self.VerticalAlignment = VerticalAlignment.Center;
    self.SortOrder = SortOrder.LayoutOrder;
    return setmetatable(self::table,UILayout::table)::UILayout;
end

function UILayout.SetPadding(self: UILayout,padding: UDim,isStatic: boolean?)
    self._Padding = padding;
    self._isStaticPadding = isStatic or false;
    if isStatic and not self._isStaticPadding then
        local offsetPadding: number = self._Padding.Offset;
        -- Convert scaled size to offset
        if self._Padding.Scale > 0 then
            if self.Parent then
                
            else

            end
        end
    end
end

function UILayout.SetParent(self: UILayout,parent: Instance)
    if parent and parent:IsA("GuiObject") then
        self.Parent = parent;
        self._SerializedFolder.Parent = parent;
        self:LayoutElements();
    end
end

local function positionElementX(elements: {GuiObject},index: number,padding: number?)
    local element: GuiObject = elements[index];
    local prevElement: GuiObject = elements[index - 1];
    local prevEndPos: number = prevElement.AbsolutePosition.X + prevElement.AbsoluteSize.X;
    local pos: number = prevEndPos + element.AbsoluteSize.X;
    if padding then pos += padding; end
    element.Position = UDim2.new(0,pos,0,0);
end

local Cam: Camera = game.Workspace.CurrentCamera;
local ViewportSize: Vector2 = Cam.ViewportSize;

local function positionElementY(uiLayout: UILayout,elements: {GuiObject},index: number,padding: number?)
    local elementsLength: number = #elements;
    local element: GuiObject = elements[index];
    local prevElement: GuiObject;

    local pos: number;

    if uiLayout.VerticalAlignment == VerticalAlignment.Top or uiLayout.VerticalAlignment == VerticalAlignment.Center then
        if index == 1 then
            pos = 0;
        else
            prevElement = elements[index - 1];
            pos =  prevElement.AbsoluteSize.Y + prevElement.Position.Y.Offset;
            if padding then pos += padding; end
        end
        element.Position = UDim2.new(0,0,0,pos);
    elseif uiLayout.VerticalAlignment == VerticalAlignment.Bottom then
        local viewportSize: Vector2 = ViewportSize;
        -- Get ScreenGui of element to check for ignoreGuiInset
        local ScreenGui = element:FindFirstAncestorOfClass("ScreenGui")::ScreenGui;
        if ScreenGui then
            if not ScreenGui.IgnoreGuiInset then
                viewportSize -= Vector2.new(0,36);
            end
        end
        local uiParent: GuiObject = uiLayout.Parent;
        if index == elementsLength then
            -- Convert parent frame size to offset
            local offsetY: number = 0;
            if uiParent.Size.Y.Scale > 0 then
                offsetY = uiParent.Size.Y.Scale * viewportSize.Y;
            end
            offsetY += uiParent.Size.Y.Offset;
            pos = offsetY - element.AbsoluteSize.Y;
        else
            prevElement = elements[index + 1];
            pos = prevElement.Position.Y.Offset - prevElement.AbsoluteSize.Y;
            if padding then pos -= padding; end
        end
    end
    element.Position = UDim2.new(0,0,0,pos);
end

local function sortByLayoutOrder(a: GuiObject,b: GuiObject) return a.LayoutOrder < b.LayoutOrder; end
local function sortByName(a: GuiObject,b: GuiObject) return a.Name < b.Name; end

function UILayout.LayoutElements(self: UILayout)
    if not self.Parent then return; end
    local parentChildren: {Instance} = self.Parent:GetChildren();
    local parentElements: {GuiObject} = {};
    for _,child: Instance in ipairs(parentChildren) do
        if child:IsA("GuiObject") then
            table.insert(parentElements,child::GuiObject);
        end
    end
    if self.SortOrder == SortOrder.Name then
        table.sort(parentElements,sortByName);
    elseif self.SortOrder == SortOrder.LayoutOrder then
        table.sort(parentElements,sortByLayoutOrder);
    end
    local elementsLength: number = #parentElements;
    local paddingOffset: number = self._Padding.Offset;
    if self._Padding.Scale > 0 then
        paddingOffset += self._Padding.Scale * self.Parent.AbsoluteSize.Y;
    end
    if self.FillDirection == FillDirection.Horizontal then
        
    elseif self.FillDirection == FillDirection.Vertical then
        if self.VerticalAlignment == VerticalAlignment.Center then
            for index = 1,elementsLength do
                positionElementY(self,parentElements,index,5);
            end
            local CenterOffsetY: number;
            local ScreenGui = self.Parent:FindFirstAncestorOfClass("ScreenGui")::ScreenGui;
            if ScreenGui then
                if not ScreenGui.IgnoreGuiInset then
                    ViewportSize -= Vector2.new(0,36);
                end
            end
            local offsetY: number = 0;
            if self.Parent.Size.Y.Scale > 0 then
                offsetY = self.Parent.Size.Y.Scale * ViewportSize.Y;
            end
            offsetY += self.Parent.Size.Y.Offset;
            local FrameCenterY: number = offsetY / 2;
            if elementsLength % 2 == 0 then
                local halfPointElement: GuiObject = parentElements[elementsLength/2];
                CenterOffsetY = FrameCenterY - (halfPointElement.Position.Y.Offset + halfPointElement.AbsoluteSize.Y);
            else
                local halfPointElement: GuiObject = parentElements[math.round(elementsLength/2)];
                CenterOffsetY = FrameCenterY - (halfPointElement.Position.Y.Offset + (halfPointElement.AbsoluteSize.Y / 2));
            end
            for index = 1,elementsLength do
                local element: GuiObject = parentElements[index];
                element.Position += UDim2.new(0,0,0,CenterOffsetY);
            end
        elseif self.VerticalAlignment == VerticalAlignment.Top then
            for index = 1,elementsLength do
                positionElementY(self,parentElements,index,5);
            end
        elseif self.VerticalAlignment == VerticalAlignment.Bottom then
            for index = elementsLength,1,-1 do
                positionElementY(self,parentElements,index,5);
            end
        end
    end
end

local function findValueInEnumCategory(queryCategory: string,enumKey: string) : number?
    local category: Types.Dictionary<number> = _Enums[queryCategory];
    if category then
        return category[enumKey];
    end
end

local function findKeyInEnumCategory(queryCategory: string,enumValue: number) : string?
    local category: Types.Dictionary<number> = _Enums[queryCategory];
    if category then
        for categoryKey: string,value: number in pairs(category) do
            if value == enumValue then
                return categoryKey;
            end
        end
    end
end

local RunService: RunService = game:GetService("RunService");

function UILayout.Serialize(self: UILayout)
    local Folder = Instance.new("Folder")::Folder;
    Folder.Name = self.ClassName;

    -- Attribute 'StaticPadding'
    (Folder::Instance):SetAttribute("isStaticPadding",self._isStaticPadding);
    (Folder::Instance):GetAttributeChangedSignal("isStaticPadding"):Connect(function(attribute: string)
        local isStaticPadding: boolean = (Folder::Instance):GetAttribute("isStaticPadding");
        if type(isStaticPadding) == "boolean" then
            self._isStaticPadding = isStaticPadding;
        end
    end);

    -- Attribute 'Padding'
    (Folder::Instance):SetAttribute("Padding",self._Padding);
    (Folder::Instance):GetAttributeChangedSignal("Padding"):Connect(function()
        local padding: UDim = (Folder::Instance):GetAttribute("Padding");
        if typeof(padding) == "Instance" and padding:IsA("UDim") then
            self:SetPadding(padding,self._isStaticPadding);
        end
    end);

    -- Attribute 'AbsoluteContentSize'
    (Folder::Instance):SetAttribute("AbsoluteContentSize",self.AbsoluteContentSize);
    (Folder::Instance):GetAttributeChangedSignal("AbsoluteContentSize"):Connect(function()
        local absContentSize: Vector2 = (Folder::Instance):GetAttribute("AbsoluteContentSize");
    end);

    -- Attribute 'FillDirection'
    local FillDirectionKey: string? = findKeyInEnumCategory("FillDirection",self.FillDirection);
    if FillDirectionKey then
        (Folder::Instance):SetAttribute("FillDirection",FillDirectionKey);
        (Folder::Instance):GetAttributeChangedSignal("FillDirection"):Connect(function()
            local fillDirectionKey: string = (Folder::Instance):GetAttribute("FillDirection");
            if type(fillDirectionKey) == "string" then
                local fillDirectionValue: number? = findValueInEnumCategory("FillDirection",fillDirectionKey);
                if fillDirectionValue then self.FillDirection = fillDirectionValue; end
            end
        end);
    end

    -- Attribute 'HorizontalAlignment'
    local HorizontalAlignmentKey: string? = findKeyInEnumCategory("HorizontalAlignment",self.HorizontalAlignment);
    if HorizontalAlignmentKey then
        (Folder::Instance):SetAttribute("HorizontalAlignment",HorizontalAlignmentKey);
        (Folder::Instance):GetAttributeChangedSignal("HorizontalAlignment"):Connect(function()
            local horizontalAlignmentKey: string = (Folder::Instance):GetAttribute("HorizontalAlignment");
            if type(horizontalAlignmentKey) == "string" then
                local horizontalAlignmentValue: number? = findValueInEnumCategory("HorizontalAlignment",horizontalAlignmentKey);
                if horizontalAlignmentValue then self.HorizontalAlignment = horizontalAlignmentValue; end
            end
        end);
    end

    -- Attribute 'VerticalAlignment'
    local VerticalAlignmentKey: string? = findKeyInEnumCategory("VerticalAlignment",self.VerticalAlignment);
    if VerticalAlignmentKey then
        (Folder::Instance):SetAttribute("VerticalAlignment",HorizontalAlignmentKey);
        (Folder::Instance):GetAttributeChangedSignal("VerticalAlignment"):Connect(function()
            local verticalAlignmentKey: string = (Folder::Instance):GetAttribute("VerticalAlignment");
            if type(verticalAlignmentKey) == "string" then
                local verticalAlignmentValue: number? = findValueInEnumCategory("VerticalAlignment",verticalAlignmentKey);
                if verticalAlignmentValue then self.VerticalAlignment = verticalAlignmentValue; end
            end
        end);
    end

    -- Attribute 'SortOrder'
    local SortOrderKey: string? = findKeyInEnumCategory("SortOrder",self.VerticalAlignment);
    if SortOrderKey then
        (Folder::Instance):SetAttribute("SortOrder",HorizontalAlignmentKey);
        (Folder::Instance):GetAttributeChangedSignal("SortOrder"):Connect(function()
            local sortOrderKey: string = (Folder::Instance):GetAttribute("SortOrder");
            if type(sortOrderKey) == "string" then
                local sortOrderValue: number? = findValueInEnumCategory("SortOrder",sortOrderKey);
                if sortOrderValue then self.SortOrder = sortOrderValue; end
            end
        end);
    end

    if RunService:IsRunning() then
        Folder:GetPropertyChangedSignal("Parent"):Connect(function()
            -- Make sure parent instances are not the same
            local parent: Instance = Folder.Parent;
            if parent and not (parent == self.Parent) then
                self:SetParent(parent);
            end
        end);
    elseif RunService:IsStudio() then
        Folder.AncestryChanged:Connect(function(child: Instance,parent: Instance)
            if not (child == Folder) then return; end
            if parent and not (parent == self.Parent) then
                -- Make sure parent instances are not the same
                if not parent == self.Parent then
                    self:SetParent(parent);
                end
            end
        end);
    end
    self._SerializedFolder = Folder;
end

return UILayout;