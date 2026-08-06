package com.sulake.habbo.ui.widget.chatinput.habbiconselector
{
   public class HabbiconSelectorEntry
   {
      public var habbiconId:int;
      
      public var name:String;
      
      public var searchName:String;
      
      public var color:uint;
      
      public var favorite:Boolean;
      
      public function HabbiconSelectorEntry(param1:int, param2:String, param3:uint, param4:Boolean)
      {
         super();
         this.habbiconId = param1;
         this.name = param2;
         this.searchName = param2 != null ? param2.toLowerCase() : "";
         this.color = param3;
         this.favorite = param4;
      }
   }
}

