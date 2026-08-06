package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class SpecialRoomEffectMessageParser implements IMessageParser
   {
      private var _effectId:int = -1;
      
      public function SpecialRoomEffectMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _effectId = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _effectId = param1.readInteger();
         return true;
      }
      
      public function get effectId() : int
      {
         return _effectId;
      }
   }
}

