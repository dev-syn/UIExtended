export type Map<K,V> = {[K]: V};
export type Dictionary<T> = Map<string,T>;

-- #region Slider
export type Object_Slider = {
    Decimal: number,
    isPressed: boolean,
    Frame: Frame,
    SliderBar: Frame,
    SliderPoint: Frame,
    _Listeners: {RBXScriptConnection}
};

export type Schema_Slider = {
    __index: any,
    ClassName: "Slider",

    Init: (uiExtended: UIExtended) -> (),
    new: (...any) -> Slider,
    SetParent: (self: Slider,parent: GuiObject) -> (),
    Destroy: (self: Slider) -> ()
};

export type Slider = Object_Slider & Schema_Slider;

-- #endregion

-- #region UILayout

    export type FillDirection = {
        Horizontal: number,
        Vertical: number
    };

    export type HorizontalAlignment = {
        Center: number,
        Left: number,
        Right: number
    };

    export type VerticalAlignment = {
        Center: number,
        Top: number,
        Bottom: number
    };

    export type SortOrder = {
        Name: number,
        LayoutOrder: number
    };

    export type Object_UILayout = {
        _isStaticPadding: boolean,
        _Padding: UDim,
        AbsoluteContentSize: Vector2,
        FillDirection: number,
        HorizontalAlignment: number,
        VerticalAlignment: number,
        SortOrder: number,
        Parent: GuiObject?,
        _SerializedFolder: Folder
    };

    export type Enums_UILayout = {
        FillDirection: FillDirection,
        HorizontalAlignment: HorizontalAlignment,
        VerticalAlignment: VerticalAlignment,
        SortOrder: SortOrder,
    };

    export type Schema_UILayout = {
        __index: any,
        ClassName: "UILayout",
        Enums: Enums_UILayout,

        Init: () -> (),
        new: () -> (),
        SetPadding: (self: UILayout,padding: UDim,isStatic: boolean?) -> (),
        SetParent: (self: UILayout,parent: Instance) -> (),
        LayoutElements: (self: UILayout) -> (),
        Serialize: (self: UILayout) -> ()
    };

    export type UILayout = Object_UILayout & Schema_UILayout;

-- #endregion

export type UIObjectTypes = {
    Slider: Schema_Slider,
    UILayout: Schema_UILayout
}

export type UIObjectType = Schema_Slider | UILayout;

export type UIExtended = {
    newUIObject: <T>(name: string) -> T
};
return true;