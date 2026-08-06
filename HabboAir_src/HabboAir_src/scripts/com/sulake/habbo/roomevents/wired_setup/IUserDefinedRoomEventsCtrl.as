package com.sulake.habbo.roomevents.wired_setup
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public interface IUserDefinedRoomEventsCtrl
   {
      function stuffAdded(param1:int) : void;
      
      function stuffSelected(param1:int) : void;
      
      function stuffRemoved(param1:int) : void;
      
      function getStuffIds() : Array;
      
      function getStuffIds2() : Array;
      
      function clearStuffPicks() : void;
      
      function resetToDefault() : void;
      
      function createClipboardCopy() : void;
      
      function pasteFromClipboard() : void;
      
      function hasCurrentElementInClipboard() : Boolean;
      
      function set activeFurniPicks(param1:int) : void;
      
      function get activeFurniPicks() : int;
      
      function resizeFrame() : void;
      
      function setMergedSourceType(param1:int, param2:int) : void;
      
      function updateSourceContainer(param1:int, param2:int) : void;
      
      function get hidePickFurniInstructions() : Boolean;
      
      function close() : void;
      
      function prepareForUpdate(param1:Triggerable) : void;
      
      function get isUsingAdvancedSettings() : Boolean;
      
      function get wiredStyle() : WiredStyle;
      
      function get presetManager() : PresetManager;
      
      function getStyleByName(param1:String) : WiredStyle;
      
      function setPreferredWiredStyleByName(param1:String) : void;
      
      function onSaveFailure() : void;
      
      function onSaveSuccess() : void;
      
      function update(param1:int = 0, param2:int = -1) : void;
      
      function onGuildMemberships(param1:GuildMembershipsMessageEvent) : void;
      
      function clearCache() : void;
      
      function hasUIOpen() : Boolean;
   }
}

