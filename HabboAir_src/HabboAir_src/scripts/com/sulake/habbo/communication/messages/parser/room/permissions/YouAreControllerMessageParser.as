package com.sulake.habbo.communication.messages.parser.room.permissions
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class YouAreControllerMessageParser implements IMessageParser
   {
      private var _flatId:int = 0;
      
      private var _roomControllerLevel:int = 0;
      
      public function YouAreControllerMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         this._flatId = param1.readInteger();
         this._roomControllerLevel = param1.readInteger();
         return true;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get roomControllerLevel() : int
      {
         return _roomControllerLevel;
      }
   }
}

