package com.sulake.habbo.sound.events
{
   import flash.events.Event;
   
   public class TraxSongLoadEvent extends Event
   {
      public static const TRAX_LOAD_COMPLETE:String = "TSLE_TRAX_LOAD_COMPLETE";
      
      public static const TRAX_LOAD_FAILED:String = "TSLE_TRAX_LOAD_FAILED";
      
      private var _id:int;
      
      public function TraxSongLoadEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _id = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}

