package com.sulake.habbo.communication.messages.incoming.sound
{
   [SecureSWF(rename="true")]
   public class SongInfoEntry extends PlayListEntry
   {
      private var _data:String = "";
      
      public function SongInfoEntry(param1:int, param2:int, param3:String, param4:String, param5:String)
      {
         super(param1,param2,param3,param4);
         _data = param5;
      }
      
      public function get data() : String
      {
         return _data;
      }
   }
}

