package com.sulake.habbo.communication.messages.parser.game.snowwar.data.object
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class SnowballMachineGameObjectData extends SnowWarGameObjectData
   {
      public static const UnknownConstFromHumanGameObjectData_Int_1:int = 8;
      
      public function SnowballMachineGameObjectData(param1:int, param2:int)
      {
         super(param1,param2);
      }
      
      override public function parse(param1:IMessageDataWrapper) : void
      {
         parseVariables(param1,8);
      }
      
      public function get locationX3D() : int
      {
         return getVariable(2);
      }
      
      public function get locationY3D() : int
      {
         return getVariable(3);
      }
      
      public function get direction() : int
      {
         return getVariable(4);
      }
      
      public function get maxSnowballs() : int
      {
         return getVariable(5);
      }
      
      public function get snowballCount() : int
      {
         return getVariable(6);
      }
      
      public function get fuseObjectId() : int
      {
         return getVariable(7);
      }
   }
}

