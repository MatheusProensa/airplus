package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class SnowWarGameEventData
   {
      public static const UnknownConstFromSnowWarGameEventData_Int_1:int = 1;
      
      public static const UnknownConstFromSnowWarGameEventData_Int_2:int = 2;
      
      public static const UnknownConstFromSnowWarGameEventData_Int_3:int = 3;
      
      public static const UnknownConstFromSnowWarGameEventData_Int_4:int = 4;
      
      public static const UnknownConstFromSnowWarGameEventData_Int_5:int = 7;
      
      public static const UnknownConstFromSnowWarGameEventData_Int_6:int = 8;
      
      public static const UnknownConstFromSnowWarGameEventData_Int_7:int = 11;
      
      public static const UnknownConstFromSnowWarGameEventData_Int_8:int = 12;
      
      private var _id:int;
      
      public function SnowWarGameEventData(param1:int)
      {
         super();
         _id = param1;
      }
      
      public static function create(param1:int) : SnowWarGameEventData
      {
         switch(param1 - 1)
         {
            case 0:
               return new HumanLeftGameEventData(param1);
            case 1:
               return new NewMoveTargetEventData(param1);
            case 2:
               return new HumanThrowsSnowballAtHumanEventData(param1);
            case 3:
               return new HumanThrowsSnowballAtPositionEventData(param1);
            case 6:
               return new HumanStartsToMakeASnowballEventData(param1);
            case 7:
               return new CreateSnowballEventData(param1);
            case 10:
               return new MachineCreatesSnowballEventData(param1);
            case 11:
               return new HumanGetsSnowballsFromMachineEventData(param1);
            default:
               return null;
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
      }
   }
}

