package com.sulake.habbo.communication.messages.parser.room.action
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AvatarEffectMessageParser implements IMessageParser
   {
      private var _userId:int = 0;
      
      private var _effectId:int = 0;
      
      private var _delayMilliSeconds:int = 0;
      
      public function AvatarEffectMessageParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get effectId() : int
      {
         return _effectId;
      }
      
      public function get delayMilliSeconds() : int
      {
         return _delayMilliSeconds;
      }
      
      public function flush() : Boolean
      {
         _userId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _userId = param1.readInteger();
         _effectId = param1.readInteger();
         _delayMilliSeconds = param1.readInteger();
         return true;
      }
   }
}

