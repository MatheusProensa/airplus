package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ConfirmBreedingResultParser implements IMessageParser
   {
      private var _breedingNestStuffId:int;
      
      private var _result:int;
      
      public function ConfirmBreedingResultParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _breedingNestStuffId = 0;
         _result = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _breedingNestStuffId = param1.readInteger();
         _result = param1.readInteger();
         return true;
      }
      
      public function get breedingNestStuffId() : int
      {
         return _breedingNestStuffId;
      }
      
      public function get result() : int
      {
         return _result;
      }
   }
}

