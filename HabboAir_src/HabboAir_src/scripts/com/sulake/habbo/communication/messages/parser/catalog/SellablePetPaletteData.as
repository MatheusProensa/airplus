package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class SellablePetPaletteData
   {
      private var _type:int;
      
      private var _breedId:int;
      
      private var _paletteId:int;
      
      private var _sellable:Boolean;
      
      private var _rare:Boolean;
      
      public function SellablePetPaletteData(param1:IMessageDataWrapper)
      {
         super();
         _type = param1.readInteger();
         _breedId = param1.readInteger();
         _paletteId = param1.readInteger();
         _sellable = param1.readBoolean();
         _rare = param1.readBoolean();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get breedId() : int
      {
         return _breedId;
      }
      
      public function get paletteId() : int
      {
         return _paletteId;
      }
      
      public function get sellable() : Boolean
      {
         return _sellable;
      }
      
      public function get rare() : Boolean
      {
         return _rare;
      }
   }
}

