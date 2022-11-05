---@module UIExtended/lib/Types
local Types = require(script.Types);
export type UIObjectType = Types.UIObjectType;

--[=[
    @class UIExtended

    This class was designed to contain UI Objects that can be used
    to simplify your workflow and manipulate your UI for different use cases.
]=]
local UIExtended = {}::Types.UIExtended;

local UIObjectsContainer: Folder = script.UIObjects;

local Slider: Types.Schema_Slider = require(UIObjectsContainer:FindFirstChild("Slider"));
local UILayout: Types.Schema_UILayout = require(UIObjectsContainer:FindFirstChild("UILayout"));

local cachedUIClasses: Types.Dictionary<any> = {};

function UIExtended.newUIObject<T>(name: string) : T
    if not cachedUIClasses[name] then
        local UIObjectModule = UIObjectsContainer:FindFirstChild(name)::ModuleScript;
        if not UIObjectModule then error("Invalid UIObject '"..(name or "nil").."'"); end
        local UIObjectClass: any = require(UIObjectModule);
        local initFn: (() -> ())? = UIObjectClass["Init"];
        if initFn then initFn(); end
        cachedUIClasses[name] = UIObjectClass;
    end
    local uiObject: T = cachedUIClasses[name].new();
    -- Serialize the UIObject into a Folder Instance with attributes.
    local serializeFn: ((self: any) -> ())? = uiObject["Serialize"];
    if serializeFn then serializeFn(uiObject); end
    return uiObject;
end

return UIExtended;