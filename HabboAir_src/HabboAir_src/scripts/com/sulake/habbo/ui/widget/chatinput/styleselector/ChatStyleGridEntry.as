package com.sulake.habbo.ui.widget.chatinput.styleselector
{
   import flash.display.BitmapData;
   
   public class ChatStyleGridEntry
   {
      private var _id:int;
      
      private var _bitmap:BitmapData;
      
      public function ChatStyleGridEntry(param1:int, param2:BitmapData)
      {
         super();
         _id = param1;
         _bitmap = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get bitmap() : BitmapData
      {
         return _bitmap;
      }
   }
}

