package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.nodes.TradeRequirementNode;
   
   public class TradeRequirementRule
   {
      private var _nodes:Vector.<TradeRequirementNode>;
      
      public function TradeRequirementRule(param1:Vector.<TradeRequirementNode>)
      {
         super();
         _nodes = param1;
      }
      
      public static function readFromMessage(param1:IMessageDataWrapper) : TradeRequirementRule
      {
         var _loc4_:int = 0;
         var _loc2_:Vector.<TradeRequirementNode> = new Vector.<TradeRequirementNode>();
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_.push(TradeRequirementNode.readFromMessage(param1));
            _loc4_ += 1;
         }
         return new TradeRequirementRule(_loc2_);
      }
      
      public function get nodes() : Vector.<TradeRequirementNode>
      {
         return _nodes;
      }
      
      public function addToComposer(param1:Array) : void
      {
         param1.push(_nodes.length as int);
         for each(var _loc2_ in _nodes)
         {
            _loc2_.addToComposer(param1);
         }
      }
      
      public function deepCopy() : TradeRequirementRule
      {
         var _loc1_:Vector.<TradeRequirementNode> = new Vector.<TradeRequirementNode>();
         for each(var _loc2_ in this._nodes)
         {
            _loc1_.push(_loc2_.deepCopy());
         }
         return new TradeRequirementRule(_loc1_);
      }
   }
}

