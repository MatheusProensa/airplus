package com.sulake.habbo.roomevents.wired_setup
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   
   public interface UnknownIHabboRoomeventsWired_Setup1
   {
      function getElementByCode(param1:int) : IDefaultElement;
      
      function getKey() : String;
      
      function acceptTriggerable(param1:Triggerable) : Boolean;
   }
}

