package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.ShowEnforceRoomCategoryDialogParser;
   
   [SecureSWF(rename="true")]
   public class ShowEnforceRoomCategoryDialogEvent extends MessageEvent implements IMessageEvent
   {
      public function ShowEnforceRoomCategoryDialogEvent(param1:Function)
      {
         super(param1,ShowEnforceRoomCategoryDialogParser);
      }
      
      public function getParser() : ShowEnforceRoomCategoryDialogParser
      {
         return this._parser as ShowEnforceRoomCategoryDialogParser;
      }
   }
}

