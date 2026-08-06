package com.sulake.habbo.inventory.wired_trading.requirements
{
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestItemType;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.TradeRequirement;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.TradeRequirementRule;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.nodes.TradeRequirementNode;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import flash.utils.Dictionary;
   
   public class TradeRequirementWrapper
   {
      private var _requirements:TradeRequirement;
      
      private var _canOfferCreditFurni:Boolean = false;
      
      private var UnknownVarFromTradeRequirementWrapper_Dictionary_1:Dictionary = null;
      
      private var UnknownVarFromTradeRequirementWrapper_Dictionary_2:Dictionary = null;
      
      private var UnknownVarFromTradeRequirementWrapper_Dictionary_3:Dictionary = null;
      
      public function TradeRequirementWrapper(param1:TradeRequirement)
      {
         var _loc3_:ChestItemType = null;
         super();
         _requirements = param1;
         if(_requirements.rules != null && _requirements.rules.youGiveRule != null)
         {
            UnknownVarFromTradeRequirementWrapper_Dictionary_1 = new Dictionary();
            UnknownVarFromTradeRequirementWrapper_Dictionary_2 = new Dictionary();
            UnknownVarFromTradeRequirementWrapper_Dictionary_3 = new Dictionary();
            for each(var _loc4_ in _requirements.rules.youGiveRule)
            {
               for each(var _loc2_ in _loc4_.nodes)
               {
                  if(_loc2_.type == TradeRequirementNode.TYPE_COIN)
                  {
                     _canOfferCreditFurni = true;
                  }
                  else if(_loc2_.type == TradeRequirementNode.TYPE_FURNI)
                  {
                     _loc3_ = _loc2_.itemType;
                     if(!_loc3_.isWallItem)
                     {
                        UnknownVarFromTradeRequirementWrapper_Dictionary_2[_loc3_.typeId] = true;
                     }
                     else
                     {
                        if(_loc3_.legacyPosterId.length > 0)
                        {
                           UnknownVarFromTradeRequirementWrapper_Dictionary_3[_loc3_.legacyPosterId] = true;
                        }
                        UnknownVarFromTradeRequirementWrapper_Dictionary_1[_loc3_.typeId] = true;
                     }
                  }
               }
            }
         }
      }
      
      public function get type() : int
      {
         return _requirements.type;
      }
      
      public function get requirements() : TradeRequirement
      {
         return _requirements;
      }
      
      public function canOfferCreditFurni() : Boolean
      {
         return _canOfferCreditFurni;
      }
      
      public function canOfferNormalFurni(param1:GroupItem) : Boolean
      {
         if(UnknownVarFromTradeRequirementWrapper_Dictionary_1 == null || UnknownVarFromTradeRequirementWrapper_Dictionary_2 == null || UnknownVarFromTradeRequirementWrapper_Dictionary_3 == null)
         {
            return false;
         }
         var _loc2_:FurnitureItem = param1.peek();
         if(_loc2_ == null)
         {
            return false;
         }
         if(!_loc2_.isWallItem)
         {
            return _loc2_.type in UnknownVarFromTradeRequirementWrapper_Dictionary_2;
         }
         if(_loc2_.category == 6 && !(_loc2_.stuffData.getLegacyString() in UnknownVarFromTradeRequirementWrapper_Dictionary_3))
         {
            return false;
         }
         return _loc2_.type in UnknownVarFromTradeRequirementWrapper_Dictionary_1;
      }
   }
}

