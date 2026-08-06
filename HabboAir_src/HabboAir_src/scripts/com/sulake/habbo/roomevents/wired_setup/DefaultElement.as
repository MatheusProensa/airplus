package com.sulake.habbo.roomevents.wired_setup
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.IWiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class DefaultElement implements IDefaultElement
   {
      public static var INPUTS_TYPE_NONE:int = 0;
      
      public static var INPUTS_TYPE_UI_BUILDER:int = 1;
      
      private var _cont:IWindowController_1;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var UnknownVarFromDefaultElement_Boolean_1:Boolean = false;
      
      public function DefaultElement()
      {
         super();
      }
      
      public function get code() : int
      {
         return -1;
      }
      
      public function get negativeCode() : int
      {
         return -1;
      }
      
      public function get hasStateSnapshot() : Boolean
      {
         return false;
      }
      
      public function readIntParamsFromForm() : Array
      {
         return [];
      }
      
      public function readVariableIdsFromForm() : Array
      {
         return [];
      }
      
      public function readStringParamFromForm() : String
      {
         return "";
      }
      
      public function setRoomEvents(param1:HabboUserDefinedRoomEvents) : void
      {
         _roomEvents = param1;
      }
      
      public function onInit(param1:HabboUserDefinedRoomEvents) : void
      {
         _roomEvents = param1;
         UnknownVarFromDefaultElement_Boolean_1 = true;
      }
      
      public function onEditStart(param1:Triggerable) : void
      {
      }
      
      public function onEditInitialized() : void
      {
      }
      
      public function onEditEnd() : void
      {
      }
      
      public function validate() : String
      {
         return null;
      }
      
      public function onGuildMemberships(param1:GuildMembershipsMessageEvent) : void
      {
      }
      
      public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title";
      }
      
      public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title";
      }
      
      public function get forceFurniSelection() : Boolean
      {
         return hasStateSnapshot;
      }
      
      public function mergedSelections() : Array
      {
         return [];
      }
      
      public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title";
      }
      
      public function setMergedType(param1:int, param2:int) : void
      {
      }
      
      public function getMergedType(param1:int) : int
      {
         return 0;
      }
      
      public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         return false;
      }
      
      public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [];
      }
      
      public function get forceHidePickFurniInstructions() : Boolean
      {
         return false;
      }
      
      public function advancedAlwaysVisible() : Boolean
      {
         return false;
      }
      
      public function get usingCustomAdvancedSettings() : Boolean
      {
         return false;
      }
      
      public function get requireConfirmation() : Object
      {
         return null;
      }
      
      public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
      }
      
      public function get inputMode() : int
      {
         return INPUTS_TYPE_NONE;
      }
      
      public function mergedSourceOptions(param1:int) : Array
      {
         var _loc3_:Array = [WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1,WiredInputSourcePicker.USER_SOURCE];
         for each(var _loc2_ in getCustomSourcesForMergedType(param1))
         {
            if(!(!_roomEvents.getBoolean("wired.variables.context_visible") && _loc2_ == VariableExtraSourceTypes.CONTEXT_SOURCE && getMergedType(param1) != VariableExtraSourceTypes.CONTEXT_SOURCE))
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function hasCustomTypePicker(param1:int) : Boolean
      {
         return false;
      }
      
      protected function createSourceTypeListener(param1:int) : IWiredInputSourcePicker
      {
         return new WrappedSourceTypeListener(this,param1);
      }
      
      protected function get cont() : IWindowController_1
      {
         return _cont;
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      protected function get roomEventsCtrl() : IUserDefinedRoomEventsCtrl
      {
         return _roomEvents.wiredCtrl;
      }
      
      protected function loc(param1:String) : String
      {
         return _roomEvents.localization.getLocalization(param1,param1);
      }
      
      protected function l(param1:String) : String
      {
         return "${wiredfurni.params." + param1 + "}";
      }
      
      public function get widthModifier() : Number
      {
         return 1;
      }
      
      public function get allowScrolling() : Boolean
      {
         return false;
      }
   }
}

