package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class HumanStartsToMakeASnowballEventData extends SnowWarGameEventData
   {
      private var _humanGameObjectId:int;
      
      public function HumanStartsToMakeASnowballEventData(param1:int)
      {
         super(param1);
      }
      
      public function get humanGameObjectId() : int
      {
         return _humanGameObjectId;
      }
      
      override public function parse(param1:IMessageDataWrapper) : void
      {
         _humanGameObjectId = param1.readInteger();
      }
   }
}

