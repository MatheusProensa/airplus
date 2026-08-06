package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RedeemNftLootBoxStateMessageEventParser implements IMessageParser
   {
      private var _state:*;
      
      private var _openerAvatarId:int;
      
      private var _reward:CollectibleBaseItem;
      
      public function RedeemNftLootBoxStateMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _state = -1;
         _openerAvatarId = -1;
         _reward = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _state = param1.readShort();
         _openerAvatarId = param1.readInteger();
         _reward = new CollectibleBaseItem(param1);
         return true;
      }
      
      public function get start() : Boolean
      {
         return _state == 0;
      }
      
      public function get finish() : Boolean
      {
         return _state == 1;
      }
      
      public function get state() : *
      {
         return _state;
      }
      
      public function get openerAvatarId() : int
      {
         return _openerAvatarId;
      }
      
      public function get reward() : CollectibleBaseItem
      {
         return _reward;
      }
   }
}

