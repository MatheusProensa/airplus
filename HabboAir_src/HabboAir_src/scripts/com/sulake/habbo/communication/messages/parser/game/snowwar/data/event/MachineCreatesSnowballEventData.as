package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class MachineCreatesSnowballEventData extends SnowWarGameEventData
   {
      private var _snowBallMachineReference:int;
      
      public function MachineCreatesSnowballEventData(param1:int)
      {
         super(param1);
      }
      
      public function get snowBallMachineReference() : int
      {
         return _snowBallMachineReference;
      }
      
      override public function parse(param1:IMessageDataWrapper) : void
      {
         _snowBallMachineReference = param1.readInteger();
      }
   }
}

