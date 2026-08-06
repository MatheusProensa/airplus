package com.sulake.habbo.messenger.habbicons
{
   public class MessengerHabbiconPickerEntry
   {
      public var habbiconId:int;
      
      public var name:String;
      
      public var searchName:String;
      
      public var favorite:Boolean;
      
      public function MessengerHabbiconPickerEntry(param1:int, param2:String, param3:Boolean)
      {
         super();
         this.habbiconId = param1;
         this.name = param2;
         this.searchName = param2 != null ? param2.toLowerCase() : "";
         this.favorite = param3;
      }
   }
}

