package com.sulake.habbo.roomevents.wired_setup
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public interface IDefaultElement
   {
      function get code() : int;
      
      function get negativeCode() : int;
      
      function setRoomEvents(param1:HabboUserDefinedRoomEvents) : void;
      
      function onInit(param1:HabboUserDefinedRoomEvents) : void;
      
      function onEditStart(param1:Triggerable) : void;
      
      function onEditInitialized() : void;
      
      function onEditEnd() : void;
      
      function readIntParamsFromForm() : Array;
      
      function readVariableIdsFromForm() : Array;
      
      function readStringParamFromForm() : String;
      
      function get hasStateSnapshot() : Boolean;
      
      function validate() : String;
      
      function get inputMode() : int;
      
      function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void;
      
      function furniSelectionTitle(param1:int) : String;
      
      function userSelectionTitle(param1:int) : String;
      
      function get forceFurniSelection() : Boolean;
      
      function mergedSelections() : Array;
      
      function mergedSelectionTitle(param1:int) : String;
      
      function setMergedType(param1:int, param2:int) : void;
      
      function getMergedType(param1:int) : int;
      
      function mergedSourceOptions(param1:int) : Array;
      
      function hasCustomTypePicker(param1:int) : Boolean;
      
      function isInputSourceDisabled(param1:int, param2:int) : Boolean;
      
      function getCustomSourcesForMergedType(param1:int) : Array;
      
      function get forceHidePickFurniInstructions() : Boolean;
      
      function advancedAlwaysVisible() : Boolean;
      
      function get usingCustomAdvancedSettings() : Boolean;
      
      function onGuildMemberships(param1:GuildMembershipsMessageEvent) : void;
      
      function get requireConfirmation() : Object;
      
      function get roomEvents() : HabboUserDefinedRoomEvents;
      
      function get widthModifier() : Number;
      
      function get allowScrolling() : Boolean;
   }
}

