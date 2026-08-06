package com.sulake.habbo.roomevents.wired_setup
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.events.*;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ActionDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.AddonDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ConditionDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.InputSourcesConf;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.SelectorDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.TriggerDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.UnknownHabboCommunicationMessagesIncomingUserdefinedroomevents1;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.VariableDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.AllVariablesInRoom;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.ApplySnapshotMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateActionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateAddonMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateConditionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateSelectorMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateTriggerMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateVariableMessageComposer;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.WiredVariablesSynchronizer;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.ActionType;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.ActionTypes;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.WriteToLogs;
   import com.sulake.habbo.roomevents.wired_setup.addons.AddonTypes;
   import com.sulake.habbo.roomevents.wired_setup.conditions.ConditionTypes;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.selectors.SelectorTypes;
   import com.sulake.habbo.roomevents.wired_setup.triggerconfs.TriggerConfs;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.AdvancedSettingsWrapperPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.FooterPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.FramePreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.HeaderPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.InputSourceSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.IlluminaWiredStyle;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.UbuntuWiredStyle;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.VolterBlueWiredStyle;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.VolterGreenWiredStyle;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.VolterWiredStyle;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.VolterYellowWiredStyle;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import com.sulake.habbo.roomevents.wired_setup.variables.INewDefaultVariableType;
   import com.sulake.habbo.roomevents.wired_setup.variables.VariableTypes;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.utils.Dictionary;
   
   public class UserDefinedRoomEventsCtrl implements IUserDefinedRoomEventsCtrl
   {
      public static const STYLE_DEFAULT:String = "illumina";
      
      public static const UPDATE_MODE_NORMAL:int = 0;
      
      public static const UnknownConstFromUserDefinedRoomEventsCtrl_Int_1:int = 1;
      
      public static const UPDATE_MODE_SAVE_INTO_OTHER:int = 2;
      
      public static const STYLE_OPTIONS:Array = ["illumina","volter"];
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_TriggerConfs_1:TriggerConfs = new TriggerConfs();
      
      private var _actionTypes:ActionTypes = new ActionTypes();
      
      private var _conditionTypes:ConditionTypes = new ConditionTypes();
      
      private var _addonTypes:AddonTypes = new AddonTypes();
      
      private var _selectorTypes:SelectorTypes = new SelectorTypes();
      
      private var _variableTypes:VariableTypes = new VariableTypes();
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_Boolean_1:Boolean = false;
      
      private var _activeFurniPicks:int = 1;
      
      private var _stuffs1:Dictionary = new Dictionary();
      
      private var _stuffs2:Dictionary = new Dictionary();
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1:Triggerable;
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1:IDefaultElement;
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_RoomObjectHighLighter_1:RoomObjectHighLighter;
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_Boolean_2:Boolean = false;
      
      private var _variablesCallback:Function = null;
      
      private var _wiredStyles:Map;
      
      private var _wiredStyle:WiredStyle;
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_WiredStyle_1:WiredStyle;
      
      private var _presetManager:PresetManager;
      
      private var _configurationCache:Dictionary = new Dictionary();
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_Dictionary_1:Dictionary = new Dictionary();
      
      private var _updateMode:int = 0;
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_Int_1:int = -2147483648;
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_Int_2:int = -2147483648;
      
      private var _frame:FramePreset;
      
      private var _headerPreset:HeaderPreset;
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_CheckboxGroupPreset_1:CheckboxGroupPreset;
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_SectionPreset_1:SectionPreset;
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_SliderSection_1:SliderSection;
      
      private var _initialWidth:int;
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_AdvancedSettingsWrapperPreset_1:AdvancedSettingsWrapperPreset;
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1:Vector.<InputSourceSection>;
      
      private var UnknownVarFromUserDefinedRoomEventsCtrl_FooterPreset_1:FooterPreset;
      
      public function UserDefinedRoomEventsCtrl(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
         UnknownVarFromUserDefinedRoomEventsCtrl_RoomObjectHighLighter_1 = new RoomObjectHighLighter(param1);
         _presetManager = new PresetManager(param1);
         _wiredStyles = new Map();
         _wiredStyles.add("volter",new VolterWiredStyle(param1));
         _wiredStyles.add("illumina",new IlluminaWiredStyle(param1));
         _wiredStyles.add("volter_yellow",new VolterYellowWiredStyle(param1));
         _wiredStyles.add("volter_blue",new VolterBlueWiredStyle(param1));
         _wiredStyles.add("volter_green",new VolterGreenWiredStyle(param1));
         _wiredStyles.add("ubuntu",new UbuntuWiredStyle(param1));
         UnknownVarFromUserDefinedRoomEventsCtrl_WiredStyle_1 = _wiredStyles["illumina"];
         _wiredStyle = _wiredStyles.getValue("volter");
      }
      
      public function stuffAdded(param1:int) : void
      {
         if(activeStuffsDictionary[param1])
         {
            UnknownVarFromUserDefinedRoomEventsCtrl_RoomObjectHighLighter_1.show(param1,UnknownVarFromUserDefinedRoomEventsCtrl_Boolean_1,_activeFurniPicks);
         }
      }
      
      public function stuffSelected(param1:int) : void
      {
         if(_frame == null || UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 == null)
         {
            return;
         }
         if(_frame.isCopyingIntoMode)
         {
            return;
         }
         if(!isStuffSelectionMode() || !UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.allowWallFurni && param1 < 0)
         {
            return;
         }
         if(activeStuffsDictionary[param1])
         {
            delete activeStuffsDictionary[param1];
            UnknownVarFromUserDefinedRoomEventsCtrl_RoomObjectHighLighter_1.hide(param1,UnknownVarFromUserDefinedRoomEventsCtrl_Boolean_1,_activeFurniPicks);
         }
         else if(activeStuffsArray.length < UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.furniLimit)
         {
            activeStuffsDictionary[param1] = true;
            UnknownVarFromUserDefinedRoomEventsCtrl_RoomObjectHighLighter_1.show(param1,UnknownVarFromUserDefinedRoomEventsCtrl_Boolean_1,_activeFurniPicks);
         }
         onStuffsChanged();
      }
      
      private function isStuffSelectionMode() : Boolean
      {
         return UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 && (UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.inputSourcesConf.allowFurniSelection() || UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.forceFurniSelection);
      }
      
      public function get hidePickFurniInstructions() : Boolean
      {
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 == null)
         {
            return false;
         }
         if(UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.forceHidePickFurniInstructions)
         {
            return true;
         }
         return !UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.inputSourcesConf.isFurniSelectionDefault() && !UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.forceFurniSelection;
      }
      
      private function resolveHolder() : UnknownIHabboRoomeventsWired_Setup1
      {
         return resolveHolderFor(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1);
      }
      
      private function resolveHolderFor(param1:Triggerable) : UnknownIHabboRoomeventsWired_Setup1
      {
         if(param1 as TriggerDefinition != null)
         {
            return UnknownVarFromUserDefinedRoomEventsCtrl_TriggerConfs_1;
         }
         if(param1 as ActionDefinition != null)
         {
            return _actionTypes;
         }
         if(param1 as ConditionDefinition != null)
         {
            return _conditionTypes;
         }
         if(param1 as AddonDefinition != null)
         {
            return _addonTypes;
         }
         if(param1 as SelectorDefinition != null)
         {
            return _selectorTypes;
         }
         if(param1 as VariableDefinition != null)
         {
            return _variableTypes;
         }
         return null;
      }
      
      private function determineActiveWiredStyle() : WiredStyle
      {
         var _loc1_:String = null;
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 == null || UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1 == null)
         {
            return _wiredStyles["volter"];
         }
         var _loc2_:IFurnitureData = _roomEvents.sessionDataManager.getFloorItemData(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.stuffTypeId);
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.className;
            if(_loc1_ == "wf_ltdproto_act_toggle_state")
            {
               return _wiredStyles.getValue("volter_yellow");
            }
            if(_loc1_ == "wf_proto_trg_at_given_time")
            {
               return _wiredStyles.getValue("volter_blue");
            }
            if(_loc1_ == "wf_proto_cnd_trggrer_on_frn")
            {
               return _wiredStyles.getValue("volter_green");
            }
         }
         return UnknownVarFromUserDefinedRoomEventsCtrl_WiredStyle_1;
      }
      
      public function getStyleByName(param1:String) : WiredStyle
      {
         return _wiredStyles[param1];
      }
      
      private function getCacheKey(param1:UnknownIHabboRoomeventsWired_Setup1, param2:Triggerable) : String
      {
         return param1.getKey() + "-" + _wiredStyle.name + "-" + param1.getElementByCode(param2.code).code;
      }
      
      private function loadFromCache(param1:UnknownIHabboRoomeventsWired_Setup1, param2:Triggerable) : Boolean
      {
         var _loc3_:WiredConfigurationCache = null;
         var _loc4_:String = getCacheKey(param1,param2);
         if(_loc4_ in _configurationCache)
         {
            _loc3_ = _configurationCache[_loc4_];
            _frame = _loc3_.frame;
            _headerPreset = _loc3_.headerPreset;
            UnknownVarFromUserDefinedRoomEventsCtrl_CheckboxGroupPreset_1 = _loc3_.selectorOptionsPreset;
            UnknownVarFromUserDefinedRoomEventsCtrl_SectionPreset_1 = _loc3_.furniPicksSectionPreset;
            UnknownVarFromUserDefinedRoomEventsCtrl_SliderSection_1 = _loc3_.delayPreset;
            UnknownVarFromUserDefinedRoomEventsCtrl_AdvancedSettingsWrapperPreset_1 = _loc3_.advancedSettingsWrapperPreset;
            UnknownVarFromUserDefinedRoomEventsCtrl_RadioGroupPreset_1 = _loc3_.conditionQuantifierOptions;
            UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1 = _loc3_.inputSourcePresets;
            UnknownVarFromUserDefinedRoomEventsCtrl_FooterPreset_1 = _loc3_.footerPreset;
            _initialWidth = _loc3_.initialWidth;
            return true;
         }
         return false;
      }
      
      private function storeInCache(param1:UnknownIHabboRoomeventsWired_Setup1, param2:Triggerable) : void
      {
         var _loc4_:String = getCacheKey(param1,param2);
         var _loc3_:WiredConfigurationCache = new WiredConfigurationCache(_frame,_headerPreset,UnknownVarFromUserDefinedRoomEventsCtrl_CheckboxGroupPreset_1,UnknownVarFromUserDefinedRoomEventsCtrl_SectionPreset_1,UnknownVarFromUserDefinedRoomEventsCtrl_SliderSection_1,UnknownVarFromUserDefinedRoomEventsCtrl_AdvancedSettingsWrapperPreset_1,UnknownVarFromUserDefinedRoomEventsCtrl_RadioGroupPreset_1,UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1,UnknownVarFromUserDefinedRoomEventsCtrl_FooterPreset_1,_initialWidth);
         _configurationCache[_loc4_] = _loc3_;
      }
      
      private function createWindow() : Boolean
      {
         if(this._frame != null)
         {
            return false;
         }
         var _loc2_:UnknownIHabboRoomeventsWired_Setup1 = resolveHolder();
         if(_loc2_ == null || UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 == null || UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1 == null)
         {
            return false;
         }
         if(useCache && loadFromCache(_loc2_,UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1))
         {
            showFrame();
            return true;
         }
         var _loc1_:WiredUIBuilder = new WiredUIBuilder(_presetManager,close,_loc2_.getKey(),UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.code,isResizeEnabled);
         createHeader(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1,_loc2_,UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1,_loc1_);
         createInputs(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1,_loc2_,UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1,false,_loc1_);
         createSelectorOptions(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1,_loc2_,UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1,_loc1_);
         createFurniPicks(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1,_loc2_,UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1,_loc1_);
         createDelaySection(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1,_loc2_,UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1,_loc1_);
         createAdvancedSections(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1,_loc2_,UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1,_loc1_);
         createFooter(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1,_loc2_,UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1,_loc1_);
         _loc1_.build(UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.widthModifier,UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.allowScrolling);
         _frame = _loc1_.frame;
         _initialWidth = _loc1_.initialWidth;
         UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.onInit(_roomEvents);
         showFrame();
         if(useCache)
         {
            storeInCache(_loc2_,UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1);
         }
         return true;
      }
      
      public function resizeFrame() : void
      {
         _frame.resizeToWidth(UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.widthModifier * _initialWidth);
      }
      
      private function showFrame() : void
      {
         var _loc1_:IDesktopController = _roomEvents.windowManager.getDesktop(1);
         if(_loc1_ != null)
         {
            _loc1_.addChild(_frame.window);
         }
         _frame.window.center();
         _frame.window.activate();
      }
      
      private function hideFrame() : void
      {
         var _loc1_:IDesktopController = null;
         if(_frame != null)
         {
            _loc1_ = _roomEvents.windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_frame.window);
            }
         }
      }
      
      private function createHeader(param1:Triggerable, param2:UnknownIHabboRoomeventsWired_Setup1, param3:IDefaultElement, param4:WiredUIBuilder) : void
      {
         var _loc6_:int = 0;
         if(param3.hasStateSnapshot)
         {
            _loc6_ = 1;
         }
         var _loc5_:INewDefaultVariableType = param3 as INewDefaultVariableType;
         if(_roomEvents.wiredMenu.isEnabled && _loc5_ != null)
         {
            _loc6_ = 2;
         }
         if(param3 instanceof WriteToLogs)
         {
            _loc6_ = 3;
         }
         _headerPreset = _presetManager.createHeaderPreset(getElementName(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.stuffTypeId),param2,_loc6_,applySnapshot,viewVariableInMenu,viewLogs);
         param4.addElements(_headerPreset);
      }
      
      private function createInputs(param1:Triggerable, param2:UnknownIHabboRoomeventsWired_Setup1, param3:IDefaultElement, param4:Boolean, param5:WiredUIBuilder) : void
      {
         var _loc6_:int = param3.inputMode;
         if(_loc6_ == DefaultElement.INPUTS_TYPE_UI_BUILDER)
         {
            param3.setRoomEvents(_roomEvents);
            param3.buildInputs(_presetManager,_wiredStyle,param5);
         }
      }
      
      private function createSelectorOptions(param1:Triggerable, param2:UnknownIHabboRoomeventsWired_Setup1, param3:IDefaultElement, param4:WiredUIBuilder) : void
      {
         var _loc6_:SelectorDefinition = param1 as SelectorDefinition;
         var _loc5_:* = _loc6_ != null;
         if(!_loc5_)
         {
            return;
         }
         UnknownVarFromUserDefinedRoomEventsCtrl_CheckboxGroupPreset_1 = _presetManager.createCheckboxGroup([new CheckboxOptionParam("${wiredfurni.params.selector_option.0}"),new CheckboxOptionParam("${wiredfurni.params.selector_option.1}")]);
         var _loc7_:SectionPreset = _presetManager.createSection("${wiredfurni.params.selector_options_selector}",UnknownVarFromUserDefinedRoomEventsCtrl_CheckboxGroupPreset_1);
         param4.addElements(_loc7_);
      }
      
      private function createFurniPicks(param1:Triggerable, param2:UnknownIHabboRoomeventsWired_Setup1, param3:IDefaultElement, param4:WiredUIBuilder) : void
      {
         if(!isStuffSelectionMode() || hidePickFurniInstructions)
         {
            return;
         }
         var _loc5_:TextParam = new TextParam(1,false);
         _loc5_.textColor = _wiredStyle.softTextColor;
         UnknownVarFromUserDefinedRoomEventsCtrl_SectionPreset_1 = _presetManager.createSection("${wiredfurni.pickfurnis.caption}",_presetManager.createText("${wiredfurni.pickfurnis.desc}",_loc5_));
         param4.addElements(UnknownVarFromUserDefinedRoomEventsCtrl_SectionPreset_1);
      }
      
      private function createDelaySection(param1:Triggerable, param2:UnknownIHabboRoomeventsWired_Setup1, param3:IDefaultElement, param4:WiredUIBuilder) : void
      {
         var _loc6_:ActionDefinition = param1 as ActionDefinition;
         var _loc5_:ActionType = param3 as ActionType;
         if(_loc6_ == null || _loc5_ == null || !_loc5_.allowDelaying)
         {
            return;
         }
         UnknownVarFromUserDefinedRoomEventsCtrl_SliderSection_1 = _presetManager.createSliderSection("wiredfurni.params.delay","seconds",SliderSection.CONVERTER_PULSES,0,20,1,false);
         param4.addElements(UnknownVarFromUserDefinedRoomEventsCtrl_SliderSection_1);
      }
      
      private function getQuantifierKey(param1:ConditionDefinition) : String
      {
         var _loc2_:int = param1.quantifierType;
         var _loc3_:String = "wiredfurni.params.quantifier.";
         var _loc4_:String = _loc2_ == UnknownHabboCommunicationMessagesIncomingUserdefinedroomevents1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomevents1_Int_2 ? "furni" : (_loc2_ == UnknownHabboCommunicationMessagesIncomingUserdefinedroomevents1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomevents1_Int_3 ? "users" : (_loc2_ == UnknownHabboCommunicationMessagesIncomingUserdefinedroomevents1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomevents1_Int_4 ? "variables" : ""));
         _loc4_ = _loc4_ + (param1.isInvert ? ".neg." : ".");
         return _loc3_ + _loc4_;
      }
      
      private function createAdvancedSections(param1:Triggerable, param2:UnknownIHabboRoomeventsWired_Setup1, param3:IDefaultElement, param4:WiredUIBuilder) : void
      {
         var _loc6_:* = null;
         var _loc15_:String = null;
         var _loc11_:SectionPreset = null;
         var _loc7_:InputSourcesConf = param1.inputSourcesConf;
         var _loc5_:* = _loc7_.amountFurniSelections > 0;
         var _loc14_:* = _loc7_.amountUserSelections > 0;
         var _loc12_:ConditionDefinition = param1 as ConditionDefinition;
         var _loc9_:Boolean = _loc12_ != null && _loc12_.quantifierType != UnknownHabboCommunicationMessagesIncomingUserdefinedroomevents1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomevents1_Int_1;
         var _loc13_:Boolean = param1.advancedMode && (_loc5_ || _loc14_ || _loc9_);
         if(!_loc13_)
         {
            return;
         }
         var _loc8_:Array = [];
         if(_loc9_)
         {
            _loc15_ = getQuantifierKey(_loc12_);
            UnknownVarFromUserDefinedRoomEventsCtrl_RadioGroupPreset_1 = _presetManager.createRadioGroup([new RadioButtonParam(0,"${" + _loc15_ + 0 + "}"),new RadioButtonParam(1,"${" + _loc15_ + 1 + "}")]);
            _loc11_ = _presetManager.createSection("${wiredfurni.params.quantifier_selection}",UnknownVarFromUserDefinedRoomEventsCtrl_RadioGroupPreset_1);
            _loc8_.push(_loc11_);
         }
         createAdvancedInputSources(param1,param2,param3);
         for each(_loc6_ in UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1)
         {
            _loc8_.push(_loc6_);
         }
         var _loc10_:Boolean = param3.advancedAlwaysVisible();
         UnknownVarFromUserDefinedRoomEventsCtrl_AdvancedSettingsWrapperPreset_1 = _presetManager.createAdvancedSettingsWrapperPreset(_loc8_,_loc10_);
         param4.addElements(UnknownVarFromUserDefinedRoomEventsCtrl_AdvancedSettingsWrapperPreset_1);
      }
      
      private function createAdvancedInputSources(param1:Triggerable, param2:UnknownIHabboRoomeventsWired_Setup1, param3:IDefaultElement) : void
      {
         var _loc9_:int = 0;
         var _loc10_:InputSourceSection = null;
         var _loc11_:String = null;
         var _loc5_:InputSourcesConf = param1.inputSourcesConf;
         UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1 = new Vector.<InputSourceSection>();
         var _loc7_:Array = param3.mergedSelections();
         var _loc4_:Array = [];
         var _loc6_:Array = [];
         for each(var _loc8_ in _loc7_)
         {
            _loc4_.push(_loc8_[0]);
            _loc6_.push(_loc8_[1]);
         }
         _loc9_ = 0;
         while(_loc9_ < _loc5_.amountFurniSelections)
         {
            if(_loc4_.indexOf(_loc9_) == -1)
            {
               _loc11_ = "${" + param3.furniSelectionTitle(_loc9_) + "}";
               _loc10_ = _presetManager.createInputSourceSection(_loc11_,WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1,_loc9_,null,false,param1.inputSourcesConf.isDualFurniPickingMode());
               UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1.push(_loc10_);
            }
            _loc9_++;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc5_.amountUserSelections)
         {
            if(_loc6_.indexOf(_loc9_) == -1)
            {
               _loc11_ = "${" + param3.userSelectionTitle(_loc9_) + "}";
               _loc10_ = _presetManager.createInputSourceSection(_loc11_,WiredInputSourcePicker.USER_SOURCE,_loc9_);
               UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1.push(_loc10_);
            }
            _loc9_++;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc7_.length)
         {
            _loc11_ = "${" + param3.mergedSelectionTitle(_loc9_) + "}";
            _loc10_ = _presetManager.createInputSourceSection(_loc11_,WiredInputSourcePicker.MERGED_SOURCE,_loc9_,param3.mergedSourceOptions(_loc9_),param3.hasCustomTypePicker(_loc9_),param1.inputSourcesConf.isDualFurniPickingMode());
            UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1.push(_loc10_);
            _loc9_++;
         }
      }
      
      private function createFooter(param1:Triggerable, param2:UnknownIHabboRoomeventsWired_Setup1, param3:IDefaultElement, param4:WiredUIBuilder) : void
      {
         UnknownVarFromUserDefinedRoomEventsCtrl_FooterPreset_1 = _presetManager.createFooterPreset(save,close);
         param4.addElements(UnknownVarFromUserDefinedRoomEventsCtrl_FooterPreset_1);
      }
      
      private function fixQuantifierNames() : void
      {
         var _loc1_:ConditionDefinition = null;
         var _loc2_:String = null;
         if(UnknownVarFromUserDefinedRoomEventsCtrl_RadioGroupPreset_1 != null)
         {
            _loc1_ = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as ConditionDefinition;
            if(_loc1_ == null)
            {
               return;
            }
            _loc2_ = getQuantifierKey(_loc1_);
            UnknownVarFromUserDefinedRoomEventsCtrl_RadioGroupPreset_1.get(0).text = "${" + _loc2_ + 0 + "}";
            UnknownVarFromUserDefinedRoomEventsCtrl_RadioGroupPreset_1.get(1).text = "${" + _loc2_ + 1 + "}";
         }
      }
      
      private function onEditStartUpdateCommonUI() : void
      {
         _headerPreset.updateName(getElementName(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.stuffTypeId));
         var _loc1_:SelectorDefinition = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as SelectorDefinition;
         if(UnknownVarFromUserDefinedRoomEventsCtrl_CheckboxGroupPreset_1 != null && _loc1_ != null)
         {
            UnknownVarFromUserDefinedRoomEventsCtrl_CheckboxGroupPreset_1.get(0).selected = _loc1_.isFilter;
            UnknownVarFromUserDefinedRoomEventsCtrl_CheckboxGroupPreset_1.get(1).selected = _loc1_.isInvert;
         }
         var _loc3_:INewDefaultVariableType = UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1 as INewDefaultVariableType;
         if(_loc3_ != null && _roomEvents.wiredMenu.isEnabled)
         {
            _headerPreset.buttonVisible = _loc3_.initialVariableName.length > 0;
         }
         onStuffsChanged();
         var _loc4_:ActionDefinition = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as ActionDefinition;
         if(UnknownVarFromUserDefinedRoomEventsCtrl_SliderSection_1 != null && _loc4_ != null)
         {
            UnknownVarFromUserDefinedRoomEventsCtrl_SliderSection_1.value = _loc4_.delayInPulses;
         }
         var _loc2_:Boolean = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.advancedMode && (isUsingAdvancedSettings || UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.advancedAlwaysVisible());
         if(UnknownVarFromUserDefinedRoomEventsCtrl_AdvancedSettingsWrapperPreset_1 != null)
         {
            UnknownVarFromUserDefinedRoomEventsCtrl_AdvancedSettingsWrapperPreset_1.expanded = _loc2_;
         }
         var _loc6_:ConditionDefinition = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as ConditionDefinition;
         if(_loc6_ != null && _loc6_.quantifierType != UnknownHabboCommunicationMessagesIncomingUserdefinedroomevents1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomevents1_Int_1 && UnknownVarFromUserDefinedRoomEventsCtrl_RadioGroupPreset_1 != null)
         {
            UnknownVarFromUserDefinedRoomEventsCtrl_RadioGroupPreset_1.selected = _loc6_.quantifierCode;
            fixQuantifierNames();
         }
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1 != null)
         {
            for each(var _loc5_ in UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1)
            {
               _loc5_.refresh(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1,UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1);
               if(_loc5_.baseSourceType == WiredInputSourcePicker.MERGED_SOURCE)
               {
                  _loc5_.sourceType = UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.getMergedType(_loc5_.id);
               }
            }
         }
         UnknownVarFromUserDefinedRoomEventsCtrl_FooterPreset_1.saveButtonDisabled = !_roomEvents.wiredMenu.hasWritePermission;
         _frame.refreshForNewTriggerable();
      }
      
      private function get activeStuffsDictionary() : Dictionary
      {
         if(!UnknownVarFromUserDefinedRoomEventsCtrl_Boolean_1 || _activeFurniPicks == 1)
         {
            return _stuffs1;
         }
         return _stuffs2;
      }
      
      private function get activeStuffsArray() : Array
      {
         if(!UnknownVarFromUserDefinedRoomEventsCtrl_Boolean_1 || _activeFurniPicks == 1)
         {
            return getStuffIds();
         }
         return getStuffIds2();
      }
      
      public function set activeFurniPicks(param1:int) : void
      {
         _activeFurniPicks = param1;
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1 != null)
         {
            for each(var _loc2_ in UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1)
            {
               _loc2_.activeFurniPicksChanged();
            }
         }
      }
      
      public function get activeFurniPicks() : int
      {
         return _activeFurniPicks;
      }
      
      private function hideFurniHighlights() : void
      {
         UnknownVarFromUserDefinedRoomEventsCtrl_RoomObjectHighLighter_1.hideAll(_stuffs1,true,1);
         UnknownVarFromUserDefinedRoomEventsCtrl_RoomObjectHighLighter_1.hideAll(_stuffs2,true,2);
      }
      
      public function close() : void
      {
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 != null)
         {
            UnknownVarFromUserDefinedRoomEventsCtrl_RoomObjectHighLighter_1.unhighlightActiveWired(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.id);
            UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.onEditEnd();
            UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 = null;
            UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1 = null;
         }
         hideFurniHighlights();
         _stuffs1 = new Dictionary();
         _stuffs2 = new Dictionary();
         if(_frame)
         {
            savePosition();
            hideFrame();
            _headerPreset = null;
            UnknownVarFromUserDefinedRoomEventsCtrl_CheckboxGroupPreset_1 = null;
            UnknownVarFromUserDefinedRoomEventsCtrl_SectionPreset_1 = null;
            UnknownVarFromUserDefinedRoomEventsCtrl_SliderSection_1 = null;
            UnknownVarFromUserDefinedRoomEventsCtrl_FooterPreset_1 = null;
            UnknownVarFromUserDefinedRoomEventsCtrl_RadioGroupPreset_1 = null;
            UnknownVarFromUserDefinedRoomEventsCtrl_AdvancedSettingsWrapperPreset_1 = null;
            UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1 = null;
            _initialWidth = -1;
            if(!useCache)
            {
               _frame.dispose();
            }
            _frame = null;
         }
         if(_variablesCallback != null)
         {
            _roomEvents.variablesSynchronizer.removeListener(_variablesCallback);
            _variablesCallback = null;
         }
      }
      
      private function synchronizeTriggerable(param1:Triggerable) : Boolean
      {
         var synchronizer:WiredVariablesSynchronizer;
         var updated:Triggerable = param1;
         var variablesList:AllVariablesInRoom = updated.wiredContext.roomVariablesList;
         if(variablesList != null && variablesList.needsSynchronize)
         {
            synchronizer = _roomEvents.variablesSynchronizer;
            if(_variablesCallback != null)
            {
               synchronizer.removeListener(_variablesCallback);
            }
            _variablesCallback = function(param1:Vector.<WiredVariable>):void
            {
               _variablesCallback = null;
               updated.wiredContext.roomVariablesList.synchronize(param1);
               prepareForUpdate(updated);
            };
            synchronizer.getAllVariables(_variablesCallback,true,variablesList.hash);
            return true;
         }
         return false;
      }
      
      private function savePosition() : void
      {
         if(_frame == null)
         {
            return;
         }
         UnknownVarFromUserDefinedRoomEventsCtrl_Int_1 = _frame.window.x;
         UnknownVarFromUserDefinedRoomEventsCtrl_Int_2 = _frame.window.y;
      }
      
      private function restorePositionAndActivate() : void
      {
         if(_frame == null)
         {
            return;
         }
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Int_1 == -2147483648)
         {
            _frame.window.center();
         }
         else
         {
            _frame.window.x = UnknownVarFromUserDefinedRoomEventsCtrl_Int_1;
            _frame.window.y = UnknownVarFromUserDefinedRoomEventsCtrl_Int_2;
         }
         _frame.window.activate();
      }
      
      public function prepareForUpdate(param1:Triggerable) : void
      {
         var _loc4_:UnknownIHabboRoomeventsWired_Setup1 = null;
         var _loc6_:IDefaultElement = null;
         var _loc3_:Object = null;
         if(_frame != null && UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1 != null && _frame.isCopyingIntoMode)
         {
            _loc4_ = resolveHolderFor(param1);
            _loc6_ = _loc4_.getElementByCode(param1.code);
            if(_loc6_ == UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1)
            {
               update(2,param1.id);
            }
            else
            {
               _loc3_ = {};
               _loc3_["time_display"] = 2500;
               _roomEvents.notifications.addItem("${notification.wired.pasted_into_fail}","wired",null,null,_loc3_);
            }
            return;
         }
         if(synchronizeTriggerable(param1))
         {
            return;
         }
         if(_frame)
         {
            close();
         }
         UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 = param1;
         UnknownVarFromUserDefinedRoomEventsCtrl_Boolean_1 = param1.inputSourcesConf.isDualFurniPickingMode();
         _activeFurniPicks = 1;
         UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1 = resolveHolder().getElementByCode(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.code);
         _wiredStyle = determineActiveWiredStyle();
         if(!createWindow())
         {
            UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 = null;
            UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1 = null;
            return;
         }
         Logger.log("Received: " + UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 + ", " + param1.code);
         UnknownVarFromUserDefinedRoomEventsCtrl_RoomObjectHighLighter_1.highlightActiveWired(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.id);
         hideFurniHighlights();
         _stuffs1 = new Dictionary();
         _stuffs2 = new Dictionary();
         for each(var _loc2_ in UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.stuffIds)
         {
            _stuffs1[_loc2_] = true;
         }
         for each(var _loc5_ in UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.stuffIds2)
         {
            _stuffs2[_loc5_] = true;
         }
         UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.onEditStart(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1);
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Boolean_1)
         {
            UnknownVarFromUserDefinedRoomEventsCtrl_RoomObjectHighLighter_1.showAll(_stuffs1,true,1);
            UnknownVarFromUserDefinedRoomEventsCtrl_RoomObjectHighLighter_1.showAll(_stuffs2,true,2);
         }
         else
         {
            UnknownVarFromUserDefinedRoomEventsCtrl_RoomObjectHighLighter_1.showAll(_stuffs1,false,0);
         }
         onEditStartUpdateCommonUI();
         UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.onEditInitialized();
         restorePositionAndActivate();
      }
      
      public function get isUsingAdvancedSettings() : Boolean
      {
         return UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 && (UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.usingCustomInputSources || UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.usingCustomAdvancedSettings);
      }
      
      public function stuffRemoved(param1:int) : void
      {
         if(_frame == null || UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 == null)
         {
            return;
         }
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.id == param1)
         {
            close();
            return;
         }
         var _loc2_:Boolean = false;
         if(_stuffs1[param1])
         {
            delete _stuffs1[param1];
            _loc2_ = true;
         }
         if(_stuffs2[param1])
         {
            delete _stuffs2[param1];
            _loc2_ = true;
         }
         if(_loc2_)
         {
            onStuffsChanged();
         }
      }
      
      public function clearStuffPicks() : void
      {
         hideFurniHighlights();
         _stuffs1 = new Dictionary();
         _stuffs2 = new Dictionary();
         onStuffsChanged();
      }
      
      public function resetToDefault() : void
      {
         var _loc2_:int = 0;
         savePosition();
         UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.intParams = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.defaultIntParams.concat();
         UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.stringParam = "";
         var _loc5_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.variableIds)
         {
            _loc5_.push(0);
            _loc2_ += 1;
         }
         UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.variableIds = _loc5_;
         UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.stuffIds = [];
         UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.stuffIds2 = [];
         UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.furniSourceTypes = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.inputSourcesConf.defaultFurniSources.concat();
         UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.userSourceTypes = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.inputSourcesConf.defaultUserSources.concat();
         var _loc3_:ActionDefinition = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as ActionDefinition;
         var _loc1_:ConditionDefinition = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as ConditionDefinition;
         var _loc4_:SelectorDefinition = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as SelectorDefinition;
         if(_loc3_ != null)
         {
            _loc3_.delayInPulses = 0;
         }
         if(_loc1_ != null)
         {
            _loc1_.quantifierCode = 0;
         }
         if(_loc4_ != null)
         {
            _loc4_.isFilter = false;
            _loc4_.isInvert = false;
         }
         prepareForUpdate(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1);
         restorePositionAndActivate();
      }
      
      public function createClipboardCopy() : void
      {
         var _loc2_:UnknownIHabboRoomeventsWired_Setup1 = resolveHolder();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:String = _loc2_.getKey() + "-" + UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.code;
         var _loc3_:ClipboardWiredEntry = new ClipboardWiredEntry(UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.readIntParamsFromForm(),UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.readStringParamFromForm(),UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.readVariableIdsFromForm(),getStuffIds(),getStuffIds2(),UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.furniSourceTypes.concat(),UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.userSourceTypes.concat());
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 is ActionDefinition)
         {
            _loc3_.delayInPulses = getActionDelay();
         }
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 is ConditionDefinition)
         {
            _loc3_.quantifierCode = resolveQuantifier();
         }
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 is SelectorDefinition)
         {
            _loc3_.isFilter = isSelectorFilter();
            _loc3_.isInvert = isSelectorInvert();
         }
         UnknownVarFromUserDefinedRoomEventsCtrl_Dictionary_1[_loc4_] = _loc3_;
         _frame.updateButtonDisabledStates();
         var _loc1_:Object = {};
         _loc1_["time_display"] = 2500;
         _roomEvents.notifications.addItem("${notification.wired.copied}","wired",null,null,_loc1_);
      }
      
      public function pasteFromClipboard() : void
      {
         var _loc3_:UnknownIHabboRoomeventsWired_Setup1 = resolveHolder();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc6_:String = _loc3_.getKey() + "-" + UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.code;
         var _loc5_:ClipboardWiredEntry = UnknownVarFromUserDefinedRoomEventsCtrl_Dictionary_1[_loc6_];
         if(_loc5_ == null)
         {
            return;
         }
         savePosition();
         UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.intParams = _loc5_.intParams.concat();
         UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.stringParam = _loc5_.stringParam.concat();
         UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.variableIds = _loc5_.variableIds.concat();
         UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.stuffIds = _loc5_.stuffIds.concat();
         UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.stuffIds2 = _loc5_.stuffIds2.concat();
         UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.furniSourceTypes = _loc5_.furniSourceTypes.concat();
         UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.userSourceTypes = _loc5_.userSourceTypes.concat();
         var _loc2_:ActionDefinition = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as ActionDefinition;
         var _loc1_:ConditionDefinition = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as ConditionDefinition;
         var _loc4_:SelectorDefinition = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as SelectorDefinition;
         if(_loc2_ != null)
         {
            _loc2_.delayInPulses = _loc5_.delayInPulses;
         }
         if(_loc1_ != null)
         {
            _loc1_.quantifierCode = _loc5_.quantifierCode;
         }
         if(_loc4_ != null)
         {
            _loc4_.isFilter = _loc5_.isFilter;
            _loc4_.isInvert = _loc5_.isInvert;
         }
         prepareForUpdate(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1);
         restorePositionAndActivate();
      }
      
      public function hasCurrentElementInClipboard() : Boolean
      {
         var _loc1_:String = resolveHolder().getKey() + "-" + UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.code;
         return _loc1_ in UnknownVarFromUserDefinedRoomEventsCtrl_Dictionary_1;
      }
      
      private function onStuffsChanged() : void
      {
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 == null || _frame == null)
         {
            return;
         }
         var _loc3_:int = int(this.getStuffIds().length);
         var _loc1_:int = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.furniLimit;
         _roomEvents.localization.registerParameter("wiredfurni.pickfurnis.caption","count","" + _loc3_);
         _roomEvents.localization.registerParameter("wiredfurni.pickfurnis.caption","limit","" + _loc1_);
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1 != null)
         {
            for each(var _loc2_ in UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1)
            {
               _loc2_.refresh(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1,UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1);
            }
         }
         _frame.updateButtonDisabledStates();
      }
      
      private function save() : void
      {
         var _loc1_:Object = null;
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 == null || _frame == null)
         {
            return;
         }
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as SelectorDefinition != null && isSelectorInvert() && !isSelectorFilter())
         {
            _roomEvents.windowManager.confirm("${wiredfurni.danger.1.change.confirm.title}","${wiredfurni.danger.1.change.confirm.body}",0,confirmCallback);
         }
         else if(!isOwner(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.id) && !UnknownVarFromUserDefinedRoomEventsCtrl_Boolean_2)
         {
            update();
         }
         else
         {
            _loc1_ = UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.requireConfirmation;
            if(_loc1_ != null)
            {
               _roomEvents.windowManager.confirm(_loc1_.title,_loc1_.body,0,confirmCallback);
            }
            else
            {
               update();
            }
         }
      }
      
      private function isSelectorFilter() : Boolean
      {
         return UnknownVarFromUserDefinedRoomEventsCtrl_CheckboxGroupPreset_1 != null && UnknownVarFromUserDefinedRoomEventsCtrl_CheckboxGroupPreset_1.get(0).selected;
      }
      
      private function isSelectorInvert() : Boolean
      {
         return UnknownVarFromUserDefinedRoomEventsCtrl_CheckboxGroupPreset_1 != null && UnknownVarFromUserDefinedRoomEventsCtrl_CheckboxGroupPreset_1.get(1).selected;
      }
      
      private function isEditing() : Boolean
      {
         return UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1 != null && UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 != null && _frame != null;
      }
      
      private function confirmCallback(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            UnknownVarFromUserDefinedRoomEventsCtrl_Boolean_2 = true;
            if(isEditing())
            {
               update();
            }
         }
      }
      
      public function onSaveFailure() : void
      {
         if(_updateMode == 1)
         {
            _updateMode = 0;
         }
      }
      
      public function onSaveSuccess() : void
      {
         var _loc1_:Object = {};
         _loc1_["time_display"] = 2500;
         if(_updateMode == 0)
         {
            close();
         }
         else if(_updateMode == 1)
         {
            _roomEvents.notifications.addItem("${notification.wired.saved}","wired",null,null,_loc1_);
         }
         else if(_updateMode == 2)
         {
            _roomEvents.notifications.addItem("${notification.wired.pasted_into}","wired",null,null,_loc1_);
         }
         _updateMode = 0;
      }
      
      public function update(param1:int = 0, param2:int = -1) : void
      {
         var _loc3_:String = UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.validate();
         if(_loc3_ != null)
         {
            _roomEvents.windowManager.alert("${wiredfurni.error.title}",_loc3_,0,null);
            return;
         }
         _updateMode = param1;
         if(param2 == -1)
         {
            param2 = UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.id;
         }
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as TriggerDefinition != null)
         {
            _roomEvents.send(new UpdateTriggerMessageComposer(param2,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),getStuffIds2(),resolveFurniSources(),resolveUserSources()));
         }
         else if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as ActionDefinition != null)
         {
            _roomEvents.send(new UpdateActionMessageComposer(param2,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),getStuffIds2(),getActionDelay(),resolveFurniSources(),resolveUserSources()));
         }
         else if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as ConditionDefinition != null)
         {
            _roomEvents.send(new UpdateConditionMessageComposer(param2,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),getStuffIds2(),resolveQuantifier(),resolveFurniSources(),resolveUserSources()));
         }
         else if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as AddonDefinition != null)
         {
            _roomEvents.send(new UpdateAddonMessageComposer(param2,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),getStuffIds2(),resolveFurniSources(),resolveUserSources()));
         }
         else if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as SelectorDefinition != null)
         {
            _roomEvents.send(new UpdateSelectorMessageComposer(param2,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),getStuffIds2(),resolveFilterField(),resolveInverseField(),resolveFurniSources(),resolveUserSources()));
         }
         else if(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 as VariableDefinition != null)
         {
            _roomEvents.send(new UpdateVariableMessageComposer(param2,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),getStuffIds2(),resolveFurniSources(),resolveUserSources()));
         }
      }
      
      public function getActionDelay() : int
      {
         if(UnknownVarFromUserDefinedRoomEventsCtrl_SliderSection_1 == null)
         {
            return 0;
         }
         return UnknownVarFromUserDefinedRoomEventsCtrl_SliderSection_1.value;
      }
      
      private function applySnapshot() : void
      {
         _roomEvents.send(new ApplySnapshotMessageComposer(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.id));
      }
      
      private function viewVariableInMenu() : void
      {
         var _loc1_:INewDefaultVariableType = UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1 as INewDefaultVariableType;
         if(_loc1_ == null || _loc1_.initialVariableName.length == 0)
         {
            return;
         }
         _roomEvents.context.createLinkEvent("wiredmenu/open/variable_overview/" + _loc1_.initialVariableName);
      }
      
      private function viewLogs() : void
      {
         _roomEvents.context.createLinkEvent("wiredmenu/logs");
      }
      
      private function resolveIntParams() : Array
      {
         return UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.readIntParamsFromForm();
      }
      
      private function resolveVariableIds() : Array
      {
         return UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.readVariableIdsFromForm();
      }
      
      private function resolveStringParam() : String
      {
         return UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.readStringParamFromForm();
      }
      
      private function resolveFurniSources() : Array
      {
         return UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.furniSourceTypes;
      }
      
      private function resolveUserSources() : Array
      {
         return UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1.userSourceTypes;
      }
      
      public function getStuffIds() : Array
      {
         var _loc2_:Array = [];
         for(var _loc1_ in _stuffs1)
         {
            _loc2_.push(int(_loc1_));
         }
         return _loc2_;
      }
      
      public function getStuffIds2() : Array
      {
         var _loc1_:Array = [];
         for(var _loc2_ in _stuffs2)
         {
            _loc1_.push(int(_loc2_));
         }
         return _loc1_;
      }
      
      public function resolveQuantifier() : int
      {
         if(UnknownVarFromUserDefinedRoomEventsCtrl_RadioGroupPreset_1 == null)
         {
            return 0;
         }
         return UnknownVarFromUserDefinedRoomEventsCtrl_RadioGroupPreset_1.selected;
      }
      
      public function resolveFilterField() : Boolean
      {
         return isSelectorFilter();
      }
      
      public function resolveInverseField() : Boolean
      {
         return isSelectorInvert();
      }
      
      private function getElementName(param1:int) : String
      {
         var _loc2_:IFurnitureData = _roomEvents.sessionDataManager.getFloorItemData(param1);
         if(_loc2_ == null)
         {
            Logger.log("COULD NOT FIND FURNIDATA FOR " + param1);
            return "NAME: " + param1;
         }
         return _loc2_.localizedName;
      }
      
      private function isOwner(param1:int) : Boolean
      {
         var _loc4_:IRoomObject = _roomEvents.roomEngine.getRoomObject(_roomEvents.roomId,param1,10);
         if(_loc4_ == null)
         {
            return false;
         }
         var _loc3_:IRoomObjectModel = _loc4_.getModel();
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc2_:Number = _loc4_.getModel().getNumber("furniture_owner_id");
         return _loc2_ == _roomEvents.sessionDataManager.userId;
      }
      
      public function onGuildMemberships(param1:GuildMembershipsMessageEvent) : void
      {
         if(UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1 != null)
         {
            UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1.onGuildMemberships(param1);
         }
      }
      
      public function updateSourceContainer(param1:int, param2:int) : void
      {
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1 != null)
         {
            for each(var _loc3_ in UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1)
            {
               if(_loc3_.baseSourceType == param1 && _loc3_.id == param2)
               {
                  _loc3_.refresh(UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1,UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1);
               }
            }
         }
      }
      
      public function setMergedSourceType(param1:int, param2:int) : void
      {
         if(UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1 != null)
         {
            for each(var _loc3_ in UnknownVarFromUserDefinedRoomEventsCtrl_Vector_1)
            {
               if(_loc3_.id == param1 && _loc3_.baseSourceType == WiredInputSourcePicker.MERGED_SOURCE)
               {
                  _loc3_.sourceType = param2;
               }
            }
         }
      }
      
      public function get wiredStyle() : WiredStyle
      {
         return _wiredStyle;
      }
      
      public function setPreferredWiredStyleByName(param1:String) : void
      {
         if(param1 == UnknownVarFromUserDefinedRoomEventsCtrl_WiredStyle_1.name)
         {
            return;
         }
         var _loc2_:WiredStyle = _wiredStyles[param1];
         if(_loc2_ == null)
         {
            return;
         }
         clearCache();
         UnknownVarFromUserDefinedRoomEventsCtrl_WiredStyle_1 = _loc2_;
      }
      
      public function get presetManager() : PresetManager
      {
         return _presetManager;
      }
      
      private function get isResizeEnabled() : Boolean
      {
         return false;
      }
      
      private function get useCache() : Boolean
      {
         return true;
      }
      
      public function clearCache() : void
      {
         close();
         for each(var _loc1_ in _configurationCache)
         {
            _loc1_.frame.dispose();
         }
         _configurationCache = new Dictionary();
      }
      
      public function hasUIOpen() : Boolean
      {
         return UnknownVarFromUserDefinedRoomEventsCtrl_Triggerable_1 != null && UnknownVarFromUserDefinedRoomEventsCtrl_IDefaultElement_1 != null && _frame != null && _frame.window.parent != null;
      }
   }
}

