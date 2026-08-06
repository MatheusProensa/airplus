package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class HumanThrowsSnowballAtHumanEventData extends SnowWarGameEventData
   {
      private var _humanGameObjectId:int;
      
      private var _targetHumanGameObjectId:int;
      
      private var _trajectory:int;
      
      public function HumanThrowsSnowballAtHumanEventData(param1:int)
      {
         super(param1);
      }
      
      public function get humanGameObjectId() : int
      {
         return _humanGameObjectId;
      }
      
      public function get targetHumanGameObjectId() : int
      {
         return _targetHumanGameObjectId;
      }
      
      public function get trajectory() : int
      {
         return _trajectory;
      }
      
      override public function parse(param1:IMessageDataWrapper) : void
      {
         _humanGameObjectId = param1.readInteger();
         _targetHumanGameObjectId = param1.readInteger();
         _trajectory = param1.readInteger();
      }
   }
}

