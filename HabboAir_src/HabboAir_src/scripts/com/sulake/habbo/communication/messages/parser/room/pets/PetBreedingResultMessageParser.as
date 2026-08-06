package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetBreedingResultData;
   
   [SecureSWF(rename="true")]
   public class PetBreedingResultMessageParser implements IMessageParser
   {
      private var _resultData:PetBreedingResultData;
      
      private var _otherResultData:PetBreedingResultData;
      
      public function PetBreedingResultMessageParser()
      {
         super();
      }
      
      public function get resultData() : PetBreedingResultData
      {
         return _resultData;
      }
      
      public function get otherResultData() : PetBreedingResultData
      {
         return _otherResultData;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      private function parseResultData(param1:IMessageDataWrapper) : PetBreedingResultData
      {
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         var _loc4_:String = param1.readString();
         var _loc7_:int = param1.readInteger();
         var _loc6_:String = param1.readString();
         var _loc5_:int = param1.readInteger();
         var _loc8_:Boolean = param1.readBoolean();
         return new PetBreedingResultData(_loc2_,_loc3_,_loc4_,_loc7_,_loc6_,_loc5_,_loc8_);
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _resultData = parseResultData(param1);
         _otherResultData = parseResultData(param1);
         return true;
      }
   }
}

