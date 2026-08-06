package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FlatControllerRemovedMessageParser implements IMessageParser
   {
      private var _flatId:int;
      
      private var _userId:int;
      
      public function FlatControllerRemovedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._flatId = param1.readInteger();
         this._userId = param1.readInteger();
         return true;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
   }
}

