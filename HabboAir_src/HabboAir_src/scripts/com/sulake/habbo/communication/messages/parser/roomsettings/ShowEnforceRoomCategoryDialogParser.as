package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ShowEnforceRoomCategoryDialogParser implements IMessageParser
   {
      private var _selectionType:int;
      
      public function ShowEnforceRoomCategoryDialogParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _selectionType = param1.readInteger();
         return true;
      }
      
      public function get selectionType() : int
      {
         return _selectionType;
      }
   }
}

