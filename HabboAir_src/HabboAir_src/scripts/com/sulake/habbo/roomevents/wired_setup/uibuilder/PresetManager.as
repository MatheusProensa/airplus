package com.sulake.habbo.roomevents.wired_setup.uibuilder
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.UnknownIHabboRoomeventsWired_Setup1;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.HtmlTextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.ListScrollParams;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SourceTypeSelectorParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextAreaParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.AssetButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.AssetButtonRowPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.AvatarImagePreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.BitmapViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.ButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.ButtonRowPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CenteredContainerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxOptionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CollapseExpandSectionButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.ContainerButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.HorizontalSectionListPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.HtmlPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.IconButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.MiniAssetIconButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.NumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.PaddedContainerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.PressedButtonMiniAssetIconButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.ScrollListPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SliderPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SourceTypeSelectorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SpacerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SpacingPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SplitterPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.StaticBitmapAssetWrapperPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextAreaPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextualButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.VariablePickerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.VolterMiniAssetIconButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WindowWrapperPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications.ChronoMaskFilterPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications.ChronoRangeFilterPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications.FloorDrawingPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications.FloorEditorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications.LevelXpPreviewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications.SubVariableCreatorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedDropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedNumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedTextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.RewardListPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.RewardRowPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts.ChestItemIconPreviewerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts.ItemTypeSelectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts.NodeOverviewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts.TradeRuleEditorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts.TradeRuleListEditorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.AdvancedSettingsWrapperPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.FooterPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.FramePreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.HeaderPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.IlluminaHeaderPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.InnerBorderFramePreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.InputSourceSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.VolterHeaderPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.MenuPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.BorderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ChooseVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ItemTypeSelectionSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.PlaceholderNameSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.PlaceholderTypeSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.UsageInfoSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.UsageWarningSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ValueOrVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.VariableNameSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.VariablePlaceholderModeSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class PresetManager
   {
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _presetTemplates:Map = new Map();
      
      public function PresetManager(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
      }
      
      public function createRadioButton(param1:RadioButtonParam, param2:Boolean = false) : RadioButtonPreset
      {
         return new RadioButtonPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createRadioGroup(param1:Array, param2:Function = null, param3:int = 1) : RadioGroupPreset
      {
         return new RadioGroupPreset(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createCheckboxOption(param1:CheckboxOptionParam, param2:Boolean = false) : CheckboxOptionPreset
      {
         return new CheckboxOptionPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createCheckboxGroup(param1:Array, param2:Function = null, param3:int = 1) : CheckboxGroupPreset
      {
         return new CheckboxGroupPreset(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createSection(param1:String, param2:WiredUIPreset, param3:SectionParam = null) : SectionPreset
      {
         return new SectionPreset(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createBorderSection(param1:String, param2:WiredUIPreset, param3:SectionParam = null) : BorderSection
      {
         return new BorderSection(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createSourceTypeSelector(param1:SourceTypeSelectorParam) : SourceTypeSelectorPreset
      {
         return new SourceTypeSelectorPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createCollapseExpandSectionButton(param1:Function = null, param2:Boolean = true) : CollapseExpandSectionButtonPreset
      {
         return new CollapseExpandSectionButtonPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createTextInput(param1:TextInputParam) : TextInputPreset
      {
         return new TextInputPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createNumberInput(param1:NumberInputParam) : NumberInputPreset
      {
         return new NumberInputPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createNamedNumberInput(param1:NumberInputParam, param2:String, param3:Boolean = false) : NamedNumberInputPreset
      {
         return new NamedNumberInputPreset(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createNamedTextInput(param1:TextInputParam, param2:String, param3:Boolean = false) : NamedTextInputPreset
      {
         return new NamedTextInputPreset(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createNamedDropdown(param1:DropdownParam, param2:String, param3:Boolean = false) : NamedDropdownPreset
      {
         return new NamedDropdownPreset(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createChronoRangeFilter(param1:String, param2:String, param3:String, param4:int, param5:int, param6:int, param7:int) : ChronoRangeFilterPreset
      {
         return new ChronoRangeFilterPreset(_roomEvents,this,wiredStyle,param1,param2,param3,param4,param5,param6,param7);
      }
      
      public function createChronoMaskFilter(param1:Array, param2:int = 1) : ChronoMaskFilterPreset
      {
         return new ChronoMaskFilterPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createRewardList(param1:int, param2:int) : RewardListPreset
      {
         return new RewardListPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createRewardRow() : RewardRowPreset
      {
         return new RewardRowPreset(_roomEvents,this,wiredStyle);
      }
      
      public function createAssetButtonRow(param1:Array) : AssetButtonRowPreset
      {
         return new AssetButtonRowPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createBitmapViewPreset() : BitmapViewPreset
      {
         return new BitmapViewPreset(_roomEvents,this,wiredStyle);
      }
      
      public function createFloorDrawingPreset(param1:Function) : FloorDrawingPreset
      {
         return new FloorDrawingPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createFloorEditorPreset(param1:AssetButtonRowPreset, param2:FloorDrawingPreset) : FloorEditorPreset
      {
         return new FloorEditorPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createTextArea(param1:TextAreaParam) : TextAreaPreset
      {
         return new TextAreaPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createSimpleListView(param1:Boolean, param2:Array, param3:Boolean = false) : SimpleListViewPreset
      {
         return new SimpleListViewPreset(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createScrollList(param1:Array, param2:ListScrollParams, param3:Boolean = false) : ScrollListPreset
      {
         return new ScrollListPreset(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createSplitter() : SplitterPreset
      {
         return new SplitterPreset(_roomEvents,this,wiredStyle);
      }
      
      public function createSpacer(param1:int) : SpacerPreset
      {
         return new SpacerPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createText(param1:String, param2:TextParam = null) : TextPreset
      {
         if(param2 == null)
         {
            param2 = TextParam.DEFAULT;
         }
         return new TextPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createHtml(param1:String, param2:HtmlTextParam) : HtmlPreset
      {
         return new HtmlPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createLevelXpPreview(param1:Array) : LevelXpPreviewPreset
      {
         return new LevelXpPreviewPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createSubVariableCreator(param1:String, param2:Array) : SubVariableCreatorPreset
      {
         return new SubVariableCreatorPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createVariablePicker(param1:Function = null, param2:Function = null) : VariablePickerPreset
      {
         return new VariablePickerPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createDropdown(param1:DropdownParam) : DropdownPreset
      {
         return new DropdownPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createSpacing(param1:Boolean, param2:int) : SpacingPreset
      {
         return new SpacingPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createValueOrVariableSection(param1:int, param2:Array, param3:String, param4:int, param5:int) : ValueOrVariableSection
      {
         return new ValueOrVariableSection(_roomEvents,this,wiredStyle,param1,param2,param3,param4,param5);
      }
      
      public function createChooseVariableSection(param1:int = -1, param2:Array = null, param3:Function = null, param4:Function = null, param5:String = null) : ChooseVariableSection
      {
         return new ChooseVariableSection(_roomEvents,this,wiredStyle,param1,param2,param3,param4,param5);
      }
      
      public function createVariableNameSection() : VariableNameSection
      {
         return new VariableNameSection(_roomEvents,this,wiredStyle);
      }
      
      public function createUsageInfoSection(param1:String, param2:Boolean = false, param3:String = null) : UsageInfoSection
      {
         return new UsageInfoSection(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createUsageWarningSection(param1:String) : UsageWarningSection
      {
         return new UsageWarningSection(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createPlaceholderNameSection(param1:String, param2:String) : PlaceholderNameSection
      {
         return new PlaceholderNameSection(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createPlaceholderTypeSection(param1:String = null) : PlaceholderTypeSection
      {
         return new PlaceholderTypeSection(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createVariablePlaceholderModeSection(param1:String) : VariablePlaceholderModeSection
      {
         return new VariablePlaceholderModeSection(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createBitmapWrapperPreset(param1:String) : StaticBitmapAssetWrapperPreset
      {
         return new StaticBitmapAssetWrapperPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createAvatarImagePreset() : AvatarImagePreset
      {
         return new AvatarImagePreset(_roomEvents,this,wiredStyle);
      }
      
      public function createTextualButtonPreset(param1:String, param2:Function) : TextualButtonPreset
      {
         return new TextualButtonPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createHeaderPreset(param1:String, param2:UnknownIHabboRoomeventsWired_Setup1, param3:int, param4:Function, param5:Function, param6:Function) : HeaderPreset
      {
         if(wiredStyle.isVolter)
         {
            return new VolterHeaderPreset(_roomEvents,this,wiredStyle,param1,param2,param3,param4,param5,param6);
         }
         if(wiredStyle.name == "illumina")
         {
            return new IlluminaHeaderPreset(_roomEvents,this,wiredStyle,param1,param2,param3,param4,param5,param6);
         }
         throw new Error("Header preset for unsupported style");
      }
      
      public function createIconButtonPreset(param1:String, param2:Function) : IconButtonPreset
      {
         return new IconButtonPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createSliderPreset(param1:Number = 0, param2:Number = 1, param3:Number = 0) : SliderPreset
      {
         return new SliderPreset(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createSliderSection(param1:String, param2:String, param3:IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1, param4:Number = 0, param5:Number = 1, param6:Number = 0, param7:Boolean = true, param8:SectionParam = null) : SliderSection
      {
         return new SliderSection(_roomEvents,this,wiredStyle,param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function createButton(param1:String, param2:Function, param3:int = 0) : ButtonPreset
      {
         return new ButtonPreset(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createButtonRow(param1:Array) : ButtonRowPreset
      {
         return new ButtonRowPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createFooterPreset(param1:Function, param2:Function) : FooterPreset
      {
         return new FooterPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createFramePreset(param1:Array, param2:Function, param3:String = null, param4:int = -1, param5:Boolean = false, param6:Boolean = false, param7:ListScrollParams = null) : FramePreset
      {
         if(wiredStyle.useInnerBorder)
         {
            return new InnerBorderFramePreset(_roomEvents,this,wiredStyle,param1,param2,param3,param4,param5);
         }
         return new FramePreset(_roomEvents,this,wiredStyle,param1,param2,param3,param4,param5,param6,param7);
      }
      
      public function createInputSourceSection(param1:String, param2:int, param3:int, param4:Array = null, param5:Boolean = false, param6:Boolean = false) : InputSourceSection
      {
         return new InputSourceSection(_roomEvents,this,wiredStyle,param1,param2,param3,param4,param5,param6);
      }
      
      public function createAdvancedSettingsWrapperPreset(param1:Array, param2:Boolean) : AdvancedSettingsWrapperPreset
      {
         return new AdvancedSettingsWrapperPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createPaddedContainerPreset(param1:WiredUIPreset, param2:int, param3:int, param4:int, param5:int, param6:IWindowController_1 = null, param7:Boolean = false) : PaddedContainerPreset
      {
         return new PaddedContainerPreset(_roomEvents,this,wiredStyle,param1,param2,param3,param4,param5,param6,param7);
      }
      
      public function createContainerButtonPreset(param1:WiredUIPreset, param2:Function, param3:Boolean = true) : ContainerButtonPreset
      {
         return new ContainerButtonPreset(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createCenteredContainerPreset(param1:WiredUIPreset, param2:int, param3:IWindowController_1 = null) : CenteredContainerPreset
      {
         return new CenteredContainerPreset(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createMiniAssetIconButtonPreset(param1:String, param2:String, param3:Function) : MiniAssetIconButtonPreset
      {
         if(wiredStyle.isVolter)
         {
            return new VolterMiniAssetIconButtonPreset(_roomEvents,this,wiredStyle,param1,param2,param3);
         }
         return new PressedButtonMiniAssetIconButtonPreset(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createAssetButtonPreset(param1:String, param2:String, param3:Function) : AssetButtonPreset
      {
         return new AssetButtonPreset(_roomEvents,this,wiredStyle,param1,param2,param3);
      }
      
      public function createMenuPreset(param1:Array, param2:IWindowModel) : MenuPreset
      {
         return new MenuPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createHorizontalSectionListPreset(param1:Array) : HorizontalSectionListPreset
      {
         return new HorizontalSectionListPreset(_roomEvents,this,wiredStyle,param1);
      }
      
      public function createWrapperPreset(param1:IWindowModel) : WindowWrapperPreset
      {
         return new WindowWrapperPreset(_roomEvents,this,wiredStyle,param1,false);
      }
      
      public function get wiredStyle() : WiredStyle
      {
         return _roomEvents.wiredCtrl.wiredStyle;
      }
      
      public function createLayout(param1:String) : IWindowModel
      {
         if(_presetTemplates.hasKey(param1))
         {
            return _presetTemplates.getValue(param1).clone();
         }
         var _loc2_:IWindowModel = _roomEvents.getXmlWindow(param1);
         _presetTemplates.add(param1,_loc2_);
         return _loc2_.clone();
      }
      
      public function createRuleEditorPreset(param1:String, param2:Function, param3:Function, param4:Function = null, param5:Function = null) : TradeRuleEditorPreset
      {
         return new TradeRuleEditorPreset(_roomEvents,this,wiredStyle,param1,param2,param3,param4,param5);
      }
      
      public function createRuleListEditorPreset(param1:Function, param2:Function) : TradeRuleListEditorPreset
      {
         return new TradeRuleListEditorPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
      
      public function createChestItemIconPreviewerPreset() : ChestItemIconPreviewerPreset
      {
         return new ChestItemIconPreviewerPreset(_roomEvents,this,wiredStyle);
      }
      
      public function createItemTypeSelectionPreset() : ItemTypeSelectionPreset
      {
         return new ItemTypeSelectionPreset(_roomEvents,this,wiredStyle);
      }
      
      public function createItemTypeSelectionSection() : ItemTypeSelectionSection
      {
         return new ItemTypeSelectionSection(_roomEvents,this,wiredStyle);
      }
      
      public function createNodeOverviewPreset(param1:String, param2:Function = null) : NodeOverviewPreset
      {
         return new NodeOverviewPreset(_roomEvents,this,wiredStyle,param1,param2);
      }
   }
}

