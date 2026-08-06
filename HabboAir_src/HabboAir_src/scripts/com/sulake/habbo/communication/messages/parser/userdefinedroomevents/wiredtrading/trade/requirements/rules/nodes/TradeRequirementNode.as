package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.nodes
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.util.Byte;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestItemType;
   
   public class TradeRequirementNode
   {
      public static var TYPE_COIN:int = 0;
      
      public static var TYPE_FURNI:int = 1;
      
      private var _type:int;
      
      private var _amount:int;
      
      private var _itemType:ChestItemType = null;
      
      public function TradeRequirementNode(param1:int, param2:int, param3:ChestItemType = null)
      {
         super();
         _type = param1;
         _amount = param2;
         if(_type == TYPE_FURNI)
         {
            _itemType = param3;
         }
      }
      
      public static function readFromMessage(param1:IMessageDataWrapper) : TradeRequirementNode
      {
         var _loc4_:int = param1.readByte();
         var _loc2_:int = param1.readInteger();
         var _loc3_:ChestItemType = null;
         if(_loc4_ == TYPE_FURNI)
         {
            _loc3_ = ChestItemType.readFromMessage(param1);
         }
         return new TradeRequirementNode(_loc4_,_loc2_,_loc3_);
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get itemType() : ChestItemType
      {
         return _itemType;
      }
      
      public function addToComposer(param1:Array) : void
      {
         param1.push(new Byte(_type));
         param1.push(_amount);
         if(_type == TYPE_FURNI)
         {
            _itemType.addToComposer(param1);
         }
      }
      
      public function deepCopy() : TradeRequirementNode
      {
         return new TradeRequirementNode(_type,_amount,_itemType);
      }
   }
}

