package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class PetFigureData
   {
      private var _typeId:int;
      
      private var _paletteId:int;
      
      private var _color:String;
      
      private var _breedId:int;
      
      private var _customPartCount:int;
      
      private var _customParts:Array;
      
      public function PetFigureData(param1:IMessageDataWrapper)
      {
         var _loc2_:int = 0;
         super();
         _typeId = param1.readInteger();
         _paletteId = param1.readInteger();
         _color = param1.readString();
         _breedId = param1.readInteger();
         _customParts = [];
         _customPartCount = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _customPartCount)
         {
            _customParts.push(param1.readInteger());
            _customParts.push(param1.readInteger());
            _customParts.push(param1.readInteger());
            _loc2_++;
         }
      }
      
      public function get typeId() : int
      {
         return _typeId;
      }
      
      public function get paletteId() : int
      {
         return _paletteId;
      }
      
      public function get color() : String
      {
         return _color;
      }
      
      public function get breedId() : int
      {
         return _breedId;
      }
      
      public function get figureString() : String
      {
         var _loc2_:String = typeId + " " + paletteId + " " + color;
         _loc2_ += " " + customPartCount;
         for each(var _loc1_ in customParts)
         {
            _loc2_ += " " + _loc1_;
         }
         return _loc2_;
      }
      
      public function get customParts() : Array
      {
         return _customParts;
      }
      
      public function get customPartCount() : int
      {
         return _customPartCount;
      }
   }
}

