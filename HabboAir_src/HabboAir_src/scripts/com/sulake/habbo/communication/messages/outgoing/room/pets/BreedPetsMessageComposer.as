package com.sulake.habbo.communication.messages.outgoing.room.pets
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class BreedPetsMessageComposer implements IMessageComposer
   {
      public static const UnknownConstFromBreedPetsMessageComposer_Int_1:int = 0;
      
      public static const UnknownConstFromBreedPetsMessageComposer_Int_2:int = 1;
      
      public static const UnknownConstFromBreedPetsMessageComposer_Int_3:int = 2;
      
      private var _messageArray:Array = [];
      
      public function BreedPetsMessageComposer(param1:int, param2:int, param3:int)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param2);
         _messageArray.push(param3);
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
      
      public function dispose() : void
      {
         _messageArray = null;
      }
   }
}

