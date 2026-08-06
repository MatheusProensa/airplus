package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetBreedingMessageParser implements IMessageParser
   {
      public static const UnknownConstFromBreedPetsMessageComposer_Int_2:int = 1;
      
      public static const UnknownConstFromBreedPetsMessageComposer_Int_3:int = 2;
      
      public static const UnknownConstFromPetBreedingMessageParser_Int_1:int = 3;
      
      private var _state:int;
      
      private var _ownPetId:int;
      
      private var _otherPetId:int;
      
      public function PetBreedingMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _state = param1.readInteger();
         _ownPetId = param1.readInteger();
         _otherPetId = param1.readInteger();
         return true;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get ownPetId() : int
      {
         return _ownPetId;
      }
      
      public function get otherPetId() : int
      {
         return _otherPetId;
      }
   }
}

