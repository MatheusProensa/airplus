package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AvatarEffectAddedMessageParser implements IMessageParser
   {
      private var _type:int;
      
      private var _subType:int;
      
      private var _duration:int;
      
      private var _isPermanent:Boolean;
      
      public function AvatarEffectAddedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _type = 0;
         _subType = 0;
         _duration = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _type = param1.readInteger();
         _subType = param1.readInteger();
         _duration = param1.readInteger();
         _isPermanent = param1.readBoolean();
         return true;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get subType() : int
      {
         return _subType;
      }
      
      public function get duration() : int
      {
         return _duration;
      }
      
      public function get isPermanent() : Boolean
      {
         return _isPermanent;
      }
   }
}

