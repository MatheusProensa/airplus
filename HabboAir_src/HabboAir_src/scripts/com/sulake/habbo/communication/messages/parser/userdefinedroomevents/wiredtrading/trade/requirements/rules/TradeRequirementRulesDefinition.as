package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class TradeRequirementRulesDefinition
   {
      private var _youGiveRule:Vector.<TradeRequirementRule> = null;
      
      private var _youGetRule:TradeRequirementRule = null;
      
      public function TradeRequirementRulesDefinition(param1:Vector.<TradeRequirementRule>, param2:TradeRequirementRule)
      {
         super();
         _youGiveRule = param1;
         _youGetRule = param2;
      }
      
      public static function readFromMessage(param1:IMessageDataWrapper) : TradeRequirementRulesDefinition
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Vector.<TradeRequirementRule> = null;
         var _loc5_:TradeRequirementRule = null;
         if(param1.readBoolean())
         {
            _loc2_ = new Vector.<TradeRequirementRule>();
            _loc3_ = param1.readInteger();
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_.push(TradeRequirementRule.readFromMessage(param1));
               _loc4_ += 1;
            }
         }
         if(param1.readBoolean())
         {
            _loc5_ = TradeRequirementRule.readFromMessage(param1);
         }
         return new TradeRequirementRulesDefinition(_loc2_,_loc5_);
      }
      
      public function get youGiveRule() : Vector.<TradeRequirementRule>
      {
         return _youGiveRule;
      }
      
      public function get youGetRule() : TradeRequirementRule
      {
         return _youGetRule;
      }
      
      public function addToComposer(param1:Array) : void
      {
         param1.push(_youGiveRule != null);
         if(_youGiveRule != null)
         {
            param1.push(_youGiveRule.length as int);
            for each(var _loc2_ in _youGiveRule)
            {
               _loc2_.addToComposer(param1);
            }
         }
         param1.push(_youGetRule != null);
         if(_youGetRule != null)
         {
            _youGetRule.addToComposer(param1);
         }
      }
      
      public function deepCopy() : TradeRequirementRulesDefinition
      {
         var _loc1_:Vector.<TradeRequirementRule> = null;
         var _loc3_:TradeRequirementRule = null;
         if(_youGiveRule != null)
         {
            _loc1_ = new Vector.<TradeRequirementRule>();
            for each(var _loc2_ in _youGiveRule)
            {
               _loc1_.push(_loc2_.deepCopy());
            }
         }
         if(_youGetRule != null)
         {
            _loc3_ = _youGetRule.deepCopy();
         }
         return new TradeRequirementRulesDefinition(_loc1_,_loc3_);
      }
   }
}

