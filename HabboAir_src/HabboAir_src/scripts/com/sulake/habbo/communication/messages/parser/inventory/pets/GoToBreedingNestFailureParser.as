package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GoToBreedingNestFailureParser implements IMessageParser
   {
      public static const UnknownConstFromGoToBreedingNestFailureParser_Int_1:int = 6;
      
      private var _reason:int;
      
      public function GoToBreedingNestFailureParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _reason = param1.readInteger();
         return true;
      }
      
      public function get reason() : int
      {
         return _reason;
      }
   }
}

