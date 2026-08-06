package com.sulake.habbo.sound.trax
{
   public class TraxChannel
   {
      private var UnknownVarFromTraxChannel_Int_1:int;
      
      private var _items:Array;
      
      public function TraxChannel(param1:int)
      {
         super();
         UnknownVarFromTraxChannel_Int_1 = param1;
         _items = [];
      }
      
      public function get itemCount() : int
      {
         return _items.length;
      }
      
      public function addChannelItem(param1:TraxChannelItem) : void
      {
         _items.push(param1);
      }
      
      public function getItem(param1:int) : TraxChannelItem
      {
         return _items[param1] as TraxChannelItem;
      }
   }
}

