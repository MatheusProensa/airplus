package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffect;
   
   [SecureSWF(rename="true")]
   public class AvatarEffectsMessageParser implements IMessageParser
   {
      private var _effects:Array;
      
      public function AvatarEffectsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _effects = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:AvatarEffect = null;
         _effects = [];
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new AvatarEffect();
            _loc2_.type = param1.readInteger();
            _loc2_.subType = param1.readInteger();
            _loc2_.duration = param1.readInteger();
            _loc2_.inactiveEffectsInInventory = param1.readInteger();
            _loc2_.secondsLeftIfActive = param1.readInteger();
            _loc2_.isPermanent = param1.readBoolean();
            _effects.push(_loc2_);
            _loc4_++;
         }
         return true;
      }
      
      public function get effects() : Array
      {
         return _effects;
      }
   }
}

