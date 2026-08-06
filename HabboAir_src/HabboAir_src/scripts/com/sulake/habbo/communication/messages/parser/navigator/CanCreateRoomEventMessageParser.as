package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CanCreateRoomEventMessageParser implements IMessageParser
   {
      private var _canCreateEvent:Boolean;
      
      private var _errorCode:int;
      
      public function CanCreateRoomEventMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._canCreateEvent = param1.readBoolean();
         this._errorCode = param1.readInteger();
         return true;
      }
      
      public function get canCreateEvent() : Boolean
      {
         return _canCreateEvent;
      }
      
      public function get errorCode() : int
      {
         return _errorCode;
      }
   }
}

