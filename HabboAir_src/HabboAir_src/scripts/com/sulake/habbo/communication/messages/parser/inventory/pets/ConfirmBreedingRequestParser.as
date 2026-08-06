package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.pets.BreedingPetInfo;
   import com.sulake.habbo.communication.messages.incoming.room.pets.RarityCategoryData;
   
   [SecureSWF(rename="true")]
   public class ConfirmBreedingRequestParser implements IMessageParser
   {
      private var _nestId:int;
      
      private var _pet1:BreedingPetInfo;
      
      private var _pet2:BreedingPetInfo;
      
      private var _rarityCategories:Array;
      
      private var _resultPetType:int;
      
      public function ConfirmBreedingRequestParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _nestId = 0;
         if(_pet1)
         {
            _pet1.dispose();
            _pet1 = null;
         }
         if(_pet2)
         {
            _pet2.dispose();
            _pet2 = null;
         }
         for each(var _loc1_ in _rarityCategories)
         {
            _loc1_.dispose();
         }
         _rarityCategories = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         _nestId = param1.readInteger();
         _pet1 = new BreedingPetInfo(param1);
         _pet2 = new BreedingPetInfo(param1);
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _rarityCategories.push(new RarityCategoryData(param1));
            _loc2_++;
         }
         _resultPetType = param1.readInteger();
         return true;
      }
      
      public function get nestId() : int
      {
         return _nestId;
      }
      
      public function get pet1() : BreedingPetInfo
      {
         return _pet1;
      }
      
      public function get pet2() : BreedingPetInfo
      {
         return _pet2;
      }
      
      public function get rarityCategories() : Array
      {
         return _rarityCategories;
      }
      
      public function get resultPetType() : int
      {
         return _resultPetType;
      }
   }
}

